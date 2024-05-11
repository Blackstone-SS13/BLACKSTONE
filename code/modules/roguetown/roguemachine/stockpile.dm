/obj/structure/roguemachine/stockpile
	name = "stockpile"
	desc = ""
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "stockpile_vendor"
	density = FALSE
	blade_dulling = DULLING_BASH
	pixel_y = 32
	var/budget = 0

/proc/stock_announce(message)
	for(var/obj/structure/roguemachine/stockpile/S in SSroguemachine.stock_machines)
		S.say(message, spans = list("info"))

/obj/structure/roguemachine/stockpile/Initialize()
	. = ..()
	SSroguemachine.stock_machines += src

/obj/structure/roguemachine/stockpile/Destroy()
	SSroguemachine.stock_machines -= src
	return ..()

/obj/structure/roguemachine/stockpile/attackby(obj/item/P, mob/user, params)
	if(istype(P, /obj/item/roguecoin))
		budget += P.get_real_price()
		qdel(P)
		update_icon()
		playsound(loc, 'sound/misc/machinevomit.ogg', 100, TRUE, -1)
		return attack_hand(user)
	..()

/obj/structure/roguemachine/stockpile/Topic(href, href_list)
	. = ..()
	if(!usr.canUseTopic(src, BE_CLOSE))
		return
	if(href_list["navigate"])
		return attack_hand(usr, href_list["navigate"])
	if(href_list["withdraw"])
		var/datum/roguestock/D = locate(href_list["withdraw"]) in SStreasury.stockpile_datums
		if(!D)
			return
		if(D.withdraw_disabled)
			return
		if(D.held_items <= 0)
			say("Insufficient stock.")
			return
		if(D.withdraw_price > budget)
			say("Insufficient mammon.")
		else
			D.held_items--
			budget -= D.withdraw_price
			SStreasury.give_money_treasury(D.withdraw_price, "stockpile withdraw")
			var/obj/item/I = new D.item_type(loc)
			var/mob/user = usr
			if(!user.put_in_hands(I))
				I.forceMove(get_turf(user))
			playsound(src, 'sound/misc/hiss.ogg', 100, FALSE, -1)
		return attack_hand(usr, "withdraw")
	if(href_list["change"])
		if(!usr.canUseTopic(src, BE_CLOSE))
			return
		if(ishuman(usr))
			if(budget > 0)
				budget2change(budget, usr)
				budget = 0
		return attack_hand(usr, "withdraw")

	// If we don't get a valid option, default to returning to the directory
	return attack_hand(usr, "directory")
	

/obj/structure/roguemachine/stockpile/proc/get_directory_contents()
	var/contents = "<center>TOWN STOCKPILE<BR>"
	contents += "--------------</center><BR>"

	contents += "<a href='?src=[REF(src)];navigate=withdraw'>Withdraw Goods</a><BR>"
	contents += "<a href='?src=[REF(src)];navigate=deposit'>Check Current Deposit Prices</a><BR><BR>"
	
	return contents

/obj/structure/roguemachine/stockpile/proc/get_withdraw_contents()
	var/contents = "<center>TOWN STOCKPILE<BR>"
	contents += "<a href='?src=[REF(src)];navigate=directory'>(back)</a><BR>"
	contents += "--------------<BR>"
	contents += "<a href='?src=[REF(src)];change=1'>Stored Mammon: [budget]</a></center><BR>"

	for(var/datum/roguestock/stockpile/A in SStreasury.stockpile_datums)
		contents += "[A.name]<BR>"
		contents += "[A.desc]<BR>"
		contents += "Stockpiled Amount: [A.held_items]<BR>"
		if(!A.withdraw_disabled)
			contents += "<a href='?src=[REF(src)];withdraw=[REF(A)]'>\[Withdraw ([A.withdraw_price])\]</a><BR><BR>"
		else
			contents += "Withdrawing Disabled...<BR><BR>"
	
	return contents

/obj/structure/roguemachine/stockpile/proc/get_deposit_contents()
	var/contents = "<center>SUBMISSION HOLE<BR>"
	contents += "<a href='?src=[REF(src)];navigate=directory'>(back)</a><BR>"
	contents += "----------<BR>"
	contents += "</center>"

	for(var/datum/roguestock/bounty/R in SStreasury.stockpile_datums)
		contents += "[R.name] - [R.payout_price][R.percent_bounty ? "%" : ""]"
		contents += "<BR>"

	contents += "<BR>"

	for(var/datum/roguestock/stockpile/R in SStreasury.stockpile_datums)
		contents += "[R.name] - [R.payout_price] - [R.demand2word()]"
		contents += "<BR>"

	return contents

/obj/structure/roguemachine/stockpile/attack_hand(mob/living/user, menu_name)
	. = ..()
	if(.)
		return
	user.changeNext_move(CLICK_CD_MELEE)
	playsound(loc, 'sound/misc/keyboard_enter.ogg', 100, FALSE, -1)

	var/contents
	if(menu_name == "withdraw")
		contents = get_withdraw_contents()
	else if(menu_name == "deposit")
		contents = get_deposit_contents()
	else
		contents = get_directory_contents()
	
	var/datum/browser/popup = new(user, "VENDORTHING", "", 370, 220)
	popup.set_content(contents)
	popup.open()

/obj/structure/roguemachine/stockpile/attackby(obj/item/P, mob/user, params)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(istype(P, /obj/item/natural/bundle))
			say("Single item entries only. Please unstack.")
			return
		if(istype(P, /obj/item/roguecoin))
			if(H in SStreasury.bank_accounts)
				SStreasury.generate_money_account(P.get_real_price(), H)
				qdel(P)
				playsound(src, 'sound/misc/coininsert.ogg', 100, FALSE, -1)
				return
			else
				say("No account found. Submit your fingers to a shylock for inspection.")
		else
			for(var/datum/roguestock/R in SStreasury.stockpile_datums)
				if(istype(P,R.item_type))
					if(!R.check_item(P))
						continue
					var/amt = R.get_payout_price(P)
					if(!R.transport_item)
						R.held_items += 1 //stacked logs need to check for multiple
						qdel(P)
						stock_announce("[R.name] has been stockpiled.")
					else
						var/area/A = GLOB.areas_by_type[R.transport_item]
						if(!A)
							say("Couldn't find where to send the submission.")
							return
						P.submitted_to_stockpile = TRUE
						var/list/turfs = list()
						for(var/turf/T in A)
							turfs += T
						var/turf/T = pick(turfs)
						P.forceMove(T)
						playsound(T, 'sound/misc/hiss.ogg', 100, FALSE, -1)
					playsound(loc, 'sound/misc/disposalflush.ogg', 100, FALSE, -1)
					flick("submit_anim",src)
					if(amt)
						if(!SStreasury.give_money_account(amt, H, "+[amt] from [R.name] bounty"))
							say("No account found. Submit your fingers to a shylock for inspection.")
					return

	
