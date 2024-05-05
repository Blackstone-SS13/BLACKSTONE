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
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_ROLE_CLASS_HANDLER

	/*
		This one is important, its all the open class select handlers
		Its an assc list too active_menus[ckey] = /datum/class_select_handler
		If someone makes one they shouldn't be getting a new one in the current session
	*/
	var/list/active_menus


	/*
		This one is just an assc list, basically
		"ckey" = num to track the rerolls per server session attached to a ckey.
		You are only getting THREE (by default)
	*/
	var/list/session_rerolls

	/*
		This one is kinda retarded, its basically for datums certain ckeys will get in the session
		"ckey" = list(the datums), which will be its own copy that the person its hooked to can drain numbers out of on their own.
	*/
	var/list/special_session_queue

//Time for sloppa vars
	// List of all classes, assc list: Name - Datum
	var/list/all_classes

	// List of all classes that don't fall in any good criteria to be combat oriented
	var/list/free_classes

	// List of all classes that are favorable for combat
	var/list/combat_classes
	
	// List of all classes villagers can be (These are townies)
	var/list/villager_classes

	// List of all antag classes avail
	var/list/antag_classes


/*
	We init and build the retard azz listszz
*/
/datum/controller/subsystem/role_class_handler/Initialize()
	build_dumbass_class_lists()

	initialized = TRUE

	return ..()


/datum/controller/subsystem/role_class_handler/proc/build_dumbass_class_lists()
	all_classes = list()
	init_subtypes(/datum/advclass, all_classes) // Init all the classes

	// Idk make some lists?
	session_rerolls = list()
	special_session_queue = list()
	free_classes = list()
	combat_classes = list()
	villager_classes = list()
	antag_classes = list()

	//Time to sort these retards, and sort them we shall.
	for(var/datum/advclass/retard_datum in all_classes)
		if(retard_datum.category_flags & (RT_TYPE_DISABLED_CLASS)) // shits disabled
			continue

		if(retard_datum.category_flags & (RT_TYPE_FREE_CLASS))
			free_classes += retard_datum
		
		if(retard_datum.category_flags & (RT_TYPE_COMBAT_CLASS))
			combat_classes += retard_datum

		if(retard_datum.category_flags & (RT_TYPE_VILLAGER_CLASS))
			villager_classes += retard_datum

		if(retard_datum.category_flags & (RT_TYPE_ANTAG_CLASS))
			antag_classes += retard_datum

	//init list to hold active class select handlers (aka menu data)
	active_menus = list(
	)

	//Well that about covers it really.


/*
	We setup the class handler here, aka the menu
	We will cache it per server session via an assc list with a ckey leading to the datum.
*/
/datum/controller/subsystem/role_class_handler/proc/setup_class_handler(mob/living/carbon/human/H)
	// Also insure we somehow don't call this without a ref in the params
	if(H)
		// insure they somehow aren't closing the datum they got and opening a new one w rolls
		var/datum/class_select_handler/GOT_IT = active_menus[H.client.ckey]
		if(GOT_IT)
			if(!GOT_IT.linked_client) // this ref will disappear if they disconnect neways probably, as its a client
				GOT_IT.linked_client = H.client // too bad the firing of slop just checks the mob for what it can even use anyways
			GOT_IT.fire_slop_into_my_mouth()
		else
			var/datum/class_select_handler/XTRA_MEATY = new()
			XTRA_MEATY.linked_client = H.client
			XTRA_MEATY.fire_slop_into_my_mouth()
			active_menus[H.client.ckey] = XTRA_MEATY

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
	var/obj/screen/advsetup/GET_IT_OUT = locate() in H.hud_used.static_inventory // dis line sux its basically a loop anyways if i remember
	qdel(GET_IT_OUT)
	H.cure_blind("advsetup")

	if(plus_factor) // If we get any plus factor at all, we run the datums boost proc on the human also.
		picked_class.boost_by_plus_power(plus_factor, H)


	// In retrospect, If I don't just delete these Ill have to actually attempt to keep track of when a byond browser window is actually open lol
	// soooo..... this will be the place where we take the out, as it means they finished class selection, and we can safely delete the handler.
	related_handler.ForceCloseMenus() // force menus closed
	
	// Remove the key from the list and with it the value too
	active_menus.Remove(related_handler.linked_client.ckey)
	// Call qdel on it
	qdel(related_handler)

	adjust_class_amount(picked_class, 1) // adjust the amount here, we are handling one guy right now.
	picked_class.extra_slop_proc_ending(H)

// A dum helper to adjust the class amount, we could do it elsewhere but this will also inform any relevant class handlers open.
/datum/controller/subsystem/role_class_handler/proc/adjust_class_amount(datum/advclass/target_datum, amount)
	target_datum.total_slots_occupied += amount

	if((target_datum.total_slots_occupied >= target_datum.maximum_possible_slots)) // We just hit a cap, iterate all the class handlers and inform them.
		for(var/CUCKS in active_menus)
			var/datum/class_select_handler/found_menu = active_menus[CUCKS]
			
			if(target_datum in found_menu.rolled_classes) // We found the target datum in one of the classes they rolled aka in the list of options they got visible,
				found_menu.rolled_class_is_full(target_datum) //  inform the datum of its error.

// If they aren't in the list, they get 3 by default.
/datum/controller/subsystem/role_class_handler/proc/get_session_rerolls(ckey)
	if(!session_rerolls[ckey])
		session_rerolls[ckey] = 3

	return session_rerolls[ckey]


/datum/controller/subsystem/role_class_handler/proc/adjust_session_rerolls(ckey, number)
	session_rerolls[ckey] += number


/datum/controller/subsystem/role_class_handler/proc/add_to_special_session_queue(ckey, datum)
	if(!special_session_queue[ckey])
		special_session_queue[ckey] = list()

	special_session_queue[ckey] += datum
