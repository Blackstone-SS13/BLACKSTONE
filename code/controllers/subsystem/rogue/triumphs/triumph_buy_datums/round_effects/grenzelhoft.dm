/datum/triumph_buy/grenzelhoft_maximum
	desc = "Everyone is a human from Grenzelhoft!"
	triumph_cost = 30
	category = TRIUMPH_CAT_ROUND_EFX
	pre_round_only = TRUE
	fire_on_PostSetup = TRUE

	conflicts_with = list(/datum/triumph_buy/goblin_class)

/datum/triumph_buy/grenzelhoft_maximum/on_PostSetup()
	SStriumphs.post_equip_calls += src

/datum/triumph_buy/grenzelhoft_maximum/on_activate(mob/living/carbon/human/H)
	H.set_species(/datum/species/human/northern)
	H.skin_tone = "fff0e9"
	H.update_body()
