/*
	Drifter Queue Shit, role_class_handler subsystem except hopefully most to all of the drifter queue shit is in here
*/
/datum/controller/subsystem/role_class_handler
	// List of drifter wave datums, created and crammed up this lists ass in the initialize for this subsystem
	var/list/drifter_wave_data_slabs = list()


	// assc list of ckeys linked to drifter queue menus if they got one which have client refs on them
	var/list/drifter_queue_menus = list()
	

	// List of things to handle in the fire()
	var/list/currentrun = list() 


	// Set this to true or false to stop the system/hide crap related to it hopefully lol
	var/drifter_queue_enabled = TRUE


	// Next time we fire
	var/next_drifter_mass_release_time = 0
	// Delay before next wave rn
	var/drifter_time_buffer = 10 MINUTES
	
	// The current wave
	var/datum/drifter_wave/current_wave
	// Schedule of drifter waves
	var/list/drifter_wave_schedule = list()
	// List of clients who have joined for the wave
	var/list/drifter_wave_joined_clients = list()
	// Number of waves we keep scheduled past the current one
	var/drifter_wave_schedule_buffer = 2
	// Current wave number we are on
	var/current_wave_number = 1
	// Current drop location target
	var/atom/drifter_dropzone_target

	// Whether its time to update the browser table
	var/queue_table_browser_update = FALSE
	// String vars for display menus
	var/drifter_queue_player_tbl_string = "DISABLED"
	var/time_left_until_next_wave_string = "DELAYED"

/*
	Hey we got somethin to keep track of now, which is drifter queue
	haha
*/
/datum/controller/subsystem/role_class_handler/fire(resumed = 0)
	if(!drifter_queue_enabled)
		can_fire = FALSE
		return

	if(!resumed)
		src.currentrun = drifter_queue_menus.Copy()

	//cache for sanic speed (lists are references anyways)
	var/list/currentrun = src.currentrun

	while(currentrun.len)
		var/current_ckey = currentrun[currentrun.len]
		var/datum/drifter_queue_menu/current_menu = currentrun[current_ckey]
		currentrun.len--
		
		if(!current_menu.linked_client)
			drifter_queue_menus.Remove(current_ckey)
			qdel(current_menu)
			continue
		
		var/client/target_client = current_menu.linked_client
		target_client << output(url_encode(time_left_until_next_wave_string), "drifter_queue.browser:update_timer")

		if(queue_table_browser_update)
			// This function wants the lefthand current wave player number and then the current table html
			target_client << output(list2params(list("[drifter_wave_joined_clients.len]", drifter_queue_player_tbl_string)), "drifter_queue.browser:update_playersegments")
			queue_table_browser_update = FALSE

		if(MC_TICK_CHECK)
			return

	rebuild_time_string()

// BRO DON'T FORGET TO REFACTOR CATEGORIES INTO STRINGS OR INTS OR SOME SHIT IN LISTS AND AUTOBUILD A CACHE VIA USING THAT AS KEYS

	// It is time
	if(world.time >= next_drifter_mass_release_time)
		to_chat(world, "Release Drifters")

		current_wave = drifter_wave_schedule[current_wave_number]

		if(!current_wave)
			return
		
		if(drifter_wave_joined_clients.len)
			if(!drifter_dropzone_target) // If you set some random crap to it it'll all go there otherwise its business as usual
				find_dropoff_location()

			for(var/client/target_client in drifter_wave_joined_clients)
				process_drifter_wave_client(target_client)

			drifter_wave_joined_clients.Cut()

		handle_drifter_wave_scheduling()
		current_wave_number++




// It would be my hope that anything going through here starts off as a /mob/dead/new_player
// Otherwise I will have to copypaste a ton of shit
// Also as you can see I already copy and pasted a ton of shit located on mob/dead/new_player/AttemptLateSpawn()
/datum/controller/subsystem/role_class_handler/proc/process_drifter_wave_client(client/target_client)
	var/mob/dead/new_player/ourguy = target_client.mob
	if(!ourguy)
		message_admins("DRIFTER QUEUE HAS BROKEN AND WE GOT SOME GUY WHO AIN'T ON CHAR SETUP! SHIIIET")
		return

	var/rank = current_wave.job_rank // you could technically have a wave of any fuckin job if you wanted ironically

	SSjob.AssignRole(ourguy, rank, 1)

	var/mob/living/character = ourguy.create_character(TRUE)	//creates the human and transfers vars and mind
	character.islatejoin = TRUE

	var/equip = SSjob.EquipRank(character, rank, TRUE)
	if(isliving(equip))	//Borgs get borged in the equip, so we need to make sure we handle the new mob.
		character = equip

	var/atom/movable/screen/splash/Spl = new(character.client, TRUE)
	Spl.Fade(TRUE)
	character.update_parallax_teleport()

	SSticker.minds += character.mind
	GLOB.joined_player_list += character.ckey

	var/fakekey = character.ckey
	if(target_client.ckey in GLOB.anonymize)
		fakekey = get_fake_key(character.ckey)

	GLOB.character_list[character.mobid] = "[fakekey] was [character.real_name] ([rank])<BR>"
	GLOB.character_ckey_list[character.real_name] = character.ckey
	log_character("[character.ckey] ([fakekey]) - [character.real_name] - [rank]")

	if(GLOB.respawncounts[character.ckey])
		var/AN = GLOB.respawncounts[character.ckey]
		AN++
		GLOB.respawncounts[character.ckey] = AN
	else
		GLOB.respawncounts[character.ckey] = 1

	character.forceMove(get_turf(drifter_dropzone_target))

	log_manifest(character.mind.key, character.mind, character,latejoin = TRUE)

// Attempt to find a place to put all these motherfuckers
/datum/controller/subsystem/role_class_handler/proc/find_dropoff_location()
	// This will be full of turfs
	var/list/potential_target_dropzones = list()
	if(current_wave.droppoint_landmark_types.len)
		for(var/obj/effect/landmark/cur_landmark in GLOB.landmarks_list)
			if(cur_landmark.type in current_wave.droppoint_landmark_types)
				potential_target_dropzones += cur_landmark      

	else if(SSjob.latejoin_trackers.len)
		potential_target_dropzones += pick(SSjob.latejoin_trackers)

	else
		message_admins("DRIFTER QUEUE HAS NO DROPZONE TARGET POINTS. SHIIIET!")
		return

	drifter_dropzone_target = pick(potential_target_dropzones)






