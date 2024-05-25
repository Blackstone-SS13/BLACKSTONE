//elf ranger

/datum/advclass/sentinel
	name = "Sentinel"
	tutorial = "Elvish Sentinels are a specialized group of Rangers known for their mastery of bow and blade alike; their arrows are said to contain poisons from the native trees"
	allowed_sexes = list("male", "female")
	allowed_races = list(
		"Elf",
		"Half-Elf",
	)
	outfit = /datum/outfit/job/roguetown/adventurer/sentinal
	maxchosen = 5
	pickprob = 50
	traits_applied = list(RTRAIT_MEDIUMARMOR)
	given_skills = list(
		/datum/skill/combat/knives = 3, \
		/datum/skill/combat/swords = 3, \
		/datum/skill/combat/crossbows = 3, \
		/datum/skill/combat/bows = 5, \
		/datum/skill/craft/tanning = 3, \
		/datum/skill/combat/unarmed = 1, \
		/datum/skill/craft/crafting = 1, \
		/datum/skill/misc/swimming = 2, \
		/datum/skill/misc/climbing = 2, \
		/datum/skill/misc/riding = 3, \
		/datum/skill/misc/sewing = 3, \
		/datum/skill/misc/medicine = 4
	)
	stat_changes = list(
		"perception" = 5, \
		"endurance" = 2
)
	traits_applied = list(RTRAIT_MEDIUMARMOR, RTRAIT_DODGEEXPERT)

/datum/outfit/job/roguetown/adventurer/sentinal/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	
	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/trou/leather
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	else
		pants = /obj/item/clothing/under/roguetown/tights/black
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	gloves = /obj/item/clothing/gloves/roguetown/leather
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	belt = /obj/item/storage/belt/rogue/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather/hide
	cloak = /obj/item/clothing/cloak/raincloak/green
	backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
	backl = /obj/item/storage/backpack/rogue/satchel
	beltr = /obj/item/rogueweapon/sword/sabre/elf
	backpack_contents = list(/obj/item/bait = 1, /obj/item/rogueweapon/huntingknife/elvish = 1, /obj/item/flashlight/flare/torch/lantern = 1)
	beltl = /obj/item/quiver/arrows
	H.mind.assign_experiences(/datum/advclass/sentinel::given_skills, TRUE, "skills")
	H.mind.assign_experiences(/datum/advclass/sentinel::stat_changes, TRUE, "stats")

	H.ambushable = FALSE
