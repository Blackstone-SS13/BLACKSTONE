/datum/triumph_buy/wipe_triumphs
	desc = "Burn down the hall of triumphs! Bring everyone back to ZERO!"
	triumph_cost = 100
	category = TRIUMPH_CAT_MISC
	pre_round_only = FALSE
	visible_on_active_menu = FALSE
	fire_on_buy = TRUE

// We fire this on activate
/datum/triumph_buy/wipe_triumphs/on_activate()
	var/json_file = file("data/triumphs.json")
	WRITE_FILE(json_file, "{}") // Well this seems like a pretty fast solution to wiping triumphs lol
