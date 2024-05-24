/datum/advclass/rogue
	name = "Rogue"
	tutorial = "Rogues are men of shadows, and commonly associated with banditry. Most are usually akin to criminals, \
	and those who aren't are usually treated as such anyway, \
	they are most commonly associated with the god Xylix due to their skills in thievery"
	allowed_sexes = list("male", "female")
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
	outfit = /datum/outfit/job/roguetown/adventurer/rogue
	traits_applied = list(RTRAIT_MEDIUMARMOR)

	given_skills = list(
		/datum/skill/combat/swords = 3, \
		/datum/skill/combat/axesmaces = 2, \
		/datum/skill/combat/crossbows = list(2,3,3), \
		/datum/skill/misc/athletics = 4, \
		/datum/skill/combat/bows = 3, \
		/datum/skill/combat/wrestling = 3, \
		/datum/skill/combat/unarmed = 3, \
		/datum/skill/combat/knives = 4, \
		/datum/skill/combat/polearms = 1, \
		/datum/skill/misc/swimming = 3, \
		/datum/skill/misc/climbing = list(5,6), \
		/datum/skill/craft/crafting = 1, \
		/datum/skill/misc/reading = list(0,1,1,1), \
		/datum/skill/craft/traps = 2, \
		/datum/skill/misc/medicine = list(0,1), \
		/datum/skill/misc/sneaking = 5, \
		/datum/skill/misc/stealing = 5, \
		/datum/skill/misc/riding = list(1,2), \
		/datum/skill/craft/engineering = 1
	)

	stat_changes = list(
		"strength" = -1, 
		"perception" = 2,
		"speed" = list(3,4),
		"intelligence" =2,
	)

/datum/outfit/job/roguetown/adventurer/rogue
	allowed_patrons = list(/datum/patron/divine/xylix, /datum/patron/inhumen/matthios)

/datum/outfit/job/roguetown/adventurer/rogue/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/boots
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	H.mind.assign_experiences(/datum/advclass/rogue::given_skills, TRUE, "skills")
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	gloves = /obj/item/clothing/gloves/roguetown/leather
	if(prob(30))
		gloves = /obj/item/clothing/gloves/roguetown/fingerless
	belt = /obj/item/storage/belt/rogue/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather
	cloak = /obj/item/clothing/cloak/raincloak/mortus
	backl = /obj/item/storage/backpack/rogue/satchel
	beltr = /obj/item/rogueweapon/huntingknife/idagger/steel
	beltl = /obj/item/rogueweapon/huntingknife/idagger/steel
	ADD_TRAIT(H, RTRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	H.mind.assign_experiences(/datum/advclass/rogue::stat_changes, TRUE, "stats")
