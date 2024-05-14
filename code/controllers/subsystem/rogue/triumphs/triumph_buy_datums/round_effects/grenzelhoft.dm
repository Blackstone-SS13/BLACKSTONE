/datum/triumph_buy/grenzelhoft_maximum
	triumph_buy_id = "Grenzelhoftmaxx"
	desc = "Everyone is a human from Grenzelhoft!"
	triumph_cost = 30
	category = TRIUMPH_CAT_ROUND_EFX
	pre_round_only = TRUE
	visible_on_active_menu = TRUE

	// When the goblin buy was enabled this actually worked to stop it from being buyable
	//conflicts_with = list(/datum/triumph_buy/goblin_class)

/datum/triumph_buy/grenzelhoft_maximum/on_buy()
	SStriumphs.post_equip_calls[triumph_buy_id] = src

/datum/triumph_buy/grenzelhoft_maximum/on_removal()
	var/found_duplicate = FALSE
	for(var/datum/triumph_buy/cur_datum in SStriumphs.active_triumph_buy_queue)
		if(cur_datum.category != TRIUMPH_CAT_ROUND_EFX)
			continue
		if(cur_datum == src)
			continue
		if(istype(cur_datum, /datum/triumph_buy/grenzelhoft_maximum))
			found_duplicate = TRUE

	if(!found_duplicate) // If we found a duplicate that isn't us, leave the call in
		SStriumphs.post_equip_calls.Remove(triumph_buy_id)

/datum/triumph_buy/grenzelhoft_maximum/on_activate(mob/living/carbon/human/H)
	H.set_species(/datum/species/human/northern)
	H.skin_tone = "fff0e9"
	H.update_body()
