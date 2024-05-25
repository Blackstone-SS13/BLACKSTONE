
/datum/advclass/puritan
	name = "Witch Hunter"
	tutorial = "Witch Hunters belong to a special sect of the One-God Church that believe all magyk \
	use is inherently sinful. They are extremely devoted to hunting necromancers and often preach \
	to magyk users to end their sinful ways."
	allowed_sexes = list("male")
	allowed_races = list("Humen")
	outfit = /datum/outfit/job/roguetown/adventurer/puritan
	maxchosen = 2
	pickprob = 11
	traits_applied = list(RTRAIT_MEDIUMARMOR)

	given_skills = list(
        /datum/skill/combat/swords = list(4,5), 
        /datum/skill/combat/axesmaces = 3, 
        /datum/skill/combat/crossbows = 3, 
        /datum/skill/combat/bows = 2, 
        /datum/skill/misc/athletics = 3, 
        /datum/skill/combat/wrestling = 3, 
        /datum/skill/combat/unarmed = 3, 
        /datum/skill/combat/knives = 3, 
        /datum/skill/combat/polearms = 3, 
        /datum/skill/misc/swimming = 2, 
        /datum/skill/misc/climbing = 2, 
        /datum/skill/misc/reading = 2, 
        /datum/skill/misc/sewing = 2, 
        /datum/skill/labor/butchering = 2, 
        /datum/skill/craft/traps = 2, 
        /datum/skill/misc/medicine = 2, 
        /datum/skill/misc/sneaking = 2, 
        /datum/skill/combat/whipsflails = list(4,5)
)

	stat_changes = list(
        "intelligence" = 1, 
        "strength" = 1, 
        "endurance" = 1, 
        "speed" = 1, 
        "constitution" = 1, 
        "perception" = 2
)



/datum/outfit/job/roguetown/adventurer/puritan
	allowed_patrons = list(/datum/patron/old_god)

/datum/outfit/job/roguetown/adventurer/puritan/pre_equip(mob/living/carbon/human/H)
	..()
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/puritan
	belt = /obj/item/storage/belt/rogue/leather
	neck = /obj/item/clothing/neck/roguetown/psicross/silver
	shoes = /obj/item/clothing/shoes/roguetown/boots
	pants = /obj/item/clothing/under/roguetown/tights/black
	cloak = /obj/item/clothing/cloak/cape/puritan
	beltr = /obj/item/storage/belt/rogue/pouch/coins/mid
	head = /obj/item/clothing/head/roguetown/puritan
	gloves = /obj/item/clothing/gloves/roguetown/leather
	beltl = /obj/item/rogueweapon/sword/rapier
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/rogueweapon/huntingknife = 1)

	if(H.mind)
		H.mind.assign_experiences(/datum/advclass/puritan::given_skills, TRUE, "skills")
		H.mind.assign_experiences(/datum/advclass/puritan::stat_changes, TRUE, "stats")

	H.verbs |= /mob/living/carbon/human/proc/torture_victim
	H.verbs |= /mob/living/carbon/human/proc/faith_test

	ADD_TRAIT(H, RTRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
