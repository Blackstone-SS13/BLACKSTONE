/*
	Here we go, the class select handler
*/
/datum/class_select_handler
	var/client/linked_client //the ss will link it!

	/*
		Well, we basically need to fill out our options
	*/
	// Free classes we can personally take with our current human rn
	var/list/viable_free_classes = list()

	// Combat classes we can personally take with our current human rn
	var/list/viable_combat_classes = list()
	var/list/combat_classes // a filler list cause i mite need to reuse it

	// Total amounts of each we get by default. Which is now ZERO HAHAHA!
	// Now its tied to the job file thats summoning our stupid datum menu azz
	var/total_free_class = 0
	var/total_combat_class = 0

	//classes we rolled, basically you get a datum followed by a number in here on how many times you rerolled it.
	var/list/rolled_classes = list()

	//Current class we takin
	var/datum/advclass/cur_picked_class
	var/plus_power = 0

	//Special forced entries , If your key is in here you autoget the contents of it on your options.
	var/list/ckey_special_classes = list()

	// If this is set to true we display all the challenge classes
	var/showing_challenge_classes = FALSE

// The normal route for first use of this list.
/datum/class_select_handler/proc/initial_setup()
	assemble_the_CLASSES()
	lower_quality_gacha_rolls()
	//preload_assets()

/datum/class_select_handler/proc/second_step()
	var/datum/asset/thicc_assets = get_asset_datum(/datum/asset/simple/blackedstone_browser_slop_layout)
	thicc_assets.send(linked_client)

	browser_slop()

/datum/class_select_handler/Destroy()
	ForceCloseMenus() // force menus closed
	// Cleanup anything holding references, aka these lists holding refs to class datums and the other two
	linked_client = null 
	cur_picked_class = null
	viable_combat_classes = null
	viable_free_classes = null
	rolled_classes = null
	ckey_special_classes = null
	. = ..()

// I hope to god you have a client before you call this, cause the checks on the SS
/datum/class_select_handler/proc/assemble_the_CLASSES()
	var/mob/living/carbon/human/H = linked_client.mob
	for(var/datum/advclass/FREES in SSrole_class_handler.free_classes)
		if(FREES.check_requirements(H))
			viable_free_classes += FREES
		
	for(var/datum/advclass/COMBATS in SSrole_class_handler.combat_classes)
		if(COMBATS.check_requirements(H))
			viable_combat_classes += COMBATS

	if(SSrole_class_handler.special_session_queue[linked_client.ckey])
		for(var/current_key in SSrole_class_handler.special_session_queue[linked_client.ckey])
			var/datum/advclass/SNOWFLAKES = SSrole_class_handler.special_session_queue[linked_client.ckey][current_key]
			if(SNOWFLAKES.check_requirements(H))
				ckey_special_classes += SNOWFLAKES
			
	// If for some reason we don't have the amounts to even cover what we want, reduce it
	if(total_free_class > viable_free_classes.len)
		total_free_class = viable_free_classes.len

	if(total_combat_class > viable_combat_classes.len)
		total_combat_class = viable_combat_classes.len

//The actual mathematics solution also was kind of fucked up along with the code one
// So we cope here as rolling some plusses on classes properly isn't worth it
/datum/class_select_handler/proc/lower_quality_gacha_rolls()
	// Begin rolling to our alotted amount
	var/list/free_classes = viable_free_classes.Copy()
	for(var/i=1, i <= total_free_class, i++) // We just do the normal thing
		var/datum/advclass/pickme = pick(free_classes) // Pick one
		free_classes -= pickme
		rolled_classes[pickme] = 0

	for(var/i in 1 to total_free_class)
		var/datum/advclass/pickme = pick(viable_free_classes)
		if(pickme in rolled_classes)
			rolled_classes[pickme] += 1
	
	if(total_combat_class)
		combat_classes = viable_combat_classes.Copy()
		for(var/i=1, i <= total_combat_class, i++) // We just do the normal thing
			var/datum/advclass/pickme = pick(combat_classes) // Pick one
			combat_classes -= pickme
			rolled_classes[pickme] = 0

		for(var/i in 1 to 2)
			var/datum/advclass/pickme = pick(viable_combat_classes)
			if(pickme in rolled_classes)
				rolled_classes[pickme] += 1


