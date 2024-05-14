/datum/triumph_buy/pick_any_class
	triumph_buy_id = "PickAny"
	desc = "Get single run of a class that can pick any class on the vagrant class selection! WARNING: MAY BE BUGGY"
	triumph_cost = 10
	category = TRIUMPH_CAT_CHARACTER
	pre_round_only = FALSE
	visible_on_active_menu = FALSE

// We fire this on activate, also DAMN is this nasty
/datum/triumph_buy/pick_any_class/on_activate()
	if(!SSrole_class_handler.special_session_queue[ckey_of_buyer])
		SSrole_class_handler.special_session_queue[ckey_of_buyer] = list()

	var/datum/advclass/pick_everything/turbo_slop
	if(!SSrole_class_handler.special_session_queue[ckey_of_buyer][triumph_buy_id])
		turbo_slop = new()
		turbo_slop.maximum_possible_slots = 6
		SSrole_class_handler.special_session_queue[ckey_of_buyer][triumph_buy_id] = turbo_slop
	else
		turbo_slop = SSrole_class_handler.special_session_queue[ckey_of_buyer][triumph_buy_id]
		turbo_slop.maximum_possible_slots += 6

// It should be there you know? lol 
// If not we are desyncing somehow
/datum/triumph_buy/pick_any_class/on_removal()
	SSrole_class_handler.special_session_queue[ckey_of_buyer].Remove(triumph_buy_id)


//For triumph buy pick-all
/datum/advclass/pick_everything
	name = "Pick-Classes"
	tutorial = "This will open up another menu when you spawn allowing you to pick from any class as long as its not disabled."
	allowed_sexes = list("male", "female")
	allowed_races = list(
	"Humen",
	"Elf",
	"Dark Elf",
	"Half-Elf",
	"Tiefling",
	"Dwarf",
	"Aasimar",
	"Half Orc",
	"Argonian"
	)
	maximum_possible_slots = 0

	outfit = null

	category_flags = RT_TYPE_DISABLED_CLASS

/datum/advclass/pick_everything/extra_slop_proc_ending(mob/living/carbon/human/H)
	var/list/possible_classes = list()
	for(var/datum/advclass/CHECKS in SSrole_class_handler.all_classes)
		if(CHECKS.category_flags & (RT_TYPE_DISABLED_CLASS)) // shits disabled for a reason potentially really bad reasons really.
			continue
		possible_classes += CHECKS

	var/datum/advclass/C = input(H.client, "What is my class?", "Adventure") as null|anything in possible_classes
	C.equipme(H)
