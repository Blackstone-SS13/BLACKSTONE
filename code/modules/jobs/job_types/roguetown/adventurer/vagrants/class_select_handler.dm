var/datum/class_select_handler/global_data = null
#define CLASS_TYPE_FREE 1
#define CLASS_TYPE_COMBATANT 2


/datum/class_select_handler
	var/client/linked_client //jus fillin

	//Peasant type classes
	var/list/peasants = list(
	)

	//combatant type classes
	var/list/combatant = list(
	)

	var/cur_picked_class = "ERROR"

/datum/class_select_handler/New(target_client)
	global_data = src
	linked_client = target_client
	if(linked_client)
		preload_assets()

/datum/class_select_handler/proc/preload_assets()
	var/list/file_paths = list(
	'icons/roguetown/misc/try4.png',
	'icons/roguetown/misc/try4_border.png',
	'html/browser/slop_menustyle2.css',
	'icons/roguetown/misc/haha_skull.gif'
	)

	for(var/asses in file_paths)
		linked_client << browse_rsc(asses)

/datum/class_select_handler/proc/fire_slop_into_my_mouth()
	preload_assets()
	class_select_slop()
	browser_slop()

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

	var/total_free_class = 5
	var/total_combat_class = 3
	//var/total_antag = 1
	

	var/list/viable_free_classes = list()
	var/list/viable_combat_classes = list()

	//Ok so right here we would run through the all class list and sort for ones we can even use.
	for(var/datas in all_class)
		var/numba = all_class[datas]
		switch(numba)
			if(CLASS_TYPE_FREE)
				viable_free_classes += datas
			if(CLASS_TYPE_COMBATANT)
				viable_combat_classes += datas

	//We got all our things. We indeed do after-all need set amounts of each to display now, we need to cover gacha class+ system too.
	// They might also reroll too/something runs out and we need a replacement and we got it prepped

	// If for some reason we don't have the amounts to even cover what we want, reduce it
	if(total_free_class > viable_free_classes.len)
		total_free_class = viable_free_classes.len

	if(total_combat_class > viable_combat_classes.len)
		total_combat_class = viable_combat_classes.len

	var/list/rolled_classes = list()

	//Gacha time, maybe I get a SSR Hunter
	for(var/i=1, i <= total_free_class, i++)
		var/pickme = pick(viable_free_classes)
		if(pickme in rolled_classes)
			rolled_classes[pickme][1] += 1
			i--
			continue
		else
			rolled_classes[pickme] = list(0)

	
	//Getting a + on this will be harder because you get less rolls and theres usually a lot, but If you do its pretty major honestly.
	for(var/i=1, i <= total_combat_class, i++)
		var/combat_class = pick(viable_combat_classes)
		if(combat_class in rolled_classes)
			rolled_classes[combat_class][1] += 1
			i--
			continue
		else
			rolled_classes[combat_class] = list(0)
	
	for(var/key in rolled_classes)
		var/plus_str = ""
		if(rolled_classes[key][1] > 0)
			var/plus_factor = rolled_classes[key][1] 
			for(var/i in 1 to plus_factor)
				plus_str += "+"
		data += "<div class='class_bar_div'><a class='vagrant' href='?src=\ref[src];class_selected=1;selected_class=[key]'><img class='ninetysskull' src='haha_skull.gif' width=32 height=32>[key]<span id='green_plussa'>[plus_str]</span><img class='ninetysskull' src='haha_skull.gif' width=32 height=32></a></div>"
		//Ppl will try to edit the href if i leave boostpower in it, so we will just check the key against a saved copy of the picklist somewhere
		//

	data += "</div>"

	//Buttondiv Segment
	data += {"
	<div id='button_div'>
		<a class='bottom_buttons' href='?src=\ref[src];weiner="reroll"'>Reroll Classes</a><br>
		<a class='bottom_buttons' href='?src=\ref[src];weiner="reroll"'>Spend my Triumphs</a>
	</div>
	"}

	//Closing Tags
	data += {"
		</body>
	</html>
	"}

	linked_client << browse(data, "window=class_retard_shitto;size=330x430;can_close=0;can_minimize=0;can_maximize=0;can_resize=0;titlebar=1")

/datum/class_select_handler/proc/class_select_slop()

	var/test_desc = test_class_desc // This represents retrieving the class desc from the datum
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
				<span class="title_shit">Class Name:</span> <span class="post_title_shit">Bard</span><br>
				<span class="title_shit">Description:</span> <span class="post_title_shit">[test_desc]</span>
			</div>
				<div id='button_div'>
					<a class='class_desc_YES_LINK' href='?src=\ref[src];yes_to_class_select=1;'>This is my background</a><br>
					<a class='bottom_buttons' href='?src=\ref[src];weiner="reroll"'>I reject this background</a>
				</div>
			</div>
		</body>
	</html>
	"}

	linked_client << browse(data, "window=class_slect_for_retards;size=610x300;can_close=0;can_minimize=0;can_maximize=0;can_resize=0;titlebar=1")

/datum/class_select_handler/Topic(href, href_list)
	. = ..()
	if(href_list["class_selected"])
		var/selected_class = href_list["selected_class"]
//		world_msg("[selected_class]")
		cur_picked_class = selected_class
		class_select_slop()

	if(href_list["yes_to_class_select"])
//		world_msg("HIT YES ON CLASS SELECT")


	if(href_list["attempting_to_buy"])
		var/attempting_to_buy = href_list["attempting_to_buy"]
//		world_msg("[attempting_to_buy]")

	if(href_list["weiner"])
		var/data = href_list["weiner"]
		browser_slop()
//		world_msg("[data]")
		return

	if(href_list["retard_close"])
		linked_client << browse(null, "window=class_retard_shitto")

/datum/class_select_handler/proc/ForceCloseMenus()
	linked_client << browse(null, "window=class_retard_shitto")
	linked_client << browse(null, "window=class_slect_for_retards")
