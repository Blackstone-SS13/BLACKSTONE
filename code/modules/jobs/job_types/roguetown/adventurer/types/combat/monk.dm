/datum/advclass/monk
	name = "Monk"
	tutorial = "Masters of hand-to-hand combat, Monks are trained in the arts of morality, \
	and try to remain nuetral to the conflict around them unless it interferes with their personal and religious beliefs"
	allowed_sexes = list("male", "female")
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Argonian",
		"Dark Elf",
		"Aasimar",
		"Half Orc"
	)
	outfit = /datum/outfit/job/roguetown/adventurer/monk
	traits_applied = list(RTRAIT_DODGEEXPERT)
	isvillager = FALSE
	ispilgrim = FALSE
	vampcompat = FALSE

	given_skills = list(
		/datum/skill/combat/swords = list(0, 1),
		/datum/skill/misc/athletics = 3,
		/datum/skill/combat/bows = list(0, 1),
		/datum/skill/combat/wrestling = 4,
		/datum/skill/combat/unarmed = 5,
		/datum/skill/combat/knives = 2,
		/datum/skill/combat/polearms = list(1, 2),
		/datum/skill/misc/swimming = 2,
		/datum/skill/misc/climbing = 3,
		/datum/skill/misc/reading = 2,
		/datum/skill/misc/sneaking = list(1, 2),
		/datum/skill/craft/cooking = 1,
		/datum/skill/misc/medicine = 2
	)

	stat_changes = list(
		"strength" = 3,
		"constitution" = 1,
		"speed" = 2,
		"perception" = -1
	)


/datum/outfit/job/roguetown/adventurer/monk/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/roguehood
	neck = /obj/item/clothing/neck/roguetown/psicross
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	cloak = /obj/item/clothing/cloak/raincloak/furcloak/brown
	armor = /obj/item/clothing/suit/roguetown/shirt/robe
	belt = /obj/item/storage/belt/rogue/leather/rope
	beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
	backl = /obj/item/storage/backpack/rogue/backpack
	r_hand = /obj/item/rogueweapon/woodstaff
	if(H.mind)
		to_chat(src, "<span class='warning'>Monks are pilgrims of powerful belief who empart the teachings of their Temple or God by their interactions with the people of the world. A good monk would seek to help travellers on the road, feed the hungry and teach the weak to become strong. A bad one however...</span>")
		H.mind.assign_experiences(/datum/advclass/monk::given_skills, TRUE, "skills")
		H.mind.assign_experiences(/datum/advclass/monk::stat_changes, TRUE, "stats")

		ADD_TRAIT(H, RTRAIT_DODGEEXPERT, TRAIT_GENERIC)

