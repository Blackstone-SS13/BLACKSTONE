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
		menu.first_show_drifter_queue_menu()
	else
		menu = new()
		drifter_queue_menus[C.ckey] = menu
		menu.linked_client = C
		menu.first_show_drifter_queue_menu()

// Attempt to add a client to play in the next drifter wave
/datum/controller/subsystem/role_class_handler/proc/attempt_to_add_client_to_drifter_wave(client/target_client)
	if(target_client in drifter_wave_joined_clients)
		return FALSE
	var/datum/drifter_wave/current_wave = drifter_wave_schedule[current_wave_number]
	if(drifter_wave_joined_clients.len >= current_wave.maximum_playercount)
		return FALSE

	drifter_wave_joined_clients += target_client
	return TRUE

// Remove client from playing in next drifter wave
/datum/controller/subsystem/role_class_handler/proc/remove_client_from_drifter_wave(client/target_client)
	if(target_client in drifter_wave_joined_clients)
		drifter_wave_joined_clients -= target_client
		return TRUE
	return FALSE

//Shitty proc thats just for a general cleanup
/datum/controller/subsystem/role_class_handler/proc/cleanup_drifter_queue(client/target_client)
	remove_client_from_drifter_wave(target_client)
	remove_drifter_queue_viewer(target_client)