// Something is calling to tell this datum a class it rolled is currently maxed out.
// More shitcode!
/datum/class_select_handler/proc/rolled_class_is_full(datum/advclass/filled_class)

	rolled_classes -= filled_class // Remove it from rolled classes

	var/list/attempt_pick_list

	if(filled_class.category_flags & (RT_TYPE_FREE_CLASS))
		if(filled_class in viable_free_classes)
			viable_free_classes -= filled_class // Remove it from free classes
			attempt_pick_list = viable_free_classes

	if(filled_class.category_flags & (RT_TYPE_COMBAT_CLASS))
		if(filled_class in viable_combat_classes)
			viable_combat_classes -= filled_class // Remove it from combat classes
			attempt_pick_list = viable_combat_classes

	// And also make an arbitrary three attempts for no reason to get a new class in
	var/total_attempts = 3
	var/datum/advclass/attempted_pick
	for(var/i=1, i <= total_attempts, i++)
		attempted_pick = pick(attempt_pick_list)

		if(attempted_pick in rolled_classes)
			if(attempted_pick.category_flags & (RT_TYPE_COMBAT_CLASS))
				if(prob(30))
					rolled_classes[attempted_pick] += 1
			else
				rolled_classes[attempted_pick] += 1
			continue
		else
			rolled_classes[attempted_pick] = 0
			break

	if(cur_picked_class == filled_class)
		cur_picked_class = null

		if(linked_client) // In the current state we will still auto-adjust cached datums with no linked client
			linked_client << browse(null, "window=class_select_yea")

	if(linked_client) // So make sure we don't go further than this without one I guess
		browser_slop()

// ha ha ha
/datum/class_select_handler/proc/add_one_more_combat_slot()
	var/datum/advclass/pickme = pick(combat_classes) // Pick one
	combat_classes -= pickme
	rolled_classes[pickme] = 0

