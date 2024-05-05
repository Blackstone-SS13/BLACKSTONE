/datum/triumph_buy/goblin_class
	desc = "A sixpack of goblins for one person."
	triumph_cost = 5
	category = TRIUMPH_CAT_CHARACTER
	pre_round_only = FALSE // Whether its pre-round only
	fire_on_buy = TRUE
	visible_on_active_menu = FALSE

// We fire this on activate
/datum/triumph_buy/goblin_class/on_activate()
	var/datum/advclass/goblin/turbo_slop = new()
	turbo_slop.maximum_possible_slots = 6
	SSrole_class_handler.add_to_special_session_queue(ckey_of_buyer, turbo_slop)
	
	

