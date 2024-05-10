/*
	A fun fact is that it is important to note triumph procs all used key, whilas player quality likes to use ckey
	It doesn't help that the params to insert a json key in both are just key to go with byond clients having a ckey and key
*/

SUBSYSTEM_DEF(triumphs)
	name = "Triumphs"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_TRIUMPHS

	// List of top ten for display in browser page on button click
	var/list/triumph_leaderboard_top_ten

	// A path for triumphs
	var/triumphs_json_path = "data/triumphs.json"

	// A cache for triumphs
	// Basically when client first hops in for the session we will cram their ckey in and retrieve from file
	// When the server session is about to end we will write it all in.
	var/list/triumph_amount_cache = list(
	)




	/*
		TRIUMPH BUY MENU THINGS
								*/
	//init list to hold triumph buy menus for the session (aka menu data)
	// Assc list "ckey" = datum
	var/list/active_triumph_menus

	// display limit per page in a category on the user menu
	var/page_display_limit = 12

	// This represents the triumph buy organization on the main SS for triumphs
	// Each key is a category name
	// And then the list will have a number in a string that leads to a list of datums
	var/list/central_state_data 


	/*
		TRIUMPH BUY DATUM THINGS
										*/
	//this is basically the total list of triumph buy datums on init
	var/list/triumph_buy_datums 

	// This is a list of all active datums
	var/list/active_triumph_buy_queue 

	// These fire on_roundstart() right after roundstart
	var/list/fire_on_PostSetup 

	// These get on_activate() called in /datum/outfit/job/roguetown/post_equip() in roguetown.dm
	var/list/post_equip_calls 

/datum/controller/subsystem/triumphs/Initialize()
	. = ..()
	/*
		At roundstart we load the cache... all of it i guess
		This could be different if triumphs were saved in single file, 
		But they come in one chunk cause I can't think of a better way to do topten rn
	*/
	var/json_file = file(triumphs_json_path)
	if(!fexists(json_file)) // If we don't have a file at all, just fill in some blank shit
		WRITE_FILE(json_file, "{}")
		triumph_amount_cache = list()
	else
		triumph_amount_cache = json_decode(file2text(json_file))

	if(!triumph_leaderboard_top_ten)
		triumph_leaderboard_top_ten = get_triumphs_top()

	fire_on_PostSetup = list()
	triumph_buy_datums = list() // init empty list
	active_triumph_buy_queue = list()
	active_triumph_menus = list()
	post_equip_calls = list()

	central_state_data = list(
		TRIUMPH_CAT_ROUND_EFX = 0,
		TRIUMPH_CAT_CHARACTER = 0,
		TRIUMPH_CAT_MISC = 0,
		TRIUMPH_CAT_ACTIVE_DATUMS = 0
	)


	for(var/cur_path in subtypesof(/datum/triumph_buy))
		var/datum/triumph_buy/cur_datum = new cur_path // We will do this
		triumph_buy_datums += cur_datum
		central_state_data[cur_datum.category] += 1 // Tally up the totals here to save on a total of one loop

	// Make a local copy I guess?
	var/list/copy_list = triumph_buy_datums.Copy()

	//Figure out how many lists we are about to make to represent the pages
	for(var/catty_key in central_state_data)
		var/page_count = ceil(central_state_data[catty_key]/page_display_limit) // Get the page count total
		central_state_data[catty_key] = list() // Now we swap the numbers out for lists on each cat as it will contain lists representing one page

		// Now fill in the lists starting at index "1" 
		for(var/page_numba in 1 to page_count)
			central_state_data[catty_key]["[page_numba]"] = list()
			for(var/ii = copy_list.len, ii > 0, ii--)
				var/datum/triumph_buy/current_triumph_buy_datum = copy_list[ii]
				if(current_triumph_buy_datum.category == catty_key)
					central_state_data[catty_key]["[page_numba]"] += current_triumph_buy_datum
					copy_list -= current_triumph_buy_datum
				if(central_state_data[catty_key]["[page_numba]"].len == page_display_limit)
					break

/*
	This occurs when you try to buy a triumph condition and sets it up
*/
/datum/controller/subsystem/triumphs/proc/attempt_to_buy_triumph_condition(client/C, triumph_buy_typepath)
	var/datum/triumph_buy/stick_it_in = new triumph_buy_typepath

	var/triumph_amount = get_triumphs(C.ckey) - stick_it_in.triumph_cost
	if(triumph_amount >= 0)
		triumph_adjust(stick_it_in.triumph_cost*-1, C.ckey)
		stick_it_in.key_of_buyer = C.key
		stick_it_in.ckey_of_buyer = C.ckey

		// These basically just auto occur when you buy them. Some stuff we don't need people to be able to counter-buy
		if(stick_it_in.fire_on_buy)
			stick_it_in.on_activate()
			return

		// These get a proc fired after the round just begins to help them setup
		if(stick_it_in.fire_on_PostSetup)
			fire_on_PostSetup += stick_it_in

		active_triumph_buy_queue += stick_it_in
		call_menu_refresh()
/*
	This occurs when you try to unbuy a triumph condition and removes it
*/
/datum/controller/subsystem/triumphs/proc/attempt_to_unbuy_triumph_condition(client/C, datum/triumph_buy/pull_it_out)
	var/triumph_amount = get_triumphs(C.ckey) - pull_it_out.triumph_cost
	if(triumph_amount >= 0)
		triumph_adjust(pull_it_out.triumph_cost*-1, C.ckey)
		active_triumph_buy_queue -= pull_it_out

