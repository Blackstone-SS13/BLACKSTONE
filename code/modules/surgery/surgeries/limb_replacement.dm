/datum/surgery/augmentation
	name = "Augmentation"
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/clamp,
		/datum/surgery_step/retract,
		/datum/surgery_step/saw,
		/datum/surgery_step/replace_limb,
	)
	target_mobtypes = list(/mob/living/carbon/human)

/datum/surgery_step/replace_limb
	name = "Replace limb"
	implements = list(
		/obj/item/bodypart = 80,
		/obj/item/organ_storage = 80,
	)
	time = 3.2 SECONDS
	surgery_flags = SURGERY_INCISED | SURGERY_RETRACTED | SURGERY_BROKEN
	skill_min = SKILL_LEVEL_APPRENTICE
	skill_median = SKILL_LEVEL_EXPERT

/datum/surgery_step/replace_limb/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	if(istype(tool, /obj/item/organ_storage) && istype(tool.contents[1], /obj/item/bodypart))
		tool = tool.contents[1]
	var/obj/item/bodypart/aug = tool
	if(!istype(aug) || aug.status != BODYPART_ROBOTIC)
		to_chat(user, "<span class='warning'>That's not an augment, silly!</span>")
		return FALSE
	if(aug.body_zone != target_zone)
		to_chat(user, "<span class='warning'>[tool] isn't the right type for [parse_zone(target_zone)].</span>")
		return FALSE
	var/obj/item/bodypart/existing = target.get_bodypart(check_zone(target_zone))
	if(!existing)
		user.visible_message("<span class='notice'>[user] looks for [target]'s [parse_zone(user.zone_selected)].</span>",
							"<span class='notice'>I look for [target]'s [parse_zone(user.zone_selected)]...</span>")
		return FALSE
	display_results(user, target, "<span class='notice'>I begin to augment [target]'s [parse_zone(user.zone_selected)]...</span>",
		"<span class='notice'>[user] begins to augment [target]'s [parse_zone(user.zone_selected)] with [aug].</span>",
		"<span class='notice'>[user] begins to augment [target]'s [parse_zone(user.zone_selected)].</span>")
	return TRUE

/datum/surgery_step/replace_limb/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/obj/item/bodypart/existing = target.get_bodypart(check_zone(target_zone))
	if(existing)
		if(istype(tool, /obj/item/organ_storage))
			tool.icon_state = initial(tool.icon_state)
			tool.desc = initial(tool.desc)
			tool.cut_overlays()
			tool = tool.contents[1]
		var/obj/item/bodypart/bodypart = tool
		if(istype(bodypart) && user.temporarilyRemoveItemFromInventory(bodypart))
			if(bodypart.replace_limb(target, special = TRUE) && bodypart.attach_wound)
				bodypart.add_wound(bodypart.attach_wound)
		display_results(user, target, "<span class='notice'>I successfully augment [target]'s [parse_zone(target_zone)].</span>",
			"<span class='notice'>[user] successfully augments [target]'s [parse_zone(target_zone)] with [bodypart]!</span>",
			"<span class='notice'>[user] successfully augments [target]'s [parse_zone(target_zone)]!</span>")
		log_combat(user, target, "augmented", addition="by giving him new [parse_zone(target_zone)] INTENT: [uppertext(user.a_intent?.name)]")
	else
		to_chat(user, "<span class='warning'>[target] has no organic [parse_zone(target_zone)] there!</span>")
	return TRUE
