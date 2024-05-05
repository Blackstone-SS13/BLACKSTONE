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
