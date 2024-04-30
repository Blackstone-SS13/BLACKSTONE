/datum/advclass
	var/name
	var/outfit
	var/tutorial = "Choose me!"
	var/list/allowed_sexes = list("male","female")
	var/list/allowed_races = list("Humen",
	"Humen",
	"Elf",
	"Elf",
	"Dark Elf",
	"Dwarf",
	"Dwarf"
	)
	var/list/allowed_patrons = ALL_PATRON_NAMES_LIST
	var/list/allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_OLD)
	var/pickprob = 100
	var/maxchosen = -1
	var/amtchosen = 0
	var/min_pq = -100

	var/horse = FALSE
	var/vampcompat = TRUE
	var/list/traits_applied

	//What categories we are going to sort it in, keep in mind this is a set of bitflags
	var/category_flags = RT_TYPE_DISABLED_CLASS

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

	if(category_flags & (RT_TYPE_VILLAGER_CLASS))
		for(var/mob/M in GLOB.billagerspawns)
			to_chat(M, "<span class='info'>[H.real_name] is the [name].</span>")
		GLOB.billagerspawns -= H

/datum/advclass/proc/post_equip(mob/living/carbon/human/H)
	addtimer(CALLBACK(H,TYPE_PROC_REF(/mob/living/carbon/human, add_credit)), 20)
	return

/*
	Whoa! we are checking requirements here!
	On the datum! Wow!
*/
/datum/advclass/proc/check_requirements(mob/living/carbon/human/H)
	if(!(H.gender in allowed_sexes))
		return FALSE

	if(!(H.dna.species.name in allowed_races))
		return FALSE

	if(!(H.age in allowed_ages))
		return FALSE

	if(maxchosen > -1)
		if(amtchosen >= maxchosen)
			return FALSE

	if(!(get_playerquality(H.client.ckey) >= min_pq))
		return FALSE

	if(prob(pickprob))
		return TRUE

