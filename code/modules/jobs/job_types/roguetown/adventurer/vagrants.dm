GLOBAL_LIST_EMPTY(billagerspawns)

GLOBAL_VAR_INIT(adventurer_hugbox_duration, 20 SECONDS)
GLOBAL_VAR_INIT(adventurer_hugbox_duration_still, 3 MINUTES)

/*
	Once again we are back here, ha hahaha....
*/
/datum/job/roguetown/vagrants
	title = "Vagrant"
	flag = DYN_VAGRANTS
	department_flag = PEASANTS
	faction = "Station"
	allowed_races = list(
	"Humen",
	"Elf",
	"Half-Elf",
	"Dwarf",
	"Tiefling",
	"Dark Elf",
	"Aasimar",
	"Argonians"
	)
	tutorial = "A traveler of unknown origin whomst has come to these lands."


	outfit = null
	outfit_female = null

	display_order = JDO_VAGRANT
	show_in_credits = FALSE
	min_pq = -999

	total_positions = -1
	spawn_positions = 420

	free_slot_rolls_count = 5
	combat_slot_rolls_count = 3
	var/current_migrants = 0

/datum/job/roguetown/vagrants/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")

		if(GLOB.adventurer_hugbox_duration)
			///FOR SOME RETARDED FUCKING REASON THIS REFUSED TO WORK WITHOUT A FUCKING TIMER IT JUST FUCKED SHIT UP
			addtimer(CALLBACK(H, TYPE_PROC_REF(/mob/living/carbon/human, adv_hugboxing_start)), 1)

	// ha ha ha heres the snowflake logic for the shit!
	current_migrants++ // Add one
	if(current_migrants == 50) // When we hit the number of approximately 50
		combat_slot_rolls_count = 0 // Set the combat slots roll count to 0, no more hobo fighters are entering for free


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
