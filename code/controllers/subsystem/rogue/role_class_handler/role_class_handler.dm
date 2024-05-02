/*
	Basically we got a subsystem for the shitty subjob handling and new menu as of 4/30/2024 that goes with it
*/

SUBSYSTEM_DEF(role_class_handler)
	name = "Role Class Handler"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_ROLE_CLASS_HANDLER

	/*
		This one is important, its all the open class select handlers
	*/
	var/list/active_menus


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
*/
/datum/controller/subsystem/role_class_handler/proc/setup_class_handler(mob/living/carbon/human/H)
	// insure they somehow aren't closing the datum they got and opening a new one.
	var/pre_existing_handler = FALSE
	for(var/datum/class_select_handler/get_it in active_menus)
		if(get_it.linked_client == H.client)
			get_it.fire_slop_into_my_mouth()
			pre_existing_handler = TRUE
			break

	if(!pre_existing_handler)
		var/datum/class_select_handler/XTRA_MEATY = new()
		XTRA_MEATY.linked_client = H.client
		XTRA_MEATY.fire_slop_into_my_mouth()
		active_menus += XTRA_MEATY


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

	// Time for cleanup, you can also just change it to a qdel, this stuff is also cleaned out in the destroy() on the class handler.
	related_handler.ForceCloseMenus() // force menus closed
	// Cleanup anything holding references, aka these lists holding refs to class datums and the other two
	related_handler.linked_client = null 
	related_handler.cur_picked_class = null
	related_handler.viable_combat_classes = null
	related_handler.viable_free_classes = null
	related_handler.rolled_classes = null
	// and now we remove our one reference to it and it should be gone unironically unless I missed something
	active_menus -= related_handler

	adjust_class_amount(picked_class, 1) // adjust the amount here, we are handling one guy right now.

// A dum helper to adjust the class amount, we could do it elsewhere but this will also inform any relevant class handlers open.
/datum/controller/subsystem/role_class_handler/proc/adjust_class_amount(datum/advclass/target_datum, amount)
	target_datum.total_slots_occupied += amount

	if(target_datum.total_slots_occupied >= target_datum.maximum_possible_slots) // We just hit a cap, iterate all the class handlers and inform them.
		for(var/datum/class_select_handler/CUCKS in active_menus)
			if(target_datum in CUCKS.rolled_classes) // We found the target datum in one of the classes they rolled aka in the list of options they got visible,
				CUCKS.rolled_class_is_full(target_datum) //  inform the datum of its error.
