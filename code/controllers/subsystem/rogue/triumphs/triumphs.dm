SUBSYSTEM_DEF(triumphs)
	name = "Triumphs"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_TRIUMPHS
	var/list/topten

	var/list/triumph_buy_datums //this is basically the total list of triumph buy datums on init

	var/list/active_triumph_buy_queue // This is a list of all active datums

	//init list to hold triumph buy menus for the session (aka menu data)
	// Assc list "key" = datum
	var/list/active_triumph_menus

	// This represents the triumph buy organization on the main SS for triumphs
	// Each key is a category name
	// And then the list will have a number in a string that leads to a list of datums
	var/list/central_state_data 

	// display limit per page in a category on the user menu
	var/page_display_limit = 12

	var/list/fire_on_PostSetup // These fire on_roundstart() right after roundstart

	var/list/post_equip_calls

/datum/controller/subsystem/triumphs/Initialize()
	. = ..()
	if(!topten)
		topten = get_triumphs_top()

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

// TRIUMPH SS SIDED
/datum/controller/subsystem/triumphs/proc/attempt_to_buy_triumph_condition(client/C, triumph_buy_typepath)
	var/datum/triumph_buy/stick_it_in = new triumph_buy_typepath

	var/triumph_amount = get_triumphs(C.key) - stick_it_in.triumph_cost
	if(triumph_amount >= 0)
		triumph_adjust(stick_it_in.triumph_cost*-1, C.key)
		stick_it_in.key_of_buyer = C.key
		stick_it_in.ckey_of_buyer = C.ckey

		if(stick_it_in.fire_on_buy)
			stick_it_in.on_activate()
			return

		if(stick_it_in.fire_on_PostSetup)
			fire_on_PostSetup += stick_it_in

		active_triumph_buy_queue += stick_it_in

// TRIUMPH SS SIDED
/datum/controller/subsystem/triumphs/proc/attempt_to_unbuy_triumph_condition(client/C, datum/triumph_buy/pull_it_out)

	var/triumph_amount = get_triumphs(C.key) - pull_it_out.triumph_cost
	if(triumph_amount >= 0)
		triumph_adjust(pull_it_out.triumph_cost*-1, C.key)
		active_triumph_buy_queue -= pull_it_out

/datum/controller/subsystem/triumphs/proc/startup_triumphs_menu(client/C)
	if(C)
		var/datum/triumph_buy_menu/check_this = active_triumph_menus[C.key]
		if(check_this)
			check_this.linked_client = C
			check_this.triumph_menu_startup_slop()
		else
			var/datum/triumph_buy_menu/BIGBOY = new()
			BIGBOY.linked_client = C
			active_triumph_menus[C.key] = BIGBOY
			BIGBOY.triumph_menu_startup_slop()

/datum/controller/subsystem/triumphs/proc/fire_on_PostSetup()

	for(var/datum/triumph_buy/thing in fire_on_PostSetup)
		thing.on_PostSetup()


/datum/controller/subsystem/triumphs/proc/triumph_adjust(amt, key)
	var/curtriumphs = 0
	var/json_file = file("data/triumphs.json")
	if(!fexists(json_file))
		WRITE_FILE(json_file, "{}")
	var/list/json = json_decode(file2text(json_file))

	if(json[key])
		curtriumphs = json[key]
	curtriumphs += amt

	json[key] = curtriumphs

	fdel(json_file)
	WRITE_FILE(json_file, json_encode(json))

/datum/controller/subsystem/triumphs/proc/wipe_triumphs(key)
	var/json_file = file("data/triumphs.json")
	if(fexists(json_file))
		fdel(json_file)
//	WRITE_FILE(json_file, "{}")
//	var/list/json = json_decode(file2text(json_file))
	var/list/json = list()

	if(key)
		json[key] = 1

	WRITE_FILE(json_file, json_encode(json))

/datum/controller/subsystem/triumphs/proc/get_triumphs(key)
	var/json_file = file("data/triumphs.json")
	if(!fexists(json_file))
		return 0
	var/list/json = json_decode(file2text(json_file))

	if(json[key])
		return json[key]
	else
		triumph_adjust(0, key)
	return 0

/datum/controller/subsystem/triumphs/proc/triumph_leaderboard(mob/user)
	if(!topten || !topten.len)
		topten = get_triumphs_top()
	if(!topten || !topten.len)
		testing("FAILED TOPTEN")
		return
	if(!user)
		return
	var/list/outputt = list("<B>CHAMPIONS OF PSYDONIA</B><br>")

	outputt += "<hr><br>"
	var/vals = 0
	for(var/X in topten)
		vals++
		if(vals >= 21)
			break
		outputt += "[vals]. [X] - [topten[X]]<br>"

	if(outputt)
		user << browse(outputt.Join(),"window=topten;size=300x500")

/datum/controller/subsystem/triumphs/proc/get_triumphs_top(key)
	var/json_file = file("data/triumphs.json")
	if(!fexists(json_file))
		return list()
	var/list/json = json_decode(file2text(json_file))

	var/list/nulist = list()
	for(var/X in json)
		if(nulist.len)
			for(var/Y in nulist)
				if(nulist[Y] < json[X])
					nulist.Insert(nulist.Find(Y), X)
					nulist[X] = json[X]
					break
			if(nulist.Find(X))
				continue
		nulist += X
		nulist[X] = json[X]

	return nulist





