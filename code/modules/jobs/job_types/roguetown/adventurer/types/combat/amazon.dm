/datum/advclass/amazon
	name = "Amazon"
	tutorial = "Amazons are warrior-women from the mysterious isle of Issa. These rare fighters are so tough they can beat an average man!"
	allowed_sexes = list("female")
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
	outfit = /datum/outfit/job/roguetown/adventurer/amazon
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)
	pickprob = 13
	maxchosen = 2
	traits_applied = list(RTRAIT_CRITICAL_RESISTANCE, TRAIT_NOPAINSTUN, TRAIT_STEELHEARTED)


	given_skills = list(
		/datum/skill/combat/polearms = 3, \
		/datum/skill/combat/swords = 1, \
		/datum/skill/combat/knives = 1, \
		/datum/skill/combat/bows = 3, \
		/datum/skill/combat/wrestling = 3, \
		/datum/skill/combat/unarmed = 2, \
		/datum/skill/craft/crafting = 1, \
		/datum/skill/misc/swimming = 2, \
		/datum/skill/misc/climbing = 2, \
		/datum/skill/misc/riding = 2, \
		/datum/skill/misc/athletics = 2, \
		/datum/skill/misc/medicine = 1

	)
	stat_changes = list(
        "strength" = 2, 
        "intelligence" = -2, 
        "constitution" = 3, 
        "perception" = 2, 
        "endurance" = 2, 
        "speed" = 1
)

/datum/outfit/job/roguetown/adventurer/amazon/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.assign_experiences(/datum/advclass/amazon::given_skills, TRUE, "skills")
	belt = /obj/item/storage/belt/rogue/leather
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	beltl = /obj/item/rogueweapon/huntingknife
	shoes = /obj/item/clothing/shoes/roguetown/gladiator
	backl = /obj/item/storage/backpack/rogue/satchel
	if(prob(23))
		armor = /obj/item/clothing/suit/roguetown/armor/leather
	if(prob(23))
		armor = /obj/item/clothing/suit/roguetown/armor/leather/hide
	if(prob(50))
		armor = /obj/item/clothing/suit/roguetown/armor/chainmail/chainkini
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	if(prob(50))
		shoes = /obj/item/clothing/shoes/roguetown/boots
	if(prob(75))
		beltr = /obj/item/rogueweapon/sword/iron
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	else
		r_hand = /obj/item/rogueweapon/spear
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
	H.mind.assign_experiences(/datum/advclass/amazon::stat_changes, TRUE, "stats")

	if(H.wear_mask) //for stupid retards with bad eyes
		var/obj/I = H.wear_mask
		H.dropItemToGround(H.wear_mask, TRUE)
		qdel(I)
