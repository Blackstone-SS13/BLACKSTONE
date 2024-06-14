/datum/surgery/embedded_removal
	name = "Removal of embedded objects"
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/clamp,
		/datum/surgery_step/remove_object,
	)

/datum/surgery_step/remove_object
	name = "Remove embedded objects"
	implements = list(
		TOOL_HEMOSTAT = 80,
		TOOL_HAND = 50,
	)
	time = 3.2 SECONDS
	accept_hand = TRUE
	surgery_flags = SURGERY_INCISED
	skill_min = SKILL_LEVEL_NOVICE
	skill_median = SKILL_LEVEL_NOVICE

/datum/surgery_step/remove_object/validate_bodypart(mob/user, mob/living/carbon/target, obj/item/bodypart/bodypart, target_zone)
	. = ..()
	if(!.)
		return
	return length(bodypart.embedded_objects)

/datum/surgery_step/remove_object/validate_target(mob/user, mob/living/target, target_zone, datum/intent/intent)
	. = ..()
	if(!.)
		return
	return length(target.get_embedded_objects())

/datum/surgery_step/remove_object/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	display_results(user, target, span_notice("I look for objects embedded in [target]'s [parse_zone(user.zone_selected)]..."),
		span_notice("[user] looks for objects embedded in [target]'s [parse_zone(user.zone_selected)]."),
		span_notice("[user] looks for something in [target]'s [parse_zone(user.zone_selected)]."))
	return TRUE

/datum/surgery_step/remove_object/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	var/obj/item/bodypart/bodypart = target.get_bodypart(check_zone(target_zone))
	var/objects = 0
	if(bodypart)
		for(var/obj/item/embedded as anything in bodypart.embedded_objects)
			objects++
			bodypart.remove_embedded_object(embedded)
	for(var/obj/item/embedded as anything in target.simple_embedded_objects)
		objects++
		target.simple_remove_embedded_object(embedded)

	var/s = (objects > 1 ? "s" : "")
	if(objects > 0)
		display_results(user, target, span_notice("I successfully remove [objects] object[s] from [target]'s [bodypart]."),
			span_notice("[user] successfully removes [objects] object[s] from [target]'s [bodypart]!"),
			span_notice("[user] successfully removes [objects] object[s] from [target]'s [bodypart]!"))
	else if(bodypart)
		to_chat(user, span_warning("I find no objects embedded in [target]'s [bodypart]!"))
	else
		to_chat(user, span_warning("I find no objects embedded in [target]!"))
	return TRUE
