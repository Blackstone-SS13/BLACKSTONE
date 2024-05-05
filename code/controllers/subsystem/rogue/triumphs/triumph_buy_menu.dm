

/datum/triumph_buy_menu
	//These are the menu datum vars
	var/client/linked_client
	var/triumph_quantity = 108 // The amount of triumphs we got

	var/current_page = "1" // Current page of triumphs we are viewing and yes its a number in a string
	var/current_category = TRIUMPH_CAT_ROUND_EFX //Current category we are viewing

	var/page_count = 0

/datum/triumph_buy_menu/New()
	..()

/datum/triumph_buy_menu/proc/triumph_menu_startup_slop()
	var/datum/asset/thicc_assets = get_asset_datum(/datum/asset/simple/blackedstone_browser_slop_layout)
	thicc_assets.send(linked_client)

	show_menu()


// TRIUMPH BUY MENU SIDED PROC
/datum/triumph_buy_menu/proc/show_menu()
	var/data = {"
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<html>
		<head>
			<style>
				@import url('https://fonts.googleapis.com/css2?family=VT323&display=swap');
				@import url('https://fonts.googleapis.com/css2?family=Jacquarda+Bastarda+9&display=swap');
				@import url('https://fonts.googleapis.com/css2?family=Silkscreen:wght@400;700&display=swap');
				@import url('https://fonts.googleapis.com/css2?family=Nosifer&display=swap');
			</style>
			<link rel='stylesheet' type='text/css' href='slop_menustyle2.css'>
		</head>
	"}

	data += {"
		<body>
			<div id='triumph_quantity'> I currently have: [SStriumphs.get_triumphs(linked_client.key)] Triumphs</div>
			<div><span id='top_categories'>CATEGORIES:</span>
		"}

	for(var/cat_key in SStriumphs.central_state_data)
		if(cat_key == current_category)
			data += "<a class='triumph_categories_selected' href='?src=\ref[src];select_a_category=[cat_key]'><span class='bigunder_back'><span class='bigunder'></span>[cat_key]</span></a>"
			continue
		data += "<a class='triumph_categories_normal' href='?src=\ref[src];select_a_category=[cat_key]'>[cat_key]</a>"

	data += {"
			</div>
			<table>
				<thead>
					<tr>
						<th class='triumph_text_head'>Description</th>
						<th class='triumph_text_head'>Triumph Cost</th>
						<th class='triumph_text_head'>Buy Button</th>
					</tr>
				</thead>
				<tbody>
	"}

	if(current_category == TRIUMPH_CAT_ACTIVE_DATUMS)
		if(SStriumphs.active_triumph_buy_queue.len)
			for(var/datum/triumph_buy/auugh in SStriumphs.active_triumph_buy_queue)
				if((!auugh.visible_on_active_menu) && (linked_client.key != auugh.key_of_buyer)) // If we aren't visible on active menu and the menu owner's key isn't the same as key of buyer
					continue
				data += {"
					<tr class='triumph_text_row'>
						<td class='triumph_text_desc'>[auugh.desc] | Bought by: [auugh.key_of_buyer]</td>
						<td class='triumph_filler_cells'><span class='triumph_cost'>[auugh.triumph_cost]</span></td>
						<td class='triumph_filler_cells'><a class='triumph_text_buy' href='?src=\ref[src];handle_buy_button=\ref[auugh];'>UNBUY</a></td>
					</tr>
				"}
		else
			data += {"
				<tr class='triumph_text_row'>
					<td class='triumph_text_desc'>CURRENTLY NOTHING</td>
					<td class='triumph_filler_cells'><span class='triumph_cost'>ACTIVELY</span></td>
					<td class='triumph_filler_cells'><a class='triumph_text_buy' href='?src=\ref[src];'>HERE</a></td>
				</tr>
			"}

	else
		for(var/datum/triumph_buy/current_check in SStriumphs.central_state_data[current_category]["[current_page]"])
			data += {"
				<tr class='triumph_text_row'>
					<td class='triumph_text_desc'>[current_check.desc]</td>
					<td class='triumph_filler_cells'><span class='triumph_cost'>[current_check.triumph_cost]</span></td>
				"}

			var/string = "<td class='triumph_filler_cells'><a class='triumph_text_buy' href='?src=\ref[src];handle_buy_button=\ref[current_check];'>BUY</a></td>"
			if(SSticker.current_state == GAME_STATE_PLAYING && current_check.pre_round_only)
				string = "<td class='triumph_filler_cells'><a class='triumph_text_buy' href='?src=\ref[src];handle_buy_button=\ref[current_check];'><span class='strikethru_back'>CONFLICT</span></a></td>"
			else
				for(var/datum/triumph_buy/conflict_check in SStriumphs.active_triumph_buy_queue)
					if(current_check.type in conflict_check.conflicts_with) // We are in an active datum's conflicts with
						string = "<td class='triumph_filler_cells'><a class='triumph_text_buy' href='?src=\ref[src];handle_buy_button=\ref[current_check];'><span class='strikethru_back'>CONFLICT</span></a></td>"

			data += string
			data += "</tr>"



	data += {"
				</tbody>
			</table>
			"}
	data += "<div class='triumph_footer'>"

	for(var/i in 1 to SStriumphs.central_state_data[current_category].len)

		if("[i]" == current_page)
			data += "<a class='triumph_numbers_selected' href='?src=\ref[src];select_a_page=[i]'><span class='num_bigunder_back'><span class='num_bigunder'></span>[i]</span></a>"
		else
			data += "<a class='triumph_numbers_normal' href='?src=\ref[src];select_a_page=[i]'>[i]</a>"

	data += "</div>"
	data += {"
		</body>
	</html>
	"}

	linked_client << browse(data, "window=triumph_buy_window;size=500x760;can_close=1;can_minimize=0;can_maximize=0;can_resize=0;titlebar=1")

// TRIUMPH BUY MENU SIDED PROC
/datum/triumph_buy_menu/Topic(href, list/href_list)
	. = ..()

	if(href_list["select_a_category"])
		var/sent_category = href_list["select_a_category"]
		if(SStriumphs.central_state_data[sent_category])
			if(sent_category != current_category)
				current_category = sent_category
				show_menu()

	if(href_list["select_a_page"])
		var/sent_page = href_list["select_a_page"]
		if(SStriumphs.central_state_data[current_category]["[sent_page]"])
			if(sent_page != current_page)
				current_page = sent_page
				show_menu()

	//This sends a reference to a datum, 
	if(href_list["handle_buy_button"])
		var/datum/triumph_buy/target_datum = locate(href_list["handle_buy_button"])
		if(target_datum)
			var/conflicting = FALSE

			for(var/datum/triumph_buy/current_actives in SStriumphs.active_triumph_buy_queue)
				if(target_datum.type in current_actives.conflicts_with)
					conflicting = TRUE

			if(SSticker.current_state == GAME_STATE_PLAYING && target_datum.pre_round_only)
				conflicting = TRUE

			if(!conflicting)
				// Well we already made sure it wasn't going to conflict before we sent the path in, im sleepy and I hope this isn't REALLY fuckedu p when i look at it later
				if(current_category == TRIUMPH_CAT_ACTIVE_DATUMS) // ACTIVE datums are ones already bought anyways
					SStriumphs.attempt_to_unbuy_triumph_condition(linked_client, target_datum) // By unbuy, i mean you unbuy someone elses buy and thus we need a ref to it anyways
				else
					SStriumphs.attempt_to_buy_triumph_condition(linked_client, target_datum.type) // regular buy, just send over the type for a duplicate
			show_menu()

	