/datum/job/roguetown/puritan
	title = "Witch Hunter"
	flag = PURITAN
	department_flag = CHURCHMEN
	faction = "Station"
	total_positions = 0
	spawn_positions = 0

	allowed_races = list("Humen",
	"Humen"
	)
	allowed_sexes = list(MALE)

	tutorial = "As a Witch Hunter, the Queen has emboldened your sect to root out cultists and the cursed night beasts, using your practice of extracting involuntary 'sin confessions' as a guise to spy on the local populace. Witch Hunters are hired for their extreme paranoia and religious fervor."
	whitelist_req = TRUE

	outfit = /datum/outfit/job/roguetown/puritan
	display_order = JDO_PURITAN
	give_bank_account = 36
	min_pq = -4

/datum/job/roguetown/puritan/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(!L.mind)
		return
	if(L.mind.has_antag_datum(/datum/antagonist))
		return
	var/datum/antagonist/new_antag = new /datum/antagonist/purishep()
	L.mind.add_antag_datum(new_antag)

/datum/outfit/job/roguetown/puritan
	name = "Witch Hunter"
	jobtype = /datum/job/roguetown/puritan

/datum/outfit/job/roguetown/puritan/pre_equip(mob/living/carbon/human/H)
	..()
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/puritan
	belt = /obj/item/storage/belt/rogue/leather
	neck = /obj/item/clothing/neck/roguetown/psicross/silver
	shoes = /obj/item/clothing/shoes/roguetown/boots
	pants = /obj/item/clothing/under/roguetown/tights/black
	cloak = /obj/item/clothing/cloak/cape/puritan
	beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
	head = /obj/item/clothing/head/roguetown/puritan
	gloves = /obj/item/clothing/gloves/roguetown/leather
	beltl = /obj/item/rogueweapon/sword/rapier
	backpack_contents = list(/obj/item/keyring/puritan = 1)

	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, pick(3,3,3,3,4), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, pick(1,2,2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, pick(2,3,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, pick(0,1,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, pick(0,1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, pick(1,2,2,2,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, pick(1,2,2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, pick(1,2,2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, pick(0,1,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, pick(1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, pick(1,2,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, pick(0,0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, pick(2,3,3,4), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, pick(2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/butchering, pick(0,1,1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/traps, pick(0,0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, pick(1,2,2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, pick(1,1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, pick(0,0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, pick(1,1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, pick(3,3,4), TRUE)	

		H.change_stat("intelligence", pick(2,2,2,3,3)) 
		H.change_stat("perception", pick(2,2,2,3,3)) 
		H.change_stat("strength", pick(1,1,1,2))
		H.change_stat("constitution", pick(-1,0,0,0,0,1))
		H.change_stat("endurance", pick(-1,0,0,0,0,1))
		H.change_stat("speed", pick(-1,0,0,0,0,1))
//		if(H.mind.has_antag_datum(/datum/antagonist))
//			return
//		var/datum/antagonist/new_antag = new /datum/antagonist/purishep()
//		H.mind.add_antag_datum(new_antag)
//	ADD_TRAIT(H, RTRAIT_TORTURER, TRAIT_GENERIC)
	H.verbs |= /mob/living/carbon/human/proc/faith_test
	H.verbs |= /mob/living/carbon/human/proc/torture_victim

/mob/living/carbon/human/proc/torture_victim()
	set name = "ExtractConfession"
	set category = "Inquisition"

	var/obj/item/grabbing/I = get_active_held_item()
	var/mob/living/carbon/human/H
	if(istype(I))
		if(ishuman(I.grabbed))
			H = I.grabbed
			if(H == src)
				to_chat(src, "<span class='warning'>I already torture myself.</span>")
				return
			var/painpercent = H.get_complex_pain() / (H.STAEND * 10)
			painpercent = painpercent * 100
			if(H.add_stress(/datum/stressevent/tortured))
				if(!H.stat)
					say(pick("CONFESS!",
								"TELL ME YOUR SECRETS!",
								"SPEAK!",
								"YOU WILL SPEAK!",
								"TELL ME!",
								"THE PAIN HAS ONLY BEGUN, CONFESS!"), spans = list("torture"))
					if((painpercent > 90) || (!H.cmode))
						H.emote("painscream")
						H.confession_time()
						return
			to_chat(src, "<span class='warning'>Not ready to speak yet.</span>")

/mob/living/carbon/human/proc/confession_time()
	var/timerid = addtimer(CALLBACK(src, PROC_REF(confess_sins)), 6 SECONDS, TIMER_STOPPABLE)
	var/responsey = alert("Resist torture? (1 TRI)","Yes","No")
	if(!responsey)
		responsey = "No"
	if(SStimer.timer_id_dict[timerid])
		deltimer(timerid)
	else
		to_chat(src, "<span class='warning'>Too late...</span>")
		return
	if(responsey == "Yes")
		adjust_triumphs(-1)
		confess_sins(TRUE)
	else
		confess_sins()

/mob/living/carbon/human/proc/confess_sins(resist)
	if(!resist)
		var/datum/mind/M = mind
		if(M)
			for(var/datum/antagonist/A in M.antag_datums)
				if(A.confess_lines)
					say(pick(A.confess_lines), spans = list("torture"))
					return
	say(pick("I DON'T KNOW!",
			"STOP THE PAIN!!",
			"I DON'T DESERVE THIS!",
			"THE PAIN!",
			"I HAVE NOTHING TO SAY...!",
			"WHY ME?!"), spans = list("torture"))

/mob/living/carbon/human/proc/faith_test()
	set name = "FaithTest"
	set category = "Inquisition"
	set hidden = 1
	//same as above, but CRY TO YOUR GOD! BEG TO YOUR CREATOR! WHO DO YOU WORSHIP? WHO IS YOUR MASTER?
