GLOBAL_LIST_EMPTY(billagerspawns)

GLOBAL_VAR_INIT(adventurer_hugbox_duration, 20 SECONDS)
GLOBAL_VAR_INIT(adventurer_hugbox_duration_still, 3 MINUTES)
/*
	Retarded job that goes in with the ghetto dynamic mode
*/
/datum/job/roguetown/vagrants
	title = "Vagrant"
	flag = DYN_VAGRANTS
	department_flag = PEASANTS
	faction = "Station"
	total_positions = -1
	spawn_positions = 420
	allowed_races = list(
	"Humen",
	"Elf",
	"Half-Elf",
	"Dwarf",
	"Tiefling",
	"Dark Elf",
	"Aasimar"
	)
	tutorial = "A traveler of unknown origin whomst has come to these lands."


	outfit = null
	outfit_female = null

	display_order = JDO_VAGRANT
	show_in_credits = FALSE
	min_pq = 0

/datum/job/roguetown/vagrants/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")
		H.Stun(100)

		if(!H.possibleclass)
			H.possibleclass = list()

		if(GLOB.adventurer_hugbox_duration)
			///FOR SOME RETARDED FUCKING REASON THIS REFUSED TO WORK WITHOUT A FUCKING TIMER IT JUST FUCKED SHIT UP
			addtimer(CALLBACK(H, TYPE_PROC_REF(/mob/living/carbon/human, adv_hugboxing_start)), 1)

		if(M.client)
			return FALSE
			// Heres where we begin the hell


/*
/mob/living/carbon/human/proc/advsetup()
	if(!advsetup)
		testing("RETARD")
		return TRUE
	var/blacklisted = check_blacklist(ckey)
	if(possibleclass.len && !blacklisted)
		var/datum/advclass/C = input(src, "What is my class?", "Adventure") as null|anything in sortNames(possibleclass)
		if(C && advsetup)
			if(C.maxchosen > -1)
				for(var/datum/advclass/A in GLOB.adv_classes)
					if(A.type == C.type)
						if(A.amtchosen >= A.maxchosen)
							possibleclass -= C
							to_chat(src, "<span class='warning'>Not enough slots for [C] left! Choose something different.</span>")
							return FALSE
						else
							A.amtchosen++
			if(alert(src, "[C.name]\n[C.tutorial]", "Are you sure?", "Yes", "No") != "Yes")
				return FALSE
			if(advsetup)
				advsetup = 0
				C.equipme(src)
				invisibility = 0
				cure_blind("advsetup")
				return TRUE
	else
		testing("RETARD2")
		advsetup = 0
		invisibility = 0
		cure_blind("advsetup")
		return TRUE
*/

/mob/living/carbon/human/proc/adv_hugboxing_start()
	to_chat(src, "<span class='warning'>I will be in danger once I start moving.</span>")
	status_flags |= GODMODE
	ADD_TRAIT(src, TRAIT_PACIFISM, ADVENTURER_HUGBOX_TRAIT)
	RegisterSignal(src, COMSIG_MOVABLE_MOVED, PROC_REF(adv_hugboxing_moved))
	//Lies, it goes away even if you don't move after enough time
	if(GLOB.adventurer_hugbox_duration_still)
		addtimer(CALLBACK(src, TYPE_PROC_REF(/mob/living/carbon/human, adv_hugboxing_end)), GLOB.adventurer_hugbox_duration_still)

/mob/living/carbon/human/proc/adv_hugboxing_moved()
	UnregisterSignal(src, COMSIG_MOVABLE_MOVED)
	to_chat(src, "<span class='danger'>I have [DisplayTimeText(GLOB.adventurer_hugbox_duration)] to begone!</span>")
	addtimer(CALLBACK(src, TYPE_PROC_REF(/mob/living/carbon/human, adv_hugboxing_end)), GLOB.adventurer_hugbox_duration)

/mob/living/carbon/human/proc/adv_hugboxing_end()
	if(QDELETED(src))
		return
	//hugbox already ended
	if(!(status_flags & GODMODE))
		return
	status_flags &= ~GODMODE
	REMOVE_TRAIT(src, TRAIT_PACIFISM, ADVENTURER_HUGBOX_TRAIT)
	to_chat(src, "<span class='danger'>My joy is gone! Danger surrounds me.</span>")
