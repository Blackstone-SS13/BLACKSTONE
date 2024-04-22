/datum/advclass/grenzelhoft
	name = "Grenzelhoft mercenary"
	tutorial = "A mercenary from Grenzelhoft, you are often hired by lords seeking to bolster their armies and are well versed in siege craft / field tactics. You are a long way from home though..."
	allowed_sexes = list("male")
	allowed_races = list("Humen",
	"Tiefling",
	"Aasimar")
	outfit = /datum/outfit/job/roguetown/adventurer/grenzelhoft

/datum/outfit/job/roguetown/adventurer/grenzelhoft/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	belt = /obj/item/storage/belt/rogue/leather
	armor = /obj/item/clothing/suit/roguetown/armor/gambeson
	beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
	cloak = /obj/item/clothing/cloak/stabard/mercenary
	beltl = /obj/item/rogueweapon/sword/sabre
	if(prob(50))
		beltl = /obj/item/rogueweapon/sword
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/merc
	pants = /obj/item/clothing/under/roguetown/trou/leather
	neck = /obj/item/clothing/neck/roguetown/gorget
	if(H.gender == FEMALE)
		pants = /obj/item/clothing/under/roguetown/tights/black
		beltl = /obj/item/rogueweapon/sword/sabre
		if(prob(50))
			beltl = /obj/item/rogueweapon/sword/rapier
		var/acceptable = list("Tomboy", "Bob", "Curly Short")
		if(!(H.hairstyle in acceptable))
			H.hairstyle = pick(acceptable)
			H.update_hair()
	//Humie grenzelhofts are always set to be, well, grenzelhoft
	if(ishumannorthern(H))
		var/list/skin_slop = H.dna.species.get_skin_list()
		H.skin_tone = skin_slop["Grenzelhoft"]
		H.update_body()
	if(H.mind) // As both Warrior and Grenz aren't well defined yet. They have the same stat/skill array. In future with Grenz Lore + Content this should change.
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, pick(1,1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, pick(2,2,2,3,3,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, pick(2,2,2,3,3,3,4), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, pick(0,0,1,1,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, pick(1,2,2,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, pick(1,2,2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, pick(2,2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, pick(2,2,3,3,3,3,4), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, pick(2,2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, pick(0,0,1,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, pick(0,1,1,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, pick(1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, pick(1,2,2,2,3,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, pick(0,1,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/butchering, pick(0,1,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/traps, pick(0,0,0,0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, pick(2,3,3,3,3,3,4), TRUE)
		H.change_stat("intelligence", pick(0,0,0,1))
		H.change_stat("perception", pick(0,1,1,1,2))
		H.change_stat("strength", pick(0,0,1,1,1))
		H.change_stat("constitution", pick(0,0,1,1,1))
		H.change_stat("endurance", pick(0,0,1,1,1))
		H.change_stat("speed", pick(0,1,1,1,2))
		ADD_TRAIT(H, RTRAIT_HEAVYARMOR, TRAIT_GENERIC)
		ADD_TRAIT(H, RTRAIT_MEDIUMARMOR	, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
