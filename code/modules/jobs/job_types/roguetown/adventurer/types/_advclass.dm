/datum/advclass
	var/name
	var/outfit
	var/tutorial = "Choose me!"
	var/list/allowed_sexes
	var/list/allowed_races = list(
		"Humen",
		"Elf",
		"Elf",
		"Dark Elf",
		"Dwarf",
		"Dwarf"
	)
	var/list/allowed_patrons
	var/list/allowed_ages
	var/pickprob = 100
	var/maxchosen = -1
	var/amtchosen = 0
	var/plevel_req = 0
	var/special_req = FALSE //check the json for our ckey
	var/whitelist_req = FALSE
	var/ispilgrim = FALSE
	var/isvillager = FALSE
	var/horse = FALSE
	var/vampcompat = TRUE
	var/list/traits_applied

/datum/advclass/proc/equipme(mob/living/carbon/human/H)
	if(!H)
		return FALSE

	if(outfit)
		H.equipOutfit(outfit)

	post_equip(H)

	H.advjob = name
	H.advsetup = 0
	H.invisibility = null
	H.cure_blind("advsetup")
	H.SetStun(0)
	sleep(1)
	testing("[H] spawn troch")
	var/obj/item/flashlight/flare/torch/T = new()
	T.spark_act()
	H.put_in_hands(T)

	var/turf/TU = get_turf(H)
	if(TU)
		if(horse)
			new horse(TU)

	for(var/trait in traits_applied)
		ADD_TRAIT(H, trait, ADVENTURER_TRAIT)
	if(isvillager)
		for(var/mob/M in GLOB.billagerspawns)
			to_chat(M, "<span class='info'>[H.real_name] is the [name].</span>")
		GLOB.billagerspawns -= H

/datum/advclass/proc/post_equip(mob/living/carbon/human/H)
	addtimer(CALLBACK(H,TYPE_PROC_REF(/mob/living/carbon/human, add_credit)), 20)
	return

/datum/outfit/job/roguetown/adventurer
	name = "Adventurer"
	/// List of patrons we are allowed to use
	var/list/allowed_patrons
	/// Default patron in case the patron is not allowed
	var/datum/patron/default_patron

/datum/outfit/job/roguetown/adventurer/pre_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	var/datum/patron/ourpatron = H.patron
	if(!ourpatron || !(ourpatron.type in allowed_patrons))
		var/list/datum/patron/possiblegods = list()
		for(var/god in GLOB.patronlist)
			if(!(god in allowed_patrons))
				continue
			possiblegods |= patron
		H.patron = GLOB.patronlist[default_patron] || pick(possiblegods)
		to_chat(H, "<span class='warning'>[ourpatron] had not endorsed my practices in my younger years. I've since grown acustomed to [H.patron].")
