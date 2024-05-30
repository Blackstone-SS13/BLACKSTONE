/datum/surgery_step
	/// Name of the surgery step
	var/name
	/// Description of the surgery step
	var/desc
	/// Typepaths or tool behaviors that can be used to perform this surgery step, associated to success chance
	var/list/implements = list()
	/// Typepaths or tool behaviors that can be used to perform this surgery step, associated to speed modification
	var/list/implements_speed = list()
	/// Does the surgery step accept open hand? If true, ignores implements. Compatible with accept_any_item.
	var/accept_hand = FALSE
	/// Does the surgery step accept any item? If true, ignores implements. Compatible with accept_hand.
	var/accept_any_item = FALSE
	/// Silicons will ignore the probability of success and always succeed
	var/silicons_obey_prob = FALSE

	/// How long does the step take for someone with average skill and an average tool?
	var/time = 1 SECONDS
	/// Is this step realized via middle click instead of normal click?
	var/middle_click_step = FALSE
	/// Random surgery flags that mostly indicate additional requirements
	var/surgery_flags = SURGERY_INCISED
	/**
	 * list of chems needed to complete the step. 
	 * Even on success, the step will have no effect if there aren't the chems required in the mob.
	 */
	var/list/chems_needed
	/// Any chem on the list required, or all of them?
	var/require_all_chems = TRUE
	/// This surgery ignores clothes
	var/ignore_clothes = FALSE
	/// Does this step require a non-missing bodypart? Incompatible with requires_missing_bodypart
	var/requires_bodypart = TRUE
	/// Does this step require the bodypart to be missing? (Limb attachment)
	var/requires_missing_bodypart = TRUE
	/// If true, this surgery step cannot be done on pseudo limbs (like chainsaw arms)
	var/requires_real_bodypart = FALSE
	/// What type of bodypart we require, in case requires_bodypart
	var/requires_bodypart_type = BODYPART_ORGANIC
	/// Does the patient need to be lying down?
	var/lying_required = FALSE
	/// Does this step allow self surgery?
	var/self_operable = TRUE
	/// Body zones this surgery can be performed on, set to null for everywhere
	var/list/possible_locs
	/// Acceptable mob types for this surgery
	var/list/target_mobtypes = list(/mob/living/carbon)
	/// Skill used to perform this surgery step
	var/skill_used = /datum/skill/misc/medicine
	/// Necessary skill MINIMUM to perform this surgery step, of skill_used
	var/skill_min = SKILL_LEVEL_EXPERT
	/// Handles techweb-oriented surgeries
	var/requires_tech = FALSE
	/**
	 * type; doesn't show up if this type exists. 
	 * Set to /datum/surgery_step if you want to hide a "base" surgery  (useful for typing parents IE healing.dm just make sure to null it out again)
	 */
	var/replaced_by

/datum/surgery_step/proc/can_do_step(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent, try_to_fail = FALSE)
	if(!user || !target)
		return FALSE
	if(!user.Adjacent(target))
		return FALSE
	if(!tool_check(user, tool))
		return FALSE
	if(!validate_tech(user, target, target_zone))
		return FALSE
	if(!validate_user(user, target, target_zone))
		return FALSE
	if(!validate_target(user, target, target_zone))
		return FALSE

	return TRUE

/datum/surgery_step/proc/validate_tech(mob/user, mob/living/target, target_zone)
	// Always return false in this case
	if(replaced_by == /datum/surgery_step)
		return FALSE
	
	// True surgeons (like abductor scientists) need no instructions
	if(HAS_TRAIT(user, TRAIT_SURGEON) || (user.mind && HAS_TRAIT(user.mind, TRAIT_SURGEON)))
		// only show top-level surgeries
		if(replaced_by)
			return FALSE
		return TRUE

	if(!requires_tech && !replaced_by)
		return TRUE

	if(iscyborg(user))
		var/mob/living/silicon/robot/robot = user
		var/obj/item/surgical_processor/surgical_processor = locate() in robot.module?.modules
		// No early return for !surgical_processor since we want to check optable should this not exist.
		if(surgical_processor)
			if(replaced_by in surgical_processor.advanced_surgeries)
				return FALSE
			if(type in surgical_processor.advanced_surgeries)
				return TRUE

	var/turf/target_turf = get_turf(target)

	// Get the relevant operating computer
	var/obj/machinery/computer/operating/opcomputer
	var/obj/structure/table/optable/table = locate(/obj/structure/table/optable) in target_turf
	if(table?.computer)
		opcomputer = table.computer
	else
		var/obj/machinery/stasis/the_stasis_bed = locate(/obj/machinery/stasis) in target_turf
		if(the_stasis_bed?.op_computer)
			opcomputer = the_stasis_bed.op_computer

	if(!opcomputer)
		return FALSE
	if(opcomputer.stat & (NOPOWER|BROKEN))
		return FALSE
	if(replaced_by in opcomputer.advanced_surgeries)
		return FALSE
	if(type in opcomputer.advanced_surgeries)
		return TRUE
	return FALSE

