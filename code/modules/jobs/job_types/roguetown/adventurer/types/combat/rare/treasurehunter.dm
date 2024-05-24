//dagger and huntknife
/datum/advclass/gravedigger
	name = "Treasure Hunter"
	tutorial = "Grave robbers sell themselves as treasure hunters, but be sure to wipe that \
	necrotic flesh off of that trinket you found."
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
	outfit = /datum/outfit/job/roguetown/adventurer/gravedigger
	pickprob = 11
	traits_applied = list(RTRAIT_NOSTINK)

	given_skills = list(
        /datum/skill/combat/axesmaces = 1, 
        /datum/skill/combat/wrestling = 1, 
        /datum/skill/combat/knives = 2, 
        /datum/skill/combat/unarmed = 1, 
        /datum/skill/craft/crafting = 1, 
        /datum/skill/misc/reading = 2, 
        /datum/skill/misc/swimming = 2, 
        /datum/skill/misc/climbing = 4
)
	stat_changes = list(
        "strength" = 1, 
        "perception" = 1, 
        "intelligence" = -2
)

/datum/outfit/job/roguetown/adventurer/gravedigger/pre_equip(mob/living/carbon/human/H)
	..()
	pants = /obj/item/clothing/under/roguetown/tights/black
	armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/black
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
	backr = /obj/item/storage/backpack/rogue/satchel
	belt = /obj/item/storage/belt/rogue/leather/rope
	backpack_contents = list(/obj/item/bait = 1)
	gloves = /obj/item/clothing/gloves/roguetown/fingerless
	cloak = /obj/item/clothing/cloak/raincloak/mortus
	armor = /obj/item/clothing/suit/roguetown/armor/chainmail
	shoes = /obj/item/clothing/shoes/roguetown/boots
	beltr = /obj/item/storage/belt/rogue/pouch/coins/mid
	beltl = /obj/item/rogueweapon/huntingknife
	backr = /obj/item/rogueweapon/shovel
	head = /obj/item/clothing/head/roguetown/puritan
	if(H.mind)
		H.mind.assign_experiences(/datum/advclass/gravedigger::given_skills, TRUE, "skills")
		H.mind.assign_experiences(/datum/advclass/gravedigger::stat_changes, TRUE, "stats")

