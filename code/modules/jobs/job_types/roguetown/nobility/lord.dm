GLOBAL_VAR(lordsurname)
GLOBAL_LIST_EMPTY(lord_titles)

/datum/job/roguetown/lord
	title = "King"
	f_title = "Queen"
	flag = LORD
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 0
	spawn_positions = 1
	selection_color = JCOLOR_NOBLE
	allowed_races = list("Humen")
	allowed_sexes = list(MALE)

	spells = list(
		/obj/effect/proc_holder/spell/self/grant_title,
		/obj/effect/proc_holder/spell/self/convertrole/servant,
		/obj/effect/proc_holder/spell/self/convertrole/guard,
		/obj/effect/proc_holder/spell/self/convertrole/bog,
	)
	outfit = /datum/outfit/job/roguetown/lord

	display_order = JDO_LORD
	tutorial = "Elevated upon your throne through a web of intrigue and political upheaval, you are the absolute authority of these lands and at the center of every plot within it. Every man, woman and child is envious of your position and would replace you in less than a heartbeat: Show them the error in their ways."
	whitelist_req = FALSE
	min_pq = 5
	max_pq = null
	give_bank_account = 1000
	required = TRUE

/datum/job/roguetown/exlord //just used to change the lords title
	title = "King Emeritus"
	f_title = "Queen Emeritus"
	flag = LORD
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	display_order = JDO_LADY
	give_bank_account = TRUE


/datum/job/roguetown/lord/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		var/list/chopped_name = splittext(L.real_name, " ")
		if(length(chopped_name) > 1)
			chopped_name -= chopped_name[1]
			GLOB.lordsurname = jointext(chopped_name, " ")
		else
			GLOB.lordsurname = "of [L.real_name]"
		SSticker.select_ruler()
		if(L.gender != FEMALE)
			to_chat(world, "<b><span class='notice'><span class='big'>[L.real_name] is King of Rockhill.</span></span></b>")
			addtimer(CALLBACK(L, TYPE_PROC_REF(/mob, lord_color_choice)), 50)
		else
			to_chat(world, "<b><span class='notice'><span class='big'>[L.real_name] is Queen of Rockhill.</span></span></b>")
			addtimer(CALLBACK(L, TYPE_PROC_REF(/mob, lord_color_choice)), 50)

/datum/outfit/job/roguetown/lord/pre_equip(mob/living/carbon/human/H)
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
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
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
			if(H.age == AGE_OLD)
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			H.change_stat("strength", 1)
			H.change_stat("intelligence", 3)
			H.change_stat("endurance", 3)
			H.change_stat("speed", 1)
			H.change_stat("perception", 2)
			H.change_stat("fortune", 5)
		if(ishumannorthern(H))
			H.dna.species.soundpack_m = new /datum/voicepack/male/evil()

		if(H.wear_mask)
			if(istype(H.wear_mask, /obj/item/clothing/mask/rogue/eyepatch))
				qdel(H.wear_mask)
				mask = /obj/item/clothing/mask/rogue/lordmask
			if(istype(H.wear_mask, /obj/item/clothing/mask/rogue/eyepatch/left))
				qdel(H.wear_mask)
				mask = /obj/item/clothing/mask/rogue/lordmask/l
	else //Queen, doesn't do anything at the moment as Lord is male-only
		armor = /obj/item/clothing/suit/roguetown/armor/armordress
		belt = /obj/item/storage/belt/rogue/leather/plaquegold
		shoes = /obj/item/clothing/shoes/roguetown/shortboots
		if(H.mind)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
			if(H.age == AGE_OLD)
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			H.change_stat("intelligence", 3)
			H.change_stat("endurance", 3)
			H.change_stat("speed", 2)
			H.change_stat("perception", 2)
			H.change_stat("fortune", 5)

	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOSEGRAB, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
//	SSticker.rulermob = H

/proc/give_lord_surname(mob/living/carbon/human/family_guy, preserve_original = FALSE)
	if(!GLOB.lordsurname)
		return
	if(preserve_original)
		family_guy.fully_replace_character_name(family_guy.real_name, family_guy.real_name + " " + GLOB.lordsurname)
		return family_guy.real_name
	var/list/chopped_name = splittext(family_guy.real_name, " ")
	if(length(chopped_name) > 1)
		family_guy.fully_replace_character_name(family_guy.real_name, chopped_name[1] + " " + GLOB.lordsurname)
	else
		family_guy.fully_replace_character_name(family_guy.real_name, family_guy.real_name + " " + GLOB.lordsurname)
	return family_guy.real_name

/obj/effect/proc_holder/spell/self/grant_title
	name = "Grant Title"
	desc = "Grant someone a title of honor... Or shame."
	antimagic_allowed = TRUE
	charge_max = 100
	/// Maximum range for title granting
	var/title_range = 3
	/// Maximum length for the title
	var/title_length = 42

/obj/effect/proc_holder/spell/self/grant_title/cast(list/targets, mob/user = usr)
	. = ..()
	var/granted_title = input(user, "What title do you wish to grant?", "[name]") as null|text
	granted_title = reject_bad_text(granted_title, title_length)
	if(!granted_title)
		return
	var/list/recruitment = list()
	for(var/mob/living/carbon/human/village_idiot in (get_hearers_in_view(title_range, user) - user))
		//not allowed
		if(!can_title(village_idiot))
			continue
		recruitment[village_idiot.name] = village_idiot
	if(!length(recruitment))
		to_chat(user, "<span class='warning'>There are no potential honoraries in range.</span>")
		return
	var/inputty = input(user, "Select an honorary!", "[name]") as anything in recruitment
	if(inputty)
		var/mob/living/carbon/human/recruit = recruitment[inputty]
		if(!QDELETED(recruit) && (recruit in get_hearers_in_view(title_range, user)))
			INVOKE_ASYNC(src, PROC_REF(village_idiotify), recruit, user, granted_title)
		else
			to_chat(user, "<span class='warning'>Honorific failed!</span>")
	else
		to_chat(user, "<span class='warning'>Honorific cancelled.</span>")

/obj/effect/proc_holder/spell/self/grant_title/proc/can_title(mob/living/carbon/human/recruit)
	//wtf
	if(QDELETED(recruit))
		return FALSE
	//need a mind
	if(!recruit.mind)
		return FALSE
	//need to see their damn face
	if(!recruit.get_face_name(null))
		return FALSE
	return TRUE

/obj/effect/proc_holder/spell/self/grant_title/proc/village_idiotify(mob/living/carbon/human/recruit, mob/living/carbon/human/recruiter, granted_title)
	if(QDELETED(recruit) || QDELETED(recruiter) || !granted_title)
		return FALSE
	if(GLOB.lord_titles[recruit.real_name])
		recruiter.say("I HEREBY STRIP YOU, [uppertext(recruit.name)], OF THE TITLE OF [uppertext(GLOB.lord_titles[recruit.real_name])]!")
		GLOB.lord_titles -= recruit.real_name
		return FALSE
	recruiter.say("I HEREBY GRANT YOU, [uppertext(recruit.name)], THE TITLE OF [uppertext(granted_title)]!")
	GLOB.lord_titles[recruit.real_name] = granted_title
	return TRUE
