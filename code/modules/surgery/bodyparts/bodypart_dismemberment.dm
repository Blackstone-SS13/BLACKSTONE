
/obj/item/bodypart/proc/can_dismember(obj/item/I)
	return dismemberable

/obj/item/bodypart/proc/can_disable(obj/item/I)
	return disableable

/obj/item/bodypart
	/// Wound we leave on the chest when violently dismembered
	var/dismember_wound
	/// Sound we make when violently dismembered
	var/list/dismemsound = list(
		'sound/combat/dismemberment/dismem (1).ogg',
		'sound/combat/dismemberment/dismem (2).ogg',
		'sound/combat/dismemberment/dismem (3).ogg',
		'sound/combat/dismemberment/dismem (5).ogg',
		'sound/combat/dismemberment/dismem (6).ogg',
	)

//Dismember a limb
/obj/item/bodypart/proc/dismember(dam_type = BRUTE, bclass = BCLASS_CUT, mob/living/user, zone_precise = src.body_zone)
	if(!owner)
		return FALSE
	var/mob/living/carbon/C = owner
	if(!dismemberable)
		return FALSE
	if(user && (body_zone == BODY_ZONE_HEAD) && (zone_precise != BODY_ZONE_PRECISE_NECK))
		return FALSE
	if(C.status_flags & GODMODE)
		return FALSE
	if(HAS_TRAIT(C, TRAIT_NODISMEMBER))
		return FALSE

	var/obj/item/bodypart/affecting = C.get_bodypart(BODY_ZONE_CHEST)
	if(affecting && dismember_wound)
		affecting.add_wound(dismember_wound)
	playsound(C, pick(dismemsound), 50, FALSE, -1)
	if(body_zone == BODY_ZONE_HEAD)
		C.visible_message("<span class='danger'><B>[C] is [pick("BRUTALLY","VIOLENTLY","BLOODILY","MESSILY")] DECAPITATED!</B></span>")
	else
		C.visible_message("<span class='warning'><B>The [src.name] is [pick("torn off", "sundered", "severed", "seperated", "unsewn")]!</B></span>")
		C.emote("painscream")
	src.add_mob_blood(C)
	SEND_SIGNAL(C, COMSIG_ADD_MOOD_EVENT, "dismembered", /datum/mood_event/dismembered)
	C.add_stress(/datum/stressevent/dismembered)
	var/stress2give = /datum/stressevent/viewdismember
	if(C)
		if(C.buckled)
			if(istype(C.buckled, /obj/structure/fluff/psycross))
				if(C.real_name in GLOB.excommunicated_players)
					stress2give = /datum/stressevent/viewsinpunish
	if(stress2give)
		for(var/mob/living/carbon/CA in hearers(world.view, C))
			if(CA != C && !HAS_TRAIT(CA, TRAIT_BLIND))
				if(stress2give == /datum/stressevent/viewdismember)
					if(HAS_TRAIT(CA, TRAIT_STEELHEARTED))
						continue
					if(CA.gender == FEMALE)
						CA.add_stress(/datum/stressevent/fviewdismember)
						continue
				CA.add_stress(stress2give)
	if(grabbedby)
		qdel(grabbedby)
		grabbedby = null
	drop_limb()

	if(dam_type == BURN)
		burn()
		return TRUE
	
	var/turf/location = C.loc
	if(istype(location))
		C.add_splatter_floor(location)
	var/direction = pick(GLOB.cardinals)
	var/t_range = rand(2,max(throw_range/2, 2))
	var/turf/target_turf = get_turf(src)
	for(var/i in 1 to t_range-1)
		var/turf/new_turf = get_step(target_turf, direction)
		if(!new_turf)
			break
		target_turf = new_turf
		if(new_turf.density)
			break
	throw_at(target_turf, throw_range, throw_speed)
	return TRUE

/obj/item/bodypart/chest/dismember(dam_type = BRUTE, bclass = BCLASS_CUT, mob/living/user, zone_precise = src.body_zone)
	if(!owner)
		return FALSE
	var/mob/living/carbon/C = owner
	if(!dismemberable)
		return FALSE
	if(skeletonized)
		return FALSE
	if(HAS_TRAIT(C, TRAIT_NODISMEMBER))
		return FALSE
	. = list()
	var/organ_spilled = 0
	var/turf/T = get_turf(C)
	C.add_splatter_floor(T)
	playsound(C, 'sound/combat/crit2.ogg', 100, FALSE, 5)
	C.emote("painscream")
	for(var/X in C.internal_organs)
		var/obj/item/organ/O = X
		var/org_zone = check_zone(O.zone)
		if(org_zone != BODY_ZONE_CHEST)
			continue
		O.Remove(C)
		O.forceMove(T)
		O.add_mob_blood(C)
		organ_spilled = 1
		. += X
	if(cavity_item)
		cavity_item.forceMove(T)
		. += cavity_item
		cavity_item = null
		organ_spilled = 1

	if(organ_spilled)
		C.visible_message("<span class='danger'><B>[C] spills [C.p_their()] guts!</B></span>")
	return TRUE

