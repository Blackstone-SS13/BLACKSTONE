
/*
	Retarded job that goes in with the ghetto dynamic mode
*/
/datum/job/roguetown/vagrants
	title = "Vagrant"
	flag = ADVENTURER
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
			GLOB.adv_classes
			var/list/special_classes = list()
			var/classamt = 5

		
TODO: RUN THE LISTS THRU CLASS SELECT HANDLER AND LIKE ACTUALLY ATTACH THE MENUS TOGETHER
			for(var/I in shuffle(classes))
				var/datum/advclass/A = I
				if(!(H.gender in A.allowed_sexes))
					testing("[A.name] fail11")
					continue

				if(!(H.dna.species.name in A.allowed_races))
					testing("[A.name] fail22")
					continue

				if(!(H.age in A.allowed_ages))
					testing("[A.name] fail33")
					continue

				if(A.maxchosen > -1)
					if(A.amtchosen >= A.maxchosen)
						testing("[A.name] fail9")
						continue

				if(H.possibleclass.len >= classamt)
					testing("[A.name] fail3")
					continue

				var/the_prob = A.pickprob
				if(prob(the_prob))
					testing("[A.name] SUC1")
					H.possibleclass += A

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