/datum/surgery_step/proc/validate_user(mob/user, mob/living/target, target_zone)
	SHOULD_CALL_PARENT(TRUE)
	if(possible_locs && !(target_zone in possible_locs))
		return FALSE
	if(skill_used && skill_min && (user.mind?.get_skill_level(skill_used) < skill_min))
		return FALSE
	return TRUE

/datum/surgery_step/proc/validate_target(mob/user, mob/living/target, target_zone)
	SHOULD_CALL_PARENT(TRUE)
	if(!self_operable && (user == target))
		return FALSE
	
	if(target_mobtypes)
		var/valid_mobtype = FALSE
		for(var/mobtype in target_mobtypes)
			if(istype(target, mobtype))
				valid_mobtype = TRUE
				break
		if(!valid_mobtype)
			return FALSE
	
	if(lying_required && (target.mobility_flags & MOBILITY_STAND))
		return FALSE
	
	if(iscarbon(target))
		var/mob/living/carbon/carbon_target = target
		var/obj/item/bodypart/bodypart = carbon_target.get_bodypart(check_zone(target_zone))
		if(!validate_bodypart(user, target, bodypart))
			return FALSE
	
	//no surgeries in the same body zone
	if(target.surgeries[target_zone])
		return FALSE

	return TRUE

/datum/surgery_step/proc/validate_bodypart(mob/user, mob/living/carbon/target, obj/item/bodypart/bodypart)
	if(requires_bodypart && !bodypart)
		return FALSE
	else if(!requires_bodypart)
		if(requires_missing_bodypart && bodypart)
			return FALSE
		return TRUE
	
	if(requires_bodypart_type && (bodypart.status != requires_bodypart_type))
		return FALSE
	
	var/bodypart_flags = bodypart.get_surgery_flags()
	if((surgery_flags & SURGERY_ENCASED) && !(bodypart_flags & SURGERY_ENCASED))
		return FALSE
	if((surgery_flags & SURGERY_INCISED) && !(bodypart_flags & SURGERY_INCISED))
		return FALSE
	if((surgery_flags & SURGERY_NOT_INCISED) && (bodypart_flags & SURGERY_INCISED))
		return FALSE
	if((surgery_flags & SURGERY_RETRACTED) && !(bodypart_flags & SURGERY_RETRACTED))
		return FALSE
	if((surgery_flags & SURGERY_DRILLED) && !(bodypart_flags & SURGERY_DRILLED))
		return FALSE
	if((surgery_flags & SURGERY_BROKEN) && !(bodypart_flags & SURGERY_BROKEN))
		return FALSE
	
	if(user == target)
		var/obj/item/bodypart/active_hand = user.get_active_hand()
		if(active_hand)
			var/static/list/r_hand_zones = list(BODY_ZONE_R_ARM, BODY_ZONE_PRECISE_R_HAND)
			var/static/list/l_hand_zones = list(BODY_ZONE_L_ARM, BODY_ZONE_PRECISE_L_HAND)
			if((active_hand?.body_zone in r_hand_zones) && (bodypart.body_zone in r_hand_zones))
				return FALSE
			if((active_hand?.body_zone in l_hand_zones) && (bodypart.body_zone in l_hand_zones))
				return FALSE
	
	if(!ignore_clothes && !get_location_accessible(target, target_zone))
		return FALSE
	
	return TRUE

/datum/surgery_step/proc/tool_check(mob/user, obj/item/tool)
	SHOULD_CALL_PARENT(TRUE)
	var/implement_type = FALSE
	if(accept_hand && (!tool || iscyborg(user)))
		implement_type = TOOL_HAND

	if(tool)
		for(var/key in implements)
			var/match = FALSE
			if(ispath(key) && istype(tool, key))
				implement_type = key
				break
			else if(tool.tool_behaviour == key)
				implement_type = key
				break
		if(!implement_type && accept_any_item)
			implement_type = TOOL_NONE

	return implement_type

/datum/surgery_step/proc/chem_check(mob/living/target)
	if(!LAZYLEN(chems_needed))
		return TRUE

	if(require_all_chems)
		for(var/reagent_needed in chems_needed)
			if(!target.reagents.has_reagent(reagent_needed))
				return FALSE
		return TRUE

	for(var/reagent_needed in chems_needed)
		if(target.reagents.has_reagent(reagent_needed))
			return TRUE
	
	return FALSE

/// Returns a string of the chemicals needed for this surgery step
/datum/surgery_step/proc/get_chem_string()
	if(!LAZYLEN(chems_needed))
		return
	var/list/chems = list()
	for(var/R in chems_needed)
		var/datum/reagent/temp = GLOB.chemical_reagents_list[R]
		if(temp)
			var/chemname = temp.name
			chems += chemname
	return english_list(chems, and_text = require_all_chems ? " and " : " or ")

