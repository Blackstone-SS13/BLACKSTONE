GLOBAL_LIST_EMPTY(billagerspawns)

GLOBAL_VAR_INIT(adventurer_hugbox_duration, 20 SECONDS)
GLOBAL_VAR_INIT(adventurer_hugbox_duration_still, 3 MINUTES)

/datum/job/roguetown/adventurer
	title = "Adventurer"
	flag = ADVENTURER
	department_flag = PEASANTS
	faction = "Station"
	total_positions = 75
	spawn_positions = 75
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Argonian",
		"Dark Elf",
		"Aasimar"
	)
	tutorial = "Hero of nothing, adventurer by trade. Whatever led you to this fate is up to the wind to decide, and you've never fancied yourself for much other than the thrill. Someday your pride is going to catch up to you, and you're going to find out why most men don't end up in the annals of history."


	outfit = null
	outfit_female = null

	display_order = JDO_ADVENTURER
	show_in_credits = FALSE
	min_pq = 0
	
	wanderer_examine = TRUE
	advjob_examine = TRUE
	var/isvillager = FALSE
	var/ispilgrim = FALSE

/datum/job/roguetown/adventurer/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")

		if(GLOB.adventurer_hugbox_duration)
			///FOR SOME RETARDED FUCKING REASON THIS REFUSED TO WORK WITHOUT A FUCKING TIMER IT JUST FUCKED SHIT UP
			addtimer(CALLBACK(H, TYPE_PROC_REF(/mob/living/carbon/human, adv_hugboxing_start)), 1)

/*
	Some spawn protection I guess
*/
/mob/living/carbon/human/proc/adv_hugboxing_start()
	to_chat(src, "<span class='warning'>I will be in danger once I start moving.</span>")
	status_flags |= GODMODE
	ADD_TRAIT(src, TRAIT_PACIFISM, HUGBOX_TRAIT)
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
	REMOVE_TRAIT(src, TRAIT_PACIFISM, HUGBOX_TRAIT)
	to_chat(src, "<span class='danger'>My joy is gone! Danger surrounds me.</span>")