/datum/class_select_handler/proc/browser_slop()

	//Opening tags and empty head
	var/data = {"
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<html>
		<head>
			<style>
				@import url('https://fonts.googleapis.com/css2?family=VT323&display=swap');
				@import url('https://fonts.googleapis.com/css2?family=Jacquarda+Bastarda+9&display=swap');
			</style>
			<link rel='stylesheet' type='text/css' href='slop_menustyle2.css'>
		</head>
	"}

	//Body tag start
	data += "<body>"

	//Class href fill-in
	data += "<div id='top_handwriting'> The fates giveth... </div>"
	data += "<div id='class_select_box_div'>"


	//var/total_antag = 1
	
	for(var/datum/advclass/datums in rolled_classes)
		var/plus_str = ""
		if(rolled_classes[datums] > 0)
			var/plus_factor = rolled_classes[datums]

			for(var/i in 1 to plus_factor)
				plus_str += "+"
		data += "<div class='class_bar_div'><a class='vagrant' href='?src=\ref[src];class_selected=1;selected_class=\ref[datums];'><img class='ninetysskull' src='haha_skull.gif' width=32 height=32>[datums.name]<span id='green_plussa'>[plus_str]</span><img class='ninetysskull' src='haha_skull.gif' width=32 height=32></a></div>"
	if(ckey_special_classes.len)
		for(var/datum/advclass/datums in ckey_special_classes)
			data += "<div class='class_bar_div'><a class='vagrant' href='?src=\ref[src];special_selected=1;selected_special=\ref[datums];'><img class='ninetysskull' src='haha_skull.gif' width=32 height=32>[datums.name]<img class='ninetysskull' src='haha_skull.gif' width=32 height=32></a></div>"
	if(showing_challenge_classes)
		for(var/datum/advclass/datums in SSrole_class_handler.challenge_classes)
			data += "<div class='class_bar_div'><a class='vagrant' href='?src=\ref[src];class_selected=1;selected_class=\ref[datums];'><img class='ninetysskull' src='haha_skull.gif' width=32 height=32>[datums.name]<img class='ninetysskull' src='haha_skull.gif' width=32 height=32></a></div>"
	data += "</div>"

	//Buttondiv Segment
	data += "<div class='footer'>"
	var/rerolls_left = SSrole_class_handler.get_session_rerolls(linked_client.ckey)
	if(rerolls_left > 0)
		data += "<a class='bottom_buttons' href='?src=\ref[src];reroll=1'>Reroll Classes <span class='bottom_button_cost'>COST: 0</span></a><br>"
	// Incase someone wants them to be able to buy rerolls later lol
	/*
	else 
		data += "<a class='bottom_buttons' href='?src=\ref[src];buy_reroll=1'>Reroll COST:1</a><br>"
	*/

	data += {"
		<a class='mo_bottom_buttons' href='?src=\ref[src];add_combat_slot=1'>Extra Adventurer Class <span class='bottom_button_cost'>COST: 1</span></a><br>
		<a class='mo_bottom_buttons' href='?src=\ref[src];show_challenge_class=1'>Show Challenge Classes <span class='bottom_button_cost'>COST: 0</span></a><br>
	</div>
	"}

	//Closing Tags
	data += {"
		</body>
	</html>
	"}

	linked_client << browse(data, "window=class_handler_main;size=330x430;can_close=0;can_minimize=0;can_maximize=0;can_resize=1;titlebar=1")

/datum/class_select_handler/proc/class_select_slop()

	var/data = {"
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<html>
		<head>
			<style>
				@import url('https://fonts.googleapis.com/css2?family=VT323&display=swap');
				@import url('https://fonts.googleapis.com/css2?family=Jacquarda+Bastarda+9&display=swap');
				@import url('https://fonts.googleapis.com/css2?family=Silkscreen:wght@400;700&display=swap');
			</style>
			<link rel='stylesheet' type='text/css' href='slop_menustyle2.css'>
		</head>
		<body>
			<div id="top_bloc">
				<span class="title_shit">Class Name:</span> <span class="post_title_shit">[cur_picked_class]</span><br>
				<span class="title_shit">Description:</span> <span class="post_title_shit">[cur_picked_class.tutorial]</span>
			</div>
				<div id='button_div'>
					<a class='class_desc_YES_LINK' href='?src=\ref[src];yes_to_class_select=1;special_class=1;'>This is my background</a><br>
					<a class='bottom_buttons' href='?src=\ref[src];no_to_class_select=1'>I reject this background</a>
				</div>
			</div>
		</body>
	</html>
	"}

	linked_client << browse(data, "window=class_select_yea;size=610x300;can_close=0;can_minimize=0;can_maximize=0;can_resize=0;titlebar=1")

/datum/class_select_handler/Topic(href, href_list)
	. = ..()
	if(href_list["class_selected"])
		var/selected_class = href_list["selected_class"]
		var/locvar_check = locate(selected_class)
		
		if(locvar_check in rolled_classes) // Safety check. Make sure the thing that got rammed into the href is actually in the rolled list
			plus_power = rolled_classes[locvar_check]	// Get the plus power too
			cur_picked_class = locvar_check
			class_select_slop()
		return

	if(href_list["yes_to_class_select"]) // Send the data over and wrap it up.
		SSrole_class_handler.finish_class_handler(linked_client.mob, cur_picked_class, src, plus_power)
		return

	if(href_list["no_to_class_select"]) // Close the selector window
		plus_power = 0
		cur_picked_class = null
		linked_client << browse(null, "window=class_select_yea")
		return

	if(href_list["reroll"])
		var/rerolls_left = SSrole_class_handler.get_session_rerolls(linked_client.ckey)
		if(rerolls_left > 0)
			linked_client << browse(null, "window=class_select_yea")
			plus_power = 0
			cur_picked_class = null
			rolled_classes = list() // Make sure to empty this out
			lower_quality_gacha_rolls()
			SSrole_class_handler.adjust_session_rerolls(linked_client.ckey, -1)
			browser_slop()
		return

	// Unused rn, but its in the off-chance you want people to buy rerolls
	/*
	if(href_list["buy_reroll"])
		var/triumph_amount = SStriumphs.get_triumphs(linked_client.ckey) - 1
		if(triumph_amount >= 0)
			SStriumphs.triumph_adjust(-1, linked_client.ckey)
		linked_client << browse(null, "window=class_select_yea")
		plus_power = 0
		cur_picked_class = null
		rolled_classes = list() // Make sure to empty this out
		lower_quality_gacha_rolls()
		browser_slop()
	*/

	if(href_list["add_combat_slot"])
		if(total_combat_class+1 > viable_combat_classes.len)
			to_chat(linked_client, "<span class='warning'>You have every possible class your character could be! WOW!</span>")
			return

		var/triumph_amount = SStriumphs.get_triumphs(linked_client.ckey) - 1
		if(triumph_amount >= 0)
			SStriumphs.triumph_adjust(-1, linked_client.ckey)
			add_one_more_combat_slot()
			total_combat_class += 1 // Add one here in case they reroll all of them

		browser_slop()
		return

	if(href_list["show_challenge_class"])
		showing_challenge_classes = !showing_challenge_classes
		browser_slop()
		return

	if(href_list["special_selected"])
		var/special_class = href_list["selected_special"]
		var/locvar_check = locate(special_class)

		if(locvar_check in ckey_special_classes)
			cur_picked_class = locvar_check
			class_select_slop()
		return

/datum/class_select_handler/proc/ForceCloseMenus()
	linked_client << browse(null, "window=class_handler_main")
	linked_client << browse(null, "window=class_select_yea")



//This was theoretically really bad as it could technically be a infinite loop despite being more fun
/*
/datum/class_select_handler/proc/old_gacha_rolls()
	//Gacha time, maybe I get a SSR Hunter
	for(var/i=1, i <= total_free_class, i++)
		var/datum/advclass/pickme = pick(viable_free_classes)
		if(pickme in rolled_classes)
			rolled_classes[pickme] += 1
			i--
			continue
		else
			rolled_classes[pickme] = 0

	
	//Getting a + on this will be harder because you get less rolls and theres usually a lot, but If you do its pretty major honestly.
	for(var/i=1, i <= total_combat_class, i++)
		var/datum/advclass/combat_class = pick(viable_combat_classes)
		if(combat_class in rolled_classes)
			rolled_classes[combat_class] += 1
			i--
			continue 
		else
			rolled_classes[combat_class] = 0
*/
