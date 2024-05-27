/mob/living/carbon/get_wounds()
	. = ..()
	for(var/obj/item/bodypart/bodypart as anything in bodyparts)
		if(!length(bodypart.wounds))
			continue
		. += bodypart.wounds
