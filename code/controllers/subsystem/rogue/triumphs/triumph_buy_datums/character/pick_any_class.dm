/datum/triumph_buy/pick_any_class
	desc = "Get single run of a class that can pick any class on the vagrant class selection!"
	triumph_cost = 10
	category = TRIUMPH_CAT_CHARACTER
	pre_round_only = FALSE
	fire_on_buy = TRUE
	visible_on_active_menu = FALSE

// We fire this on activate
/datum/triumph_buy/pick_any_class/on_activate()
	var/datum/advclass/pick_everything/turbo_slop = new()
	turbo_slop.maximum_possible_slots = 1
	SSrole_class_handler.add_to_special_session_queue(ckey_of_buyer, turbo_slop)