//limb removal. The "special" argument is used for swapping a limb with a new one without the effects of losing a limb kicking in.
/obj/item/bodypart/proc/drop_limb(special)
	if(!owner)
		return
	testing("begin drop limb")
	var/atom/drop_location = owner.drop_location()
	var/mob/living/carbon/was_owner = owner
	update_limb(dropping_limb = TRUE)

	if(length(wounds))
		var/list/stored_wounds = list()
		for(var/datum/wound/wound as anything in wounds)
			wound.remove_from_bodypart()
			stored_wounds += wound //store for later when the limb is reattached
		wounds = stored_wounds
	for(var/datum/surgery/surgery as anything in was_owner.surgeries) //if we had an ongoing surgery on that limb, we stop it.
		if(surgery.operated_bodypart == src)
			was_owner.surgeries -= surgery
			qdel(surgery)
	for(var/obj/item/embedded in embedded_objects)
		embedded_objects -= embedded
		if(drop_location)
			embedded.forceMove(drop_location)
		else
			qdel(embedded)
	if(bandage)
		if(drop_location)
			bandage.forceMove(drop_location)
		else
			qdel(bandage)
		bandage = null
	if(!was_owner.has_embedded_objects())
		was_owner.clear_alert("embeddedobject")
		SEND_SIGNAL(was_owner, COMSIG_CLEAR_MOOD_EVENT, "embedded")

	if(!special)
		if(was_owner.dna)
			//some mutations require having specific limbs to be kept.
			for(var/datum/mutation/human/mutation as anything in was_owner.dna.mutations)
				if(mutation.limb_req != body_zone)
					continue
				was_owner.dna.force_lose(mutation)

		for(var/obj/item/organ/organ as anything in was_owner.internal_organs) //internal organs inside the dismembered limb are dropped.
			var/org_zone = check_zone(organ.zone)
			if(org_zone != body_zone)
				continue
			organ.transfer_to_limb(src, was_owner)

	if(held_index)
		was_owner.dropItemToGround(owner.get_item_for_held_index(held_index), force = TRUE)
		was_owner.hand_bodyparts[held_index] = null
	was_owner.bodyparts -= src
	owner = null

	update_icon_dropped()
	was_owner.update_health_hud() //update the healthdoll
	was_owner.update_body()
	was_owner.update_hair()
	was_owner.update_mobility()

	// drop_location = null happens when a "dummy human" used for rendering icons on prefs screen gets its limbs replaced.
	if(!drop_location)
		qdel(src)
		return TRUE

	// pseudoparts shouldn't have organs, but just in case
	if(is_pseudopart)
		drop_organs(was_owner)
		qdel(src)
		return TRUE

	forceMove(drop_location)
	return TRUE

//when a limb is dropped, the internal organs are removed from the mob and put into the limb
/obj/item/organ/proc/transfer_to_limb(obj/item/bodypart/LB, mob/living/carbon/C)
	Remove(C)
	forceMove(LB)
	return TRUE

/obj/item/organ/brain/transfer_to_limb(obj/item/bodypart/head/LB, mob/living/carbon/human/C)
	Remove(C) //Changeling brain concerns are now handled in Remove
	forceMove(LB)
	LB.brain = src
	if(brainmob)
		LB.brainmob = brainmob
		LB.brainmob.forceMove(LB)
		LB.brainmob.stat = DEAD
	brainmob = null
	return TRUE

/obj/item/organ/eyes/transfer_to_limb(obj/item/bodypart/head/LB, mob/living/carbon/human/C)
	LB.eyes = src
	return ..()

/obj/item/organ/ears/transfer_to_limb(obj/item/bodypart/head/LB, mob/living/carbon/human/C)
	LB.ears = src
	return ..()

/obj/item/organ/tongue/transfer_to_limb(obj/item/bodypart/head/LB, mob/living/carbon/human/C)
	LB.tongue = src
	return ..()

