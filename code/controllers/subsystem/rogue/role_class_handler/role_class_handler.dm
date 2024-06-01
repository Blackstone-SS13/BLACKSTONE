/*
	Basically we got a subsystem for the shitty subjob handling and new menu as of 4/30/2024 that goes with it
*/
/*
TODO ANTAG QUEUE SYSTEM
*/

/*
	REMINDER TO RETEST THE OVERFILL HELPER
*/
SUBSYSTEM_DEF(role_class_handler)
	name = "Role Class Handler"
	flags = SS_KEEP_TIMING
	init_order = INIT_ORDER_ROLE_CLASS_HANDLER
	priority = FIRE_PRIORITY_ROLE_CLASS_HANDLER
	runlevels = RUNLEVEL_LOBBY | RUNLEVEL_SETUP | RUNLEVEL_GAME

	/*
		This one is important, its all the open class select handlers
		Its an assc list too class_select_handlers[ckey] = /datum/class_select_handler
		If someone makes one they shouldn't be getting a new one in the current session
	*/
	var/list/class_select_handlers = list()


	/*
		This one is just an assc list, basically
		"ckey" = num to track the rerolls per server session attached to a ckey.
		You are only getting THREE (by default)
	*/
	var/list/session_rerolls = list()

	/*
		This one is kinda retarded, its basically for datums certain ckeys will get in the session
		"ckey" = list(the datums), which will be its own copy that the person its hooked to can drain numbers out of on their own.
	*/
	var/list/special_session_queue = list()

//Time for sloppa vars
	/*
		This is basically a big assc list of sorted classes, 
		The structure is as so, "category_key" = list(/datum/advclass/balls1, /datum/advclass/balls2, etc)
		we only have one snowflake list in there rn and it is the following:
		"all_classes" = list(every class datum)
	*/
	var/list/sorted_class_categories = list()


/*
	We init and build the retard azz listszz
*/
/datum/controller/subsystem/role_class_handler/Initialize()
	build_dumbass_category_lists()

	initialized = TRUE

	return ..()


// This covers both class datums and drifter waves
/datum/controller/subsystem/role_class_handler/proc/build_dumbass_category_lists()

	init_subtypes(/datum/drifter_wave, drifter_wave_data_slabs) // Init all the drifter waves

	var/list/all_classes = list()
	init_subtypes(/datum/advclass, all_classes) // Init all the classes
	sorted_class_categories[CTAG_ALLCLASS] = all_classes

	//Time to sort these retards, and sort them we shall.
	for(var/datum/advclass/retard_datum in all_classes)
		for(var/ctag in retard_datum.category_tags)
			if(!sorted_class_categories[ctag]) // New cat
				sorted_class_categories[ctag] = list()
			sorted_class_categories[ctag] += retard_datum

	//Well that about covers it really.

/*
	We setup the class handler here, aka the menu
	We will cache it per server session via an assc list with a ckey leading to the datum.
*/
/datum/controller/subsystem/role_class_handler/proc/setup_class_handler(mob/living/carbon/human/H)
	// Also insure we somehow don't call this without a ref in the params
	if(H)
		// insure they somehow aren't closing the datum they got and opening a new one w rolls
		var/datum/class_select_handler/GOT_IT = class_select_handlers[H.client.ckey]
		if(GOT_IT)
			if(!GOT_IT.linked_client) // this ref will disappear if they disconnect neways probably, as its a client
				GOT_IT.linked_client = H.client // too bad the firing of slop just checks the mob for what it can even use anyways
			GOT_IT.second_step()

		else
			var/datum/class_select_handler/XTRA_MEATY = new()
			XTRA_MEATY.linked_client = H.client

			if(H.job) // Set the totals being rolled via whats currently on the job
				var/datum/job/roguetown/RT_JOB = SSjob.name_occupations[H.job]
				XTRA_MEATY.total_combat_class = RT_JOB.combat_slot_rolls_count
				XTRA_MEATY.total_free_class = RT_JOB.free_slot_rolls_count

			XTRA_MEATY.initial_setup()
			class_select_handlers[H.client.ckey] = XTRA_MEATY

		if(!(H.client.ckey in session_rerolls)) // no key in sess rerolls
			session_rerolls[H.client.ckey] = 3 // Set it and give them 3

//Attempt to finish the class handling ordeal, aka they picked something
// Since this is class handler related, might as well also have the class handler send itself into the params
/datum/controller/subsystem/role_class_handler/proc/finish_class_handler(mob/living/carbon/human/H, datum/advclass/picked_class, datum/class_select_handler/related_handler, plus_factor)
	if(!(picked_class.maximum_possible_slots == -1)) // Is the class not set to infinite?
		if(picked_class.total_slots_occupied >= picked_class.maximum_possible_slots) // are the occupied slots greater than or equal to the current maximum possible slots on the datum?
			related_handler.rolled_class_is_full(picked_class) //If so we inform the datum in the off-chance some desyncing is occurring so we don't have a deadslot in their options.
			return FALSE // Along with stop here as they didn't get it.


	H.advsetup = FALSE // This is actually on a lot of shit, so its a ghetto selector protector if u need one
	picked_class.equipme(H)
	H.invisibility = 0
	var/atom/movable/screen/advsetup/GET_IT_OUT = locate() in H.hud_used.static_inventory // dis line sux its basically a loop anyways if i remember
	qdel(GET_IT_OUT)
	H.cure_blind("advsetup")

	if(plus_factor) // If we get any plus factor at all, we run the datums boost proc on the human also.
		picked_class.boost_by_plus_power(plus_factor, H)


	// In retrospect, If I don't just delete these Ill have to actually attempt to keep track of when a byond browser window is actually open lol
	// soooo..... this will be the place where we take the out, as it means they finished class selection, and we can safely delete the handler.
	related_handler.ForceCloseMenus() // force menus closed
	
	// Remove the key from the list and with it the value too
	class_select_handlers.Remove(related_handler.linked_client.ckey)
	// Call qdel on it
	qdel(related_handler)

	adjust_class_amount(picked_class, 1) // adjust the amount here, we are handling one guy right now.
	picked_class.extra_slop_proc_ending(H)

// A dum helper to adjust the class amount, we could do it elsewhere but this will also inform any relevant class handlers open.
/datum/controller/subsystem/role_class_handler/proc/adjust_class_amount(datum/advclass/target_datum, amount)
	target_datum.total_slots_occupied += amount

	if((target_datum.total_slots_occupied >= target_datum.maximum_possible_slots)) // We just hit a cap, iterate all the class handlers and inform them.
		for(var/CUCKS in class_select_handlers)
			var/datum/class_select_handler/found_menu = class_select_handlers[CUCKS]
			
			if(target_datum in found_menu.rolled_classes) // We found the target datum in one of the classes they rolled aka in the list of options they got visible,
				found_menu.rolled_class_is_full(target_datum) //  inform the datum of its error.

// If they aren't in the list, they get 3 by default.
/datum/controller/subsystem/role_class_handler/proc/get_session_rerolls(ckey)
	return session_rerolls[ckey]


/datum/controller/subsystem/role_class_handler/proc/adjust_session_rerolls(ckey, number)
	session_rerolls[ckey] += number


/datum/controller/subsystem/role_class_handler/proc/add_to_special_session_queue(ckey, datum, key_id)
	if(!special_session_queue[ckey])
		special_session_queue[ckey] = list()

	special_session_queue[ckey]["[key_id]"] = datum



