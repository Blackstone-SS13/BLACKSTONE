/obj/structure/roguemachine/bounty
	name = "Excidium"
	desc = ""
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "atm-b" // TODO: change this
	density = FALSE
	blade_dulling = DULLING_BASH

	/// State of the machine, can be turned on or off by the King
	var/state = TRUE

	/// List of all created and non-completed bounties
	var/list/bounties = list()

/datum/bounty
	var/target
	var/amount
	var/reason
	var/employer

	/// Whats displayed when consulting the bounties
	var/banner


///Composes a random bounty banner based on the given bounty info.
///@param new_bounty:  The bounty datum.
/obj/structure/roguemachine/bounty/proc/compose_bounty(var/datum/bounty/new_bounty)
	var/random_phrasing = rand(1, 3)
	if(random_phrasing == 1)
		new_bounty.banner += "A dire bounty hangs upon the head of [new_bounty.target], for '[new_bounty.reason]'.<BR>"
		new_bounty.banner += "The patron, [new_bounty.employer], offers [new_bounty.amount] mammons for the task.<BR>"	
	else if(random_phrasing == 2)
		new_bounty.banner += "The head of [new_bounty.target] is wanted for '[new_bounty.reason]''.<BR>"
		new_bounty.banner += "The employer, [new_bounty.employer], offers [new_bounty.amount] mammons for the deed.<BR>"
	else
		new_bounty.banner += "[new_bounty.employer] hath offered to pay [new_bounty.amount] mammons for the head of [new_bounty.target].<BR>"
		new_bounty.banner += "By reason of the following: '[new_bounty.reason]'.<BR>"
	new_bounty.banner += "--------------<BR>"

///Shows all active bounties to the user.
/obj/structure/roguemachine/bounty/proc/consult_bounties(var/mob/living/carbon/human/user)

	if(bounties.len == 0)
		say("No bounties are currently active.")
		return

	var/consult_menu
	consult_menu += "<center>BOUNTIES<BR>"
	consult_menu += "--------------<BR>"
	for(var/datum/bounty/saved_bounty in bounties)
		consult_menu += saved_bounty.banner

	var/datum/browser/popup = new(user, "BOUNTIES", "", 500, 300)
	popup.set_content(consult_menu)
	popup.open()

///Sets a bounty on a target player through user input.
///@param user: The player setting the bounty.
/obj/structure/roguemachine/bounty/proc/set_bounty(var/mob/living/carbon/human/user)
	var/list/eligible_players = list()
	for(var/mob/living/H in GLOB.player_list)
		if(H.client)
			//if(H != user) //Removed for testing
			eligible_players += H.real_name
		
	var/target = input(user, "Whose name shall be etched on the wanted list?", src) as null|anything in eligible_players
	if(isnull(target))
		say("No target selected.")
		return

	var/amount = input(user, "How many mammons shall be stained red for their demise?", src) as null|num
	if(isnull(amount) || amount < 1)
		say("Invalid amount.")
		return

	// Has user a bank account?
	if(!(user in SStreasury.bank_accounts))
		say("You have no bank account.")
		return

	// Has user enough money?
	if(SStreasury.bank_accounts[user] < amount)
		say("Insufficient balance funds.")
		return

	var/reason = input(user, "For what sins do you summon the hounds of hell?", src) as null|text
	if(isnull(reason) || reason == "")
		say("No reason given.")
		return

	var/confirm = input(user, "Do you dare unleash this darkness upon the world? Your name will be known.", src) as null|anything in list("Yes", "No")	
	if(isnull(confirm) || confirm == "No") return

	// Deduct money from user
	SStreasury.bank_accounts[user] -= round(amount)

	//Deduct royal tax from amount
	var/royal_tax = round(amount * 0.15)
	SStreasury.treasury_value += royal_tax
	amount -= royal_tax


	// Finally create bounty
	var/datum/bounty/new_bounty = new /datum/bounty
	new_bounty.amount = round(amount)
	new_bounty.target = target
	new_bounty.reason = reason
	new_bounty.employer = user.real_name
	compose_bounty(new_bounty)
	bounties += new_bounty

	say("The bounty has been set.")
	playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)

/obj/structure/roguemachine/bounty/attack_hand(mob/user)

	if(state == FALSE)
		say("By King's decree, the Excidium is currently inactive.")
		playsound(src, 'sound/misc/machineno.ogg', 100, FALSE, -1)
		sleep(3 SECONDS)
		return

	if(!ishuman(user)) return

	// We need to check the user's bank account later
	var/mob/living/carbon/human/H = user

	// Main Menu
	var/list/choices = list("Consult bounties", "Set bounty")
	var/selection = input(user, "The Excidium listens", src) as null|anything in choices

	switch(selection)

		if("Consult bounties")
			consult_bounties(H)

		if("Set bounty")
			set_bounty(H)

/obj/structure/roguemachine/bounty/attackby(obj/item/P, mob/user, params)

	if(state == FALSE) //vulnerable to spam abuse?
		say("By King's decree, the Excidium is currently inactive.")
		playsound(src, 'sound/misc/machineno.ogg', 100, FALSE, -1)
		return

	if(!(ishuman(user))) return

	// Only heads are allowed
	if(P.type != /obj/item/bodypart/head) return

	// Save the head in case it's not the right one
	var/obj/item/bodypart/head/stored_head = P
	var/correct_head = FALSE

	qdel(P)
	//TODO: add nom nom sounds
	var/random_say = rand(1, 3)
	if(random_say == 1)
		say("Commencing cephalic dissection...")
	else if(random_say == 2)
		say("Analyzing skull structure...")
	else
		say("Performing intra-cranial inspection...")
	sleep(3 SECONDS)
	for(var/datum/bounty/b in bounties)
		if(b.target == stored_head.real_name)
			correct_head = TRUE
			say("I have been sated.")
			playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1) 
			bounties -= b
		//TODO: give out reward

	// No valid bounty for this head?
	if(correct_head == FALSE)
		say("This skull carries no price.")
		playsound(src, 'sound/misc/machineno.ogg', 100, FALSE, -1)
		var/obj/item/bodypart/head/incorrect_head = new stored_head(src.loc)
		//spawn the head back