// Same deal as the role class stuff, we are only really just caching this to update displays as people buy stuff.
// So we have to be careful to not leave it in when unneeded otherwise we will have to keep track of which menus are actually open.
/datum/controller/subsystem/triumphs/proc/startup_triumphs_menu(client/C)
	if(C)
		var/datum/triumph_buy_menu/check_this = active_triumph_menus[C.ckey]
		if(check_this)
			check_this.linked_client = C
			check_this.triumph_menu_startup_slop()
		else
			var/datum/triumph_buy_menu/BIGBOY = new()
			BIGBOY.linked_client = C
			active_triumph_menus[C.ckey] = BIGBOY
			BIGBOY.triumph_menu_startup_slop()

/*
	This tells all alive triumph datums to re_update their visuals, shitty but ya
*/
/datum/controller/subsystem/triumphs/proc/call_menu_refresh()
	for(var/MENS in active_triumph_menus)
		var/datum/triumph_buy_menu/current_view = active_triumph_menus[MENS]
		if(!current_view) // Insure we actually have something yes?
			active_triumph_menus.Remove(MENS)
			continue

		if(!current_view.linked_client) // We have something and it has no client
			active_triumph_menus.Remove(MENS)
			qdel(current_view)
			continue

		current_view.show_menu()

			


// We cleanup the datum thats just holding the stuff for displaying the menu.
/datum/controller/subsystem/triumphs/proc/remove_triumph_buy_menu(client/C)
	if(C && active_triumph_menus[C.ckey])
		var/datum/triumph_buy_menu/me_local = active_triumph_menus[C.ckey]
		C << browse(null, "window=triumph_buy_window")
		active_triumph_menus.Remove(C.ckey)
		qdel(me_local)

// Called from the place its slopped in in SSticker, this will occur right after the gamemode starts ideally, aka roundstart.
/datum/controller/subsystem/triumphs/proc/fire_on_PostSetup()
	call_menu_refresh()
	for(var/datum/triumph_buy/thing in fire_on_PostSetup)
		thing.on_PostSetup()




/*
	At round end we save the cache
*/
/datum/controller/subsystem/triumphs/proc/time_for_roundend()
	var/json_file = file(triumphs_json_path)
	if(!fexists(json_file))
		WRITE_FILE(json_file, "{}")

	fdel(json_file)
	WRITE_FILE(json_file, json_encode(triumph_amount_cache))



// Adjust triumphs
/datum/controller/subsystem/triumphs/proc/triumph_adjust(amt, ckey)
	if(ckey in triumph_amount_cache)
		triumph_amount_cache[ckey] += amt
	else
		triumph_amount_cache[ckey] = 0

// Wipe the triumphs of one person
/datum/controller/subsystem/triumphs/proc/wipe_target_triumphs(target_ckey)
	if(target_ckey)
		if(!(target_ckey in triumph_amount_cache))
			return
		else
			triumph_amount_cache[target_ckey] = 0

// Wipe the triumphs of everyone
// We will also wipe the file mostly cause someone might attempt to crash the server if this occurs
// (And they can go fuck themselves)
/datum/controller/subsystem/triumphs/proc/wipe_all_triumphs(target_ckey)
	if(!target_ckey)
		return
	triumph_amount_cache = list()

	var/json_file = file(triumphs_json_path)
	if(!fexists(json_file))
		WRITE_FILE(json_file, "{}")

	fdel(json_file)
	WRITE_FILE(json_file, json_encode(triumph_amount_cache))

// Return a value of the triumphs they got
/datum/controller/subsystem/triumphs/proc/get_triumphs(target_ckey)
	if(!(triumph_amount_cache[target_ckey]))
		triumph_amount_cache[target_ckey] = 0

	return triumph_amount_cache[target_ckey]

// Display leaderboard browser popup
/datum/controller/subsystem/triumphs/proc/triumph_leaderboard(client/C)
	if(!triumph_leaderboard_top_ten || !triumph_leaderboard_top_ten.len)
		triumph_leaderboard_top_ten = get_triumphs_top()
		message_admins("FAILED triumph_leaderboard_top_ten")
		return

	var/list/output = list("<B>CHAMPIONS OF PSYDONIA</B><br>")

	output += "<hr><br>"
	var/vals = 0
	for(var/X in triumph_leaderboard_top_ten)
		vals++
		if(vals >= 21)
			break
		output += "[vals]. [X] - [triumph_leaderboard_top_ten[X]]<br>"

	C << browse(output.Join(),"window=triumph_leaderboard_top_ten;size=300x500")

// Idk I didn't touch this one a ton
// Just sorts by numbers
/datum/controller/subsystem/triumphs/proc/get_triumphs_top()
	var/list/sorted_list = list()
	if(triumph_amount_cache.len)
		for(var/cache_key in triumph_amount_cache)
			if(!sorted_list.len)
				sorted_list[cache_key] = triumph_amount_cache[cache_key]

			for(var/sorted_key in sorted_list)
				if(sorted_list[sorted_key] < triumph_amount_cache[cache_key])
					sorted_list.Insert(sorted_list.Find(sorted_key), cache_key)
					sorted_list[cache_key] = triumph_amount_cache[cache_key]
					break

			if(sorted_list.Find(cache_key))
				continue
		
	return sorted_list

