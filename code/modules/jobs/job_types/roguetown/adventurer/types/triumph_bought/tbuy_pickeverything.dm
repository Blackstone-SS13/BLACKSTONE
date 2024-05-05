//For triumph buy goblins
/datum/advclass/pick_everything
	name = "Pick-Classes"
	tutorial = "This will open up another menu when you spawn allowing you to pick from any class as long as its not disabled."
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

/datum/advclass/pick_everything/extra_slop_proc_ending(mob/living/carbon/human/H)
	var/list/possible_classes = list()
	for(var/datum/advclass/CHECKS in SSrole_class_handler.all_classes)
		if(CHECKS.category_flags & (RT_TYPE_DISABLED_CLASS)) // shits disabled for a reason potentially really bad reasons really.
			continue
		possible_classes += CHECKS

	var/datum/advclass/C = input(H.client, "What is my class?", "Adventure") as null|anything in possible_classes
	C.equipme(H)
