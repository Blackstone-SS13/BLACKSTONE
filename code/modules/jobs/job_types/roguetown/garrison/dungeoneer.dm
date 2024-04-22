/datum/job/roguetown/dungeoneer
	title = "Dungeoneer"
	flag = DUNGEONEER
	department_flag = GARRISON
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_races = list("Humen",
	"Humen",
	"Dwarf",
	"Dwarf",
	"Aasimar",
	"Half-Elf"
	)
	allowed_sexes = list(MALE, FEMALE)

	display_order = JDO_DUNGEONEER

	tutorial = "Sometimes at night you stare into the vacant room and feel the loneliness of your existence crawl into whatever remains of your loathsome soul. You will never know hunger, thirst or want for anything with the mammons you make: Just as you’ll never forget the sounds a saw makes cutting through the bone, what a drowning man will gurgle out between the blood and teeth strangling his breath. You’re a terrible person, and the carriagemen are going to enjoy walking you down that lonesome path to hell."

	outfit = /datum/outfit/job/roguetown/dungeoneer
	give_bank_account = 5
	min_pq = -4


/datum/outfit/job/roguetown/dungeoneer/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/menacing
	pants = /obj/item/clothing/under/roguetown/trou
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	cloak = /obj/item/clothing/cloak/stabard/dungeon
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/rogueweapon/mace/woodclub
	beltl = /obj/item/keyring/dungeoneer
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, pick(0,1,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, pick(2,2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, pick(2,3,3,3,3,4), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, pick(2,3,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, pick(0,0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, pick(3,4,4,4), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, pick(2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, pick(2,3,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, pick(3,3,3,4), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, pick(2,2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, pick(2,2,3), TRUE) // Creeping around in the dark.
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, pick(0,1,1,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, pick(0,1,1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, pick(1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, pick(1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, pick(0,0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/butchering, pick(1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/traps, pick(2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, pick(1,1,2), TRUE)
		H.change_stat("intelligence", pick(-2,-1,-1,0))
		H.change_stat("perception", pick(-1,-1,0))
		H.change_stat("strength", pick(0,1,1,1,2))
		H.change_stat("constitution", pick(0,0,1))
		H.change_stat("endurance", pick(0,0,1))
		H.change_stat("speed", pick(0,0,1))

		ADD_TRAIT(H, RTRAIT_MEDIUMARMOR	, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)

	if(H.dna?.species)
		if(H.dna.species.id == "human")
			H.dna.species.soundpack_m = new /datum/voicepack/male/warrior()
	H.verbs |= /mob/living/carbon/human/proc/torture_victim
