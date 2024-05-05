/*
	TO NOTE THERE WILL BE A LOT OF SNOWFLAKE BEHAVIOR
*/


/datum/triumph_buy
	var/key_of_buyer = null // Key of the person who bought it.
	var/ckey_of_buyer = null //ckey of the person who bought it. I don't feel like dealing with the fact zeth used key for triumphs

	var/desc = "ERROR  " // desc shown for it on the menu
	var/triumph_cost = 107 // cost in triumphs for something
	var/category = TRIUMPH_CAT_ACTIVE_DATUMS // category we sort something into
	var/visible_on_active_menu = FALSE // Whether we are visible on active menu
	var/pre_round_only = FALSE // Whether its pre-round only

	var/list/conflicts_with = list() // List of things it can conflict with

	
	var/fire_on_buy = FALSE // If we fire right after we buy the datum

	var/fire_on_PostSetup = FALSE // If we fire on roundstart

// We fire this on activate
/datum/triumph_buy/proc/on_activate(mob/living/carbon/human/H)
	return

// We fire this after the round starts
/datum/triumph_buy/proc/on_PostSetup()
	return