/obj/item/bodypart/chest/drop_limb(special)
	if(special)
		return ..()
	return FALSE

/obj/item/bodypart/r_arm/drop_limb(special)
	var/mob/living/carbon/C = owner
	. = ..()
	if(C && !special)
		if(C.handcuffed)
			C.handcuffed.forceMove(drop_location())
			C.handcuffed.dropped(C)
			C.handcuffed = null
			C.update_handcuffed()
		if(C.hud_used)
			var/atom/movable/screen/inventory/hand/R = C.hud_used.hand_slots["[held_index]"]
			if(R)
				R.update_icon()
		if(C.gloves && (C.get_num_arms(FALSE) < 1))
			C.dropItemToGround(C.gloves, force = TRUE)
		C.update_inv_gloves() //to remove the bloody hands overlay
		C.update_inv_armor()


/obj/item/bodypart/l_arm/drop_limb(special)
	var/mob/living/carbon/C = owner
	. = ..()
	if(C && !special)
		if(C.handcuffed)
			C.handcuffed.forceMove(drop_location())
			C.handcuffed.dropped(C)
			C.handcuffed = null
			C.update_handcuffed()
		if(C.hud_used)
			var/atom/movable/screen/inventory/hand/L = C.hud_used.hand_slots["[held_index]"]
			if(L)
				L.update_icon()
		if(C.gloves && (C.get_num_arms(FALSE) < 1))
			C.dropItemToGround(C.gloves, force = TRUE)
		C.update_inv_gloves() //to remove the bloody hands overlay
		C.update_inv_armor()

/obj/item/bodypart/r_leg/drop_limb(special)
	var/mob/living/carbon/C = owner
	. = ..()
	if(C && !special)
		if(C.legcuffed)
			C.legcuffed.forceMove(C.drop_location()) //At this point bodypart is still in nullspace
			C.legcuffed.dropped(C)
			C.legcuffed = null
			C.update_inv_legcuffed()
		if(C.shoes && (C.get_num_legs(FALSE) < 1))
			C.dropItemToGround(C.shoes, force = TRUE)
		C.update_inv_shoes()
		C.update_inv_pants()

/obj/item/bodypart/l_leg/drop_limb(special) //copypasta
	var/mob/living/carbon/C = owner
	. = ..()
	if(C && !special)
		if(C.legcuffed)
			C.legcuffed.forceMove(C.drop_location())
			C.legcuffed.dropped(C)
			C.legcuffed = null
			C.update_inv_legcuffed()
		if(C.shoes && (C.get_num_legs(FALSE) < 1))
			C.dropItemToGround(C.shoes, force = TRUE)
		C.update_inv_shoes()
		C.update_inv_pants()

/obj/item/bodypart/head/drop_limb(special)
	if(!special)
		//Drop all worn head items
		var/list/worn_items = list(
			owner.get_item_by_slot(SLOT_HEAD),
			owner.get_item_by_slot(SLOT_GLASSES),
			owner.get_item_by_slot(SLOT_NECK),
			owner.get_item_by_slot(SLOT_WEAR_MASK),
			owner.get_item_by_slot(SLOT_MOUTH),
		)
		for(var/obj/item/worn_item in worn_items)
			owner.dropItemToGround(worn_item, force = TRUE)

//	owner.ghostize(0)
//	if(brainmob)
//		brainmob.ghostize(0)

	qdel(owner.GetComponent(/datum/component/creamed)) //clean creampie overlay

	//Handle dental implants
	for(var/datum/action/item_action/hands_free/activate_pill/AP in owner.actions)
		AP.Remove(owner)
		var/obj/pill = AP.target
		if(pill)
			pill.forceMove(src)

	//Make sure de-zombification happens before organ removal instead of during it
	var/obj/item/organ/zombie_infection/ooze = owner.getorganslot(ORGAN_SLOT_ZOMBIE)
	if(istype(ooze))
		ooze.transfer_to_limb(src, owner)

	name = "[owner.real_name]'s head"
	. = ..()
	if(brainmob)
		QDEL_NULL(brainmob)
	var/obj/item/organ/brain/BR = locate(/obj/item/organ/brain) in contents
	if(BR)
		if(BR.brainmob)
			QDEL_NULL(BR.brainmob)

