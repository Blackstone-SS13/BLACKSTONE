
/*
	dyn vagrants, the pilgrim and adventurer are finally whole again.
	In retrospect this should have been added a long time ago but the well is too poisoned for them atm.
	So if one day someone wants actual migrants here you go.
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
	"Aasimar",
	"Argonians"
	)
	tutorial = "A traveler of unknown origin whomst has come to these lands."


	outfit = null
	outfit_female = null

	display_order = JDO_VAGRANT
	show_in_credits = FALSE
	min_pq = -999

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


