/datum/advclass/dbomb
	name = "Vagrant"
	tutorial = "Dwarves like to blow things up."
	allowed_sexes = list("male", "female")
	allowed_races = list("Dwarf")
	outfit = /datum/outfit/job/roguetown/adventurer/dbomb
	traits_applied = list(RTRAIT_HEAVYARMOR)

	stat_changes = list(
		"strength" = 1,
		"endurance" = 1
		)

	given_skills = list(
		/datum/skill/combat/axesmaces = 3,
		/datum/skill/combat/unarmed = 2,
		/datum/skill/combat/wrestling = 2,
		/datum/skill/craft/crafting = 4,
		/datum/skill/misc/swimming = 1,
		/datum/skill/misc/climbing = 1,
		/datum/skill/misc/sewing = 1,
		/datum/skill/misc/athletics = 1,
		/datum/skill/misc/medicine = 1
	)


/datum/outfit/job/roguetown/adventurer/dbomb/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/armingcap/dwarf
	if(prob(30))
		head = /obj/item/clothing/head/roguetown/helmet/horned
	pants = /obj/item/clothing/under/roguetown/trou
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	belt = /obj/item/storage/belt/rogue/leather
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	beltl = /obj/item/rogueweapon/huntingknife
	armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	backl = /obj/item/storage/backpack/rogue/backpack
	backpack_contents = list(/obj/item/bomb = 1, /obj/item/flint = 1)
	if(prob(50))
		beltr = /obj/item/rogueweapon/pick
	else
		beltr = /obj/item/rogueweapon/hammer
	if(prob(50))
		shoes = /obj/item/clothing/shoes/roguetown/boots/leather

	H.mind.assign_experiences(/datum/advclass/dbomb::given_skills, TRUE, "skills")
	H.mind.assign_experiences(/datum/advclass/dbomb::stat_changes, TRUE, "stats")