/datum/surgery_step/proc/try_op(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent, try_to_fail = FALSE)
	var/success = can_do_step(user, target, target_zone, tool, intent, try_to_fail)
	if(!success)
		return FALSE

	initiate(user, target, target_zone, tool, intent, try_to_fail)
	return TRUE	//returns TRUE so we don't stab the guy in the dick or wherever.

#define SURGERY_SLOWDOWN_CAP_MULTIPLIER 2 //increase to make surgery slower but fail less, and decrease to make surgery faster but fail more

/datum/surgery_step/proc/initiate(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent, try_to_fail = FALSE)
	target.surgeries[target_zone] = src
	if(preop(user, target, target_zone, tool, surgery) == SURGERY_FAILURE)
		target.surgeries -= target_zone
		return SURGERY_FAILURE

	var/speed_mod = get_speed_modifier(user, target, target_zone, tool, intent, try_to_fail)
	var/success_prob = get_success_probability(user, target, target_zone, tool, intent, try_to_fail)
	var/advance = FALSE

	var/modded_time = round(time * speed_mod, 1)
	if(do_after(user, time, target = target))
		var/success = prob(success_prob) && chem_check(target)
		if((prob(100-fail_prob) || (iscyborg(user) && !silicons_obey_prob)) && chem_check_result && !try_to_fail)
			if(success(user, target, target_zone, tool, surgery))
				advance = TRUE
		else
			if(failure(user, target, target_zone, tool, surgery, fail_prob))
				advance = TRUE
			if(chem_check_result)
				if(.(user, target, target_zone, tool, surgery, try_to_fail)) //automatically re-attempt if failed for reason other than lack of required chemical
					advance = TRUE
		if(advance && !repeatable)
			surgery.status++
			if(surgery.status > surgery.steps.len)
				surgery.complete()

	return advance

/datum/surgery_step/proc/get_speed_modifier(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent, try_to_fail = FALSE)
	var/speed_mod = 1
	if(tool)
		speed_mod *= tool.toolspeed
	if(implement_speeds)
		var/implement_type = tool_check(user, tool)
		if(implement_type)
			speed_mod *= implements_speed[implement_type] || 1
	speed_mod *= get_location_modifier(target)

	return speed_mod

/datum/surgery_step/proc/get_success_probability(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	var/success_prob = 100
	if(implements)
		var/implement_type = tool_check(user, tool)
		if(implement_type)
			success_prob *= implements[implement_type] || 1
	success_prob *= get_location_modifier(target)

	return success_prob

/datum/surgery_step/proc/get_skill_modifier(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	if(!skill_used)
		return 1
	var/modifier = 1
	return modifier

/datum/surgery_step/proc/get_location_modifier(mob/living/target)
	var/turf/patient_turf = get_turf(target)
	if(locate(/obj/structure/table/optable) in patient_turf)
		return 1
	else if(locate(/obj/machinery/stasis) in patient_turf)
		return 0.9
	else if(locate(/obj/structure/table) in patient_turf)
		return 0.8
	else if(locate(/obj/structure/bed) in patient_turf)
		return 0.7
	return 0.5

/datum/surgery_step/proc/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	display_results(user, target, "<span class='notice'>I begin to perform surgery on [target]...</span>",
		"<span class='notice'>[user] begins to perform surgery on [target].</span>",
		"<span class='notice'>[user] begins to perform surgery on [target].</span>")

/datum/surgery_step/proc/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	display_results(user, target, "<span class='notice'>I succeed.</span>",
		"<span class='notice'>[user] succeeds!</span>",
		"<span class='notice'>[user] finishes.</span>")
	return TRUE

/datum/surgery_step/proc/failure(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent, fail_prob = 0)
	var/screwedmessage = ""
	switch(fail_prob)
		if(0 to 24)
			screwedmessage = " <i>I almost had it.</i>"
		if(50 to 74)//25 to 49 = no extra text
			screwedmessage = " This is hard to get right in these conditions..."
		if(75 to 99)
			screwedmessage = " <b>This is practically impossible in these conditions...</b>"

	display_results(user, target, "<span class='warning'>I screw up![screwedmessage]</span>",
		"<span class='warning'>[user] screws up!</span>",
		"<span class='notice'>[user] finishes.</span>", TRUE) //By default the patient will notice if the wrong thing has been cut
	return FALSE

/// Replaces visible_message during operations so only people looking over the surgeon can tell what they're doing, allowing for shenanigans.
/datum/surgery_step/proc/display_results(mob/user, mob/living/carbon/target, self_message, detailed_message, vague_message, target_detailed = FALSE)
	var/list/detailed_mobs = get_hearers_in_view(1, user) //Only the surgeon and people looking over his shoulder can see the operation clearly
	if(!target_detailed)
		detailed_mobs -= target //The patient can't see well what's going on, unless it's something like getting cut
	user.visible_message(detailed_message, self_message, vision_distance = 1, ignored_mobs = target_detailed ? null : target)
	user.visible_message(vague_message, "", ignored_mobs = detailed_mobs)
	return TRUE
