/mob/proc/add_stress(event)
	return FALSE

/mob/proc/remove_stress(event)
	return FALSE

/mob/proc/update_stress()
	return FALSE

/mob/proc/adjust_stress(amt)
	return FALSE

/mob/proc/has_stress(event)
	return FALSE

/mob/living/carbon
	var/stress = 0
	var/list/stress_timers = list()
	var/oldstress = 0
	var/stressbuffer = 0
	var/list/negative_stressors = list()
	var/list/positive_stressors = list()

/mob/living/carbon/adjust_stress(amt)
	stressbuffer = stressbuffer + amt
	stress = stress + stressbuffer
	stressbuffer = 0
	if(stress > 30)
		stressbuffer = 30 - stress
		stress = 30
	if(stress < 0)
		stressbuffer = stress
		stress = 0

/mob/living/carbon/update_stress()
	if(HAS_TRAIT(src, TRAIT_NOMOOD))
		stress = 0
//		if(hud_used)
//			if(hud_used.stressies)
//				hud_used.stressies.update_icon(stress)
		return
	for(var/datum/stressevent/D in negative_stressors)
		if(D.timer)
			if(world.time > D.time_added + D.timer)
				adjust_stress(-1*D.stressadd)
				negative_stressors -= D
				qdel(D)
	for(var/datum/stressevent/D in positive_stressors)
		if(D.timer)
			if(world.time > D.time_added + D.timer)
				adjust_stress(-1*D.stressadd)
				positive_stressors -= D
				qdel(D)
	if(stress != oldstress)
		if(stress > oldstress)
			to_chat(src, "<span class='red'>I gain stress.</span>")
		else
			to_chat(src, "<span class='green'>I gain peace.</span>")
	oldstress = stress
	if(hud_used)
		if(hud_used.stressies)
			hud_used.stressies.update_icon()
	if(stress > 15)
		change_stat("fortune", -1*round((stress-16)/2), "stress")
	else
		change_stat("fortune", 0, "stress")

/mob/living/carbon/has_stress(event)
	var/amount
	for(var/datum/stressevent/D in negative_stressors)
		if(D.type == event)
			amount++
	for(var/datum/stressevent/D in positive_stressors)
		if(D.type == event)
			amount++
	return amount

/mob/living/carbon/add_stress(event)
	if(HAS_TRAIT(src, TRAIT_NOMOOD))
		return FALSE
	var/datum/stressevent/N = new event()
	var/countofus = 0
	if(N.stressadd > 0)
		for(var/datum/stressevent/D in negative_stressors)
			if(D.type == event)
				countofus++
				D.time_added = world.time
				if(N.stressadd > D.stressadd)
					D.stressadd = N.stressadd
	else
		for(var/datum/stressevent/D in positive_stressors)
			if(D.type == event)
				countofus++
				D.time_added = world.time
				if(N.stressadd < D.stressadd)
					D.stressadd = N.stressadd
	if(N.max_stacks) //we need to check if we should be added
		if(countofus >= N.max_stacks)
			return
	else //we refreshed the timer
		if(countofus >= 1)
			return
	if(N.stressadd > 0)
		negative_stressors += N
	else
		positive_stressors += N
	adjust_stress(N.stressadd)
	return TRUE

/mob/living/carbon/remove_stress(event)
	if(HAS_TRAIT(src, TRAIT_NOMOOD))
		return FALSE
	var/list/eventL
	if(islist(event))
		eventL = event
	for(var/datum/stressevent/D in negative_stressors)
		if(eventL)
			if(D.type in eventL)
				adjust_stress(-1*D.stressadd)
				negative_stressors -= D
				qdel(D)
		else
			if(D.type == event)
				adjust_stress(-1*D.stressadd)
				negative_stressors -= D
				qdel(D)
	for(var/datum/stressevent/D in positive_stressors)
		if(eventL)
			if(D.type in eventL)
				adjust_stress(-1*D.stressadd)
				positive_stressors -= D
				qdel(D)
		else
			if(D.type == event)
				adjust_stress(-1*D.stressadd)
				positive_stressors -= D
				qdel(D)
	return TRUE

#ifdef TESTSERVER
/client/verb/add_stress()
	set category = "DEBUGTEST"
	set name = "stressBad"
	if(mob)
		mob.add_stress(/datum/stressevent/test)

/client/verb/remove_stress()
	set category = "DEBUGTEST"
	set name = "stressGood"
	if(mob)
		mob.add_stress(/datum/stressevent/testr)

/client/verb/filter1()
	set category = "DEBUGTEST"
	set name = "TestFilter1"
	if(mob)
		mob.remove_client_colour(/datum/client_colour/test1)
		mob.remove_client_colour(/datum/client_colour/test2)
		mob.remove_client_colour(/datum/client_colour/test3)
		mob.add_client_colour(/datum/client_colour/test1)

/client/verb/filter2()
	set category = "DEBUGTEST"
	set name = "TestFilter2"
	if(mob)
		mob.remove_client_colour(/datum/client_colour/test1)
		mob.remove_client_colour(/datum/client_colour/test2)
		mob.remove_client_colour(/datum/client_colour/test3)
		mob.add_client_colour(/datum/client_colour/test2)

/client/verb/filter3()
	set category = "DEBUGTEST"
	set name = "TestFilter3"
	if(mob)
		mob.remove_client_colour(/datum/client_colour/test1)
		mob.remove_client_colour(/datum/client_colour/test2)
		mob.remove_client_colour(/datum/client_colour/test3)
		mob.add_client_colour(/datum/client_colour/test3)

/client/verb/do_undesaturate()
	set category = "DEBUGTEST"
	set name = "TestFilterOff"
	if(mob)
		mob.remove_client_colour(/datum/client_colour/test1)
		mob.remove_client_colour(/datum/client_colour/test2)
		mob.remove_client_colour(/datum/client_colour/test3)

/client/verb/do_flash()
	set category = "DEBUGTEST"
	set name = "doflash"
	if(mob)
		var/turf/T = get_turf(mob)
		if(T)
			T.flash_lighting_fx(30)
#endif
