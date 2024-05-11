/datum/job/roguetown/apothecary
	title = "Apothecary"
	flag = APOTHECARY
	department_flag = SERFS
	faction = "Station"
	total_positions = 0
	spawn_positions = 0

	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Argonian",
		"Dark Elf",
		"Aasimar"
	)
	
	outfit = /datum/outfit/job/roguetown/apothecary
	outfit_female = /datum/outfit/job/roguetown/apothecary/female
	display_order = 6
	min_pq = -10

/datum/outfit/job/roguetown/apothecary
	name = "Apothecary"
	jobtype = /datum/job/roguetown/apothecary

	pants = /obj/item/clothing/under/roguetown/tights
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	armor = /obj/item/clothing/suit/roguetown/shirt/rags
	shoes = /obj/item/clothing/shoes/roguetown/boots

/datum/outfit/job/roguetown/apothecary/female
	name = "Apothecary"
	jobtype = /datum/job/roguetown/apothecary

	pants = null
