/*
	Basically we got a subsystem for the shitty subjob handling and new menu as of 4/30/2024 that goes with it
*/

/*
	REMINDER TO RETEST THE OVERFILL HELPER
*/
SUBSYSTEM_DEF(role_class_handler)
	name = "Role Class Handler"
	wait = 10
	init_order = INIT_ORDER_ROLE_CLASS_HANDLER
	priority = FIRE_PRIORITY_ROLE_CLASS_HANDLER
	runlevels = RUNLEVEL_LOBBY|RUNLEVEL_GAME|RUNLEVEL_SETUP

/*
	a list of datums dedicated to helping handle a class selection session
	ex: class_select_handlers[ckey] = /datum/class_select_handler
	contents: class_select_handlers = list("ckey" = /datum/class_select_handler, "ckey2" = /datum/class_select_handler,... etc)
*/
	var/list/class_select_handlers = list()

/*
	This ones basically a list for if you want to give a specific ckey a specific isolated datum
	ex: special_session_queue[ckey] += /datum/advclass/BIGMAN
	contents: special_session_queue = list("ckey" = list("funID" = /datum/advclass/class), "ckey2" = list("funID" = /datum/advclass/class)... etc)
*/
	var/list/special_session_queue = list()


/*
	This is basically a big assc list of lists attached to tags which contain /datum/advclass datums
	ex: sorted_class_categories[CTAG_GAPEMASTERS] += /datum/advclass/GAPER
	contents: sorted_class_categories = list("CTAG_GAPEMASTERS" = list(/datum/advclass/GAPER, /datum/advclass/GAPER2)... etc)
	Snowflake lists:
		CTAG_ALLCLASS = list(every single class datum that exists outside of the parent)
*/
	var/list/sorted_class_categories = list()


/*
	We init and build the retard azz listszz
*/
/datum/controller/subsystem/role_class_handler/Initialize()
	build_dumbass_category_lists()

	rebuild_drifter_time_string()
	if(drifter_queue_enabled)
		handle_drifter_wave_scheduling()

	initialized = TRUE

	return ..()


// This covers both class datums and drifter waves
/datum/controller/subsystem/role_class_handler/proc/build_dumbass_category_lists()
	var/list/all_drifter_waves = list()
	init_subtypes(/datum/drifter_wave, all_drifter_waves) // Init all the drifter waves
	sorted_drifter_wave_categories[DTAG_ALLWAVES] = all_drifter_waves

	for(var/datum/drifter_wave/stupidass_datum in all_drifter_waves)
		for(var/dtag in stupidass_datum.drifter_wave_categories)
			if(!sorted_drifter_wave_categories[dtag])
				sorted_drifter_wave_categories[dtag] = list()
			sorted_drifter_wave_categories[dtag] += stupidass_datum


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
	// insure they somehow aren't closing the datum they got and opening a new one w rolls
	var/datum/class_select_handler/GOT_IT = class_select_handlers[H.client.ckey]
	if(GOT_IT)
		if(!GOT_IT.linked_client) // this ref will disappear if they disconnect neways probably, as its a client
			GOT_IT.linked_client = H.client // Thus we just give it back to them
		GOT_IT.second_step() // And give them a second dose of something they already dosed on
		return

	var/datum/class_select_handler/XTRA_MEATY = new()
	XTRA_MEATY.linked_client = H.client

	var/datum/job/roguetown/RT_JOB = SSjob.GetJob(H.job)
	if(RT_JOB.drifter_wave_attachment) // We got a drifter wave attachment, time to setup a different and specific set of information, yaaay two job systems
		var/datum/drifter_wave/dwave = RT_JOB.drifter_wave_attachment
		XTRA_MEATY.class_cat_alloc_attempts = dwave.advclass_cat_rolls
		XTRA_MEATY.class_cat_alloc_bypass_reqs = dwave.class_cat_alloc_bypass_reqs
		XTRA_MEATY.class_cat_plusboost_attempts = dwave.class_cat_plusboost_attempts

		XTRA_MEATY.forced_class_additions = dwave.forced_class_additions
		XTRA_MEATY.forced_class_bypass_reqs = dwave.forced_class_bypass_reqs
		XTRA_MEATY.forced_class_plusboost = dwave.forced_class_plusboost
	else
		if(RT_JOB.advclass_cat_rolls.len)
			XTRA_MEATY.class_cat_alloc_attempts = RT_JOB.advclass_cat_rolls

	if(H.client.ckey in special_session_queue)
		XTRA_MEATY.special_session_queue = list()
		for(var/funny_key in special_session_queue[H.client.ckey])
			var/datum/advclass/XTRA_SPECIAL = special_session_queue[H.client.ckey][funny_key]
			if(XTRA_SPECIAL.maximum_possible_slots > XTRA_SPECIAL.total_slots_occupied)
				XTRA_MEATY.special_session_queue += XTRA_SPECIAL

	XTRA_MEATY.initial_setup()
	class_select_handlers[H.client.ckey] = XTRA_MEATY


/*
	Attempt to finish the class handling ordeal, aka they picked something
	Since this is class handler related, might as well also have the class handler send itself into the params
*/
/datum/controller/subsystem/role_class_handler/proc/finish_class_handler(mob/living/carbon/human/H, datum/advclass/picked_class, datum/class_select_handler/related_handler, plus_factor, special_session_queue)
	if(!picked_class || !related_handler || !H) // ????????? This is realistically only going to happen when someones doubling up or trying to href exploit
		return FALSE
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

	//If we get any plus factor at all, we run the datums boost proc on the human also.
	if(plus_factor) 
		picked_class.boost_by_plus_power(plus_factor, H)


	// In retrospect, If I don't just delete these Ill have to actually attempt to keep track of when a byond browser window is actually open lol
	// soooo..... this will be the place where we take it out, as it means they finished class selection, and we can safely delete the handler.
	related_handler.ForceCloseMenus() // force menus closed
	
	// Remove the key from the list and with it the value too
	class_select_handlers.Remove(related_handler.linked_client.ckey)
	// Call qdel on it
	qdel(related_handler)

	adjust_class_amount(picked_class, 1) // adjust the amount here, we are handling one guy right now.

// A dum helper to adjust the class amount, we could do it elsewhere but this will also inform any relevant class handlers open.
/datum/controller/subsystem/role_class_handler/proc/adjust_class_amount(datum/advclass/target_datum, amount)
	target_datum.total_slots_occupied += amount

	if((target_datum.total_slots_occupied >= target_datum.maximum_possible_slots)) // We just hit a cap, iterate all the class handlers and inform them.
		for(var/CUCKS in class_select_handlers)
			var/datum/class_select_handler/found_menu = class_select_handlers[CUCKS]
			
			if(target_datum in found_menu.rolled_classes) // We found the target datum in one of the classes they rolled aka in the list of options they got visible,
				found_menu.rolled_class_is_full(target_datum) //  inform the datum of its error.