//Attach a limb to a human and drop any existing limb of that type.
/obj/item/bodypart/proc/replace_limb(mob/living/carbon/C, special)
	if(!istype(C))
		return
	var/obj/item/bodypart/O = C.get_bodypart(body_zone)
	if(O)
		O.drop_limb(1)
	attach_limb(C, special)

/obj/item/bodypart/head/replace_limb(mob/living/carbon/C, special)
	if(!istype(C))
		return
	var/obj/item/bodypart/head/O = C.get_bodypart(body_zone)
	if(O)
		if(!special)
			return
		else
			O.drop_limb(1)
	attach_limb(C, special)

/obj/item/bodypart/proc/attach_limb(mob/living/carbon/C, special)
	moveToNullspace()
	owner = C
	C.bodyparts += src
	if(held_index)
		if(held_index > C.hand_bodyparts.len)
			C.hand_bodyparts.len = held_index
		C.hand_bodyparts[held_index] = src
		if(C.dna.species.mutanthands && !is_pseudopart)
			C.put_in_hand(new C.dna.species.mutanthands(), held_index)
		if(C.hud_used)
			var/atom/movable/screen/inventory/hand/hand = C.hud_used.hand_slots["[held_index]"]
			if(hand)
				hand.update_icon()
		C.update_inv_gloves()

	if(special) //non conventional limb attachment
		for(var/datum/surgery/surgery as anything in C.surgeries) //if we had an ongoing surgery to attach a new limb, we stop it.
			var/surgery_zone = check_zone(surgery.location)
			if(surgery_zone == body_zone)
				C.surgeries -= surgery
				qdel(surgery)

	for(var/obj/item/organ/stored_organ in src)
		stored_organ.Insert(C)

	for(var/datum/wound/wound as anything in wounds)
		wounds -= wound
		wound.apply_to_bodypart(src)
	
	var/obj/item/bodypart/affecting = C.get_bodypart(BODY_ZONE_CHEST)
	if(affecting && dismember_wound)
		affecting.remove_wound(dismember_wound)

	update_bodypart_damage_state()

	C.updatehealth()
	C.update_body()
	C.update_hair()
	C.update_damage_overlays()
	C.update_mobility()
	return TRUE

/obj/item/bodypart/head/attach_limb(mob/living/carbon/C, special)
	//Transfer some head appearance vars over
	if(brain)
		if(brainmob)
			brainmob.container = null //Reset brainmob head var.
			brainmob.forceMove(brain) //Throw mob into brain.
			brain.brainmob = brainmob //Set the brain to use the brainmob
			brainmob = null //Set head brainmob var to null
		brain.Insert(C) //Now insert the brain proper
		brain = null //No more brain in the head

	if(tongue)
		tongue = null
	if(ears)
		ears = null
	if(eyes)
		eyes = null

	if(ishuman(C))
		var/mob/living/carbon/human/H = C
		H.hair_color = hair_color
		H.hairstyle = hairstyle
		H.facial_hair_color = facial_hair_color
		H.facial_hairstyle = facial_hairstyle
		H.lip_style = lip_style
		H.lip_color = lip_color
	if(real_name)
		C.real_name = real_name
	real_name = ""
	name = initial(name)

	//Handle dental implants
	for(var/obj/item/reagent_containers/pill/P in src)
		for(var/datum/action/item_action/hands_free/activate_pill/AP in P.actions)
			P.forceMove(C)
			AP.Grant(C)
			break

	return ..()

//Regenerates all limbs. Returns amount of limbs regenerated
/mob/living/proc/regenerate_limbs(noheal, excluded_limbs)
	return 0

/mob/living/carbon/regenerate_limbs(noheal, list/excluded_limbs)
	var/list/limb_list = list(BODY_ZONE_HEAD, BODY_ZONE_CHEST, BODY_ZONE_R_ARM, BODY_ZONE_L_ARM, BODY_ZONE_R_LEG, BODY_ZONE_L_LEG)
	if(excluded_limbs)
		limb_list -= excluded_limbs
	for(var/Z in limb_list)
		. += regenerate_limb(Z, noheal)

/mob/living/proc/regenerate_limb(limb_zone, noheal)
	return

/mob/living/carbon/regenerate_limb(limb_zone, noheal)
	var/obj/item/bodypart/L
	if(get_bodypart(limb_zone))
		return 0
	L = newBodyPart(limb_zone, 0, 0)
	if(L)
		if(!noheal)
			L.brute_dam = 0
			L.burn_dam = 0
			L.brutestate = 0
			L.burnstate = 0

		L.attach_limb(src, 1)
		return 1
