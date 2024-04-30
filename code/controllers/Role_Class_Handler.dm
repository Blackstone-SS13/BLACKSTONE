GLOBAL_REAL(ROLE_CLASS_CON, /datum/controller/role_class_controller)

/*
	Idk, i was gonna make a global datum for dis shit neways mite as well jus use a controller for no discernable reason
*/
/datum/controller/role_class_controller
	name = "Role Class Handler"

	// List of all classes
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
	Time to build dumbazz lists which could be done anywhere really.
*/
/datum/controller/role_class_controller/Initialize()
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

	//Well that about covers it really.

