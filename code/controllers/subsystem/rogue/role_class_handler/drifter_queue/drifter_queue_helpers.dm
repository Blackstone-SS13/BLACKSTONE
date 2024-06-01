// Toggle the ss on and off along with all the things lookign for whether this is enabled
/datum/controller/subsystem/role_class_handler/proc/toggle_drifter_queue()
	drifter_queue_enabled = !drifter_queue_enabled
	can_fire = !can_fire

// Time to go mister menu
/datum/controller/subsystem/role_class_handler/proc/remove_drifter_queue_viewer(client/C)
	var/datum/drifter_queue_menu/menu = drifter_queue_menus[C.ckey]
	if(menu)
		if(menu.linked_client)
			menu.ForceCloseMenus()
			menu.linked_client = null
		drifter_queue_menus.Remove(C.ckey)
		qdel(menu)


//They click the button on prefs and we make a new menu datum and stick a ref to their client on it
/datum/controller/subsystem/role_class_handler/proc/add_drifter_queue_viewer(client/C)
	var/datum/drifter_queue_menu/menu = drifter_queue_menus[C.ckey]
	if(menu)
		if(!menu.linked_client)
			menu.linked_client = C
		menu.show_drifter_queue_menu()
	else
		menu = new()
		drifter_queue_menus[C.ckey] = menu
		menu.linked_client = C
		menu.show_drifter_queue_menu()
