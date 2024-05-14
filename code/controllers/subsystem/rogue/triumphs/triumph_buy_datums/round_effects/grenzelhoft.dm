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
	SStriumphs.post_equip_calls.Remove(triumph_buy_id)

/datum/triumph_buy/grenzelhoft_maximum/on_activate(mob/living/carbon/human/H)
	H.set_species(/datum/species/human/northern)
	H.skin_tone = "fff0e9"
	H.update_body()
