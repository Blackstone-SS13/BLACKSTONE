/datum/surgery/amputation
	name = "Amputation"
	steps = list(
		/datum/surgery_step/incise, 
		/datum/surgery_step/clamp, 
		/datum/surgery_step/retract, 
		/datum/surgery_step/saw, 
		/datum/surgery_step/amputate,
	)
	possible_locs = list(
		BODY_ZONE_HEAD,
		BODY_ZONE_R_ARM,
		BODY_ZONE_L_ARM,
		BODY_ZONE_R_LEG,
		BODY_ZONE_L_LEG,
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)

/datum/surgery_step/amputate
	name = "Amputate"
	implements = list(
		TOOL_SCALPEL = 75, 
		TOOL_SAW = 60,
		TOOL_SHARP = 40,
	)
	possible_locs = list(
		BODY_ZONE_HEAD,
		BODY_ZONE_R_ARM, 
		BODY_ZONE_L_ARM, 
		BODY_ZONE_R_LEG, 
		BODY_ZONE_L_LEG,
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	time = 6.4 SECONDS
	surgery_flags = SURGERY_INCISED | SURGERY_BROKEN
	requires_bodypart_type = NONE
	skill_min = SKILL_LEVEL_APPRENTICE
	skill_median = SKILL_LEVEL_JOURNEYMAN

/datum/surgery_step/amputate/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	display_results(user, target, "<span class='notice'>I begin to sever [target]'s [parse_zone(target_zone)]...</span>",
		"<span class='notice'>[user] begins to sever [target]'s [parse_zone(target_zone)]!</span>",
		"<span class='notice'>[user] begins to sever [target]'s [parse_zone(target_zone)]!</span>")
	return TRUE

/datum/surgery_step/amputate/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	display_results(user, target, "<span class='notice'>I sever [target]'s [parse_zone(target_zone)].</span>",
		"<span class='notice'>[user] severs [target]'s [parse_zone(target_zone)]!</span>",
		"<span class='notice'>[user] severs [target]'s [parse_zone(target_zone)]!</span>")
	var/obj/item/bodypart/target_limb = target.get_bodypart(check_zone(target_zone))
	target_limb?.drop_limb()
	return TRUE
