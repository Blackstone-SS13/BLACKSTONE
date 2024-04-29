/datum/advclass/noble
	name = "Nobleman"
	allowed_sexes = list("male", "female")
	allowed_races = list("Humen",
	"Humen",
	"Elf",
	"Elf",
	"Half-Elf",
	"Aasimar"
	)

  outfit = /datum/outfit/job/roguetown/adventurer/noble
	isvillager = TRUE
	ispilgrim = TRUE

  /datum/outfit/job/roguetown/adventurer/noble/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/tights/black
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
		shoes = /obj/item/clothing/shoes/roguetown/nobleboot
		neck = /obj/item/storage/belt/rogue/pouch/coins/rich
		head = /obj/item/clothing/head/roguetown/fancy
		backl = /obj/item/storage/backpack/rogue/satchel
    ring = /obj/item/clothing/ring/silver
		belt = /obj/item/storage/belt/rogue/leather
		cloak = /obj/item/clothing/cloak/half
		beltl = /obj/item/rogueweapon/huntingknife/idagger/steel
  	if(H.mind)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
    	H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
    	H.change_stat("strength", -1)
			H.change_stat("endurance", -1)
  	  H.change_stat("intelligence", 1)

  else 
  	armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/purple
		shoes = /obj/item/clothing/shoes/roguetown/nobleboot
		neck = /obj/item/storage/belt/rogue/pouch/coins/rich
		head = /obj/item/clothing/head/roguetown/hatblu
		backl = /obj/item/storage/backpack/rogue/satchel
    ring = /obj/item/clothing/ring/silver
		belt = /obj/item/storage/belt/rogue/leather
		beltl = /obj/item/rogueweapon/huntingknife/idagger/steel
    if(H.mind)
      H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
  	  H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
  		H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
    	H.change_stat("strength", -1)
			H.change_stat("endurance", -1)
  	  H.change_stat("intelligence", 1)
