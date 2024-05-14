/*
	TO BE UNTICKED IF THESE PEOPLE EVER ACTUALLY MAKE PLAYABLE GOBLINS ELSEWHERE
	5/11/2024
*/
/*
/datum/triumph_buy/goblin_class
	triumph_buy_id = "Goblins"
	desc = "A sixpack of goblins for one person. WARNING: MAY BE BUGGY"
	triumph_cost = 5
	category = TRIUMPH_CAT_CHARACTER
	pre_round_only = FALSE // Whether its pre-round only
	visible_on_active_menu = FALSE

// We fire this on activate
/datum/triumph_buy/goblin_class/on_activate()
	
	if(!SSrole_class_handler.special_session_queue[ckey_of_buyer])
		SSrole_class_handler.special_session_queue[ckey_of_buyer] = list()

	var/datum/advclass/goblin/turbo_slop
	if(!SSrole_class_handler.special_session_queue[ckey_of_buyer][triumph_buy_id])
		turbo_slop = new()
		turbo_slop.maximum_possible_slots = 6
		SSrole_class_handler.special_session_queue[ckey_of_buyer][triumph_buy_id] = turbo_slop
	else
		turbo_slop = SSrole_class_handler.special_session_queue[ckey_of_buyer][triumph_buy_id]
		turbo_slop.maximum_possible_slots += 6

// It should be there you know? lol 
// If not we are desyncing somehow
/datum/triumph_buy/goblin_class/on_removal()
	SSrole_class_handler.special_session_queue[ckey_of_buyer].Remove(triumph_buy_id)

//For triumph buy goblins
/datum/advclass/goblin
	name = "Goblin"
	tutorial = "This is a goblin of the green variety, the kind you can see anywhere really."
	allowed_sexes = list("male", "female")
	allowed_races = list("Humen",
	"Elf",
	"Dark Elf",
	"Half-Elf",
	"Tiefling",
	"Dwarf",
	"Dwarf",
	"Aasimar"
	)
	maximum_possible_slots = 0

	outfit = null

	category_flags = RT_TYPE_DISABLED_CLASS

/datum/advclass/goblin/extra_slop_proc_ending(mob/living/carbon/human/H)
	var/mob/living/carbon/human/species/goblin/target_goblin = new(H.loc)
	H.mind.transfer_to(target_goblin)
	qdel(H)
*/
