//terrify mobs scream
/datum/advclass/barbarian
	name = "Barbarian"
	tutorial = "Barbarians are humen men who live in the outskirts of society, \
	living off the land and bathing in the red glory of combat."
	allowed_sexes = list("male")
	allowed_races = list("Humen",
	"Humen")
	outfit = /datum/outfit/job/roguetown/adventurer/barbarian


/datum/outfit/job/roguetown/adventurer/barbarian/pre_equip(mob/living/carbon/human/H)
	..() // Compared to the Warrior the barbarian is more suited to the wilds. But they are able to make use of almost any weapon by talent and killer instinct.
	H.mind.adjust_skillrank(/datum/skill/combat/bows, pick(0,0,1,1,1), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, pick(2,2,2,3), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, pick(2,2,2,3), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, pick(2,2,2,3), TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, pick(0,1,1,1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, pick(2,2,3,3,3,3), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, pick(2,3,3,3), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sneaking, pick(0,0,1), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, pick(2,3,3,3), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, pick(0,0,1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sewing, pick(0,0,1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/cooking, pick(1,1,1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/labor/butchering, pick(0,1,1), TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/traps, pick(0,1,1), TRUE)
	H.mind.adjust_skillrank(/datum/skill/labor/fishing, pick(0,0,1), TRUE)

	belt = /obj/item/storage/belt/rogue/leather
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	beltl = /obj/item/rogueweapon/huntingknife
	backl = /obj/item/storage/backpack/rogue/satchel
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	if(prob(13))
		head = /obj/item/clothing/head/roguetown/helmet/horned
	if(prob(55))
		backr = /obj/item/storage/backpack/rogue/satchel
	if(prob(23))
		armor = /obj/item/clothing/suit/roguetown/armor/leather
	if(prob(23))
		armor = /obj/item/clothing/suit/roguetown/armor/leather/hide
	if(prob(5))
		cloak = /obj/item/clothing/cloak/raincloak/furcloak/brown
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	if(prob(33))
		shoes = /obj/item/clothing/shoes/roguetown/boots
	var/randy = rand(1,5)
	switch(randy) // Pick wep. Choose skill.
		if(1 to 2)
			beltr = /obj/item/rogueweapon/stoneaxe/woodcut
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, pick(2,2,2,3), TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, pick(3,3,3,3,3,4), TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, pick(2,2,2,3), TRUE)
		if(3 to 4)
			beltr = /obj/item/rogueweapon/sword/iron
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, pick(2,2,2,3), TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, pick(2,2,2,3), TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, pick(3,3,3,3,3,4), TRUE)
		if(5)
			beltr = /obj/item/rogueweapon/mace/woodclub
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, pick(2,2,2,3), TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, pick(3,3,3,3,3,4), TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, pick(2,2,2,3), TRUE)
	//70% chance to be raceswapped to Gronn because slop lore
	if(ishumannorthern(H) && prob(70))
		var/list/skin_slop = H.dna.species.get_skin_list()
		H.skin_tone = skin_slop["Gronn"]
		H.update_body()
	H.change_stat("intelligence", pick(-3,-2,-2,-2,-1,-1,0))
	H.change_stat("perception", pick(-1,0,0,0,1,))
	H.change_stat("strength", pick(0,1,1,1,2))
	H.change_stat("constitution", pick(0,1,1,1,2))
	H.change_stat("endurance", pick(0,1,1,1,2))
	H.change_stat("speed", pick(-1,0,0,0,0,1,2))
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, RTRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	if(H.dna?.species)
		H.dna.species.soundpack_m = new /datum/voicepack/male/warrior()
