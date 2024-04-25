

/datum/triumph_buy_menu
	var/client/linked_client

/datum/triumph_buy_menu/New()
	..()

/datum/triumph_buy_menu/proc/Display_Menu(client/user)
	var/triumph_quantity = SStriumphs.get_triumphs(user.key)

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
			<div id='triumph_quantity'> I currently have: [triumph_quantity] Triumphs</div>
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

	for(var/datum/triumph_buy/dd_titties in GLOB.triumph_buy_datums)
		data += {"
			<tr class='triumph_text_row'>
				<td class='triumph_text_filler'>[dd_titties.desc]</td>
				<td class='triumph_text_filler'><span class='triumph_cost'>[dd_titties.triumph_cost]</span></td>
				<td class='triumph_text_filler'><a class='triumph_text_buy' href='?src=\ref[src];attempting_to_buy=[dd_titties.triumph_buy_ID];'>BUY</a></td>
			</tr>
		"}


	data += {"
				</tbody>
			</table>
		</body>
	</html>
	"}

	linked_client << browse(data, "window=triomph_slect_f_tards;size=500x760;can_close=0;can_minimize=0;can_maximize=0;can_resize=0;titlebar=1")

/datum/triumph_buy_menu/Topic(href, list/href_list)
	. = ..()
	