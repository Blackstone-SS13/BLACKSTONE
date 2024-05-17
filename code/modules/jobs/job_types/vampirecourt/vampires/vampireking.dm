/datum/job/roguetown/lord/vampire 
	..()
	outfit = /datum/outfit/job/roguetown/lord/vampire //TODO
	tutorial = "TODO"

/datum/job/roguetown/exlord/vampire
	..()

//TODO: change name to something cooler
/datum/job/roguetown/lord/vampire/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..() //this maybe not needed
	if(L)
		SSticker.select_ruler()
		if(SSticker.rulertype == "King")
			to_chat(world, "<b><span class='notice'><span class='big'>[L.real_name] is King of Rockhill.</span></span></b>")
			addtimer(CALLBACK(L, TYPE_PROC_REF(/mob, lord_color_choice)), 50)
		else
			to_chat(world, "<b><span class='notice'><span class='big'>[L.real_name] is Queen of Rockhill.</span></span></b>")
			addtimer(CALLBACK(L, TYPE_PROC_REF(/mob, lord_color_choice)), 50)

// Vampire king is a tough bastard
/datum/outfit/job/roguetown/lord/vampire/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/crown/serpcrown
	neck = /obj/item/storage/belt/rogue/pouch/coins/rich
	cloak = /obj/item/clothing/cloak/lordcloak
	belt = /obj/item/storage/belt/rogue/leather/plaquegold
	l_hand = /obj/item/rogueweapon/lordscepter
	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1)
	id = /obj/item/clothing/ring/active/nomag	
	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/tights/black
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
		armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/black
		shoes = /obj/item/clothing/shoes/roguetown/boots	
		if(H.mind)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/self/convertrole/bog)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/self/convertrole/guard)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
			//if(H.age == AGE_OLD)
			//	H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			H.change_stat("strength", 4)
			H.change_stat("intelligence", 3)
			H.change_stat("endurance", 3)
			H.change_stat("speed", 3)
			H.change_stat("perception", 4)
			H.change_stat("fortune", 5)
		if(H.dna?.species)
			if(H.dna.species.id == "humen")
				H.dna.species.soundpack_m = new /datum/voicepack/male/evil()

		if(H.wear_mask)
			if(istype(H.wear_mask, /obj/item/clothing/mask/rogue/eyepatch))
				qdel(H.wear_mask)
				mask = /obj/item/clothing/mask/rogue/lordmask
			if(istype(H.wear_mask, /obj/item/clothing/mask/rogue/eyepatch/left))
				qdel(H.wear_mask)
				mask = /obj/item/clothing/mask/rogue/lordmask/l

	ADD_TRAIT(H, RTRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, RTRAIT_NOSEGRAB, TRAIT_GENERIC)
	ADD_TRAIT(H, RTRAIT_HEAVYARMOR, TRAIT_GENERIC)
