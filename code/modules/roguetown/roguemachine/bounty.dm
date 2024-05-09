/obj/structure/roguemachine/bounty
	name = "Excidium"
	desc = ""
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "atm-b" // TODO: change this
	density = FALSE
	blade_dulling = DULLING_BASH

	/// List of all created and non-completed bounties
	var/list/bounties = list()

/datum/bounty
	var/target
	var/amount
	var/reason
	var/employer 

///Shows all active bounties to the user.
/obj/structure/roguemachine/bounty/proc/consult_bounties(var/mob/living/carbon/human/user)

	if(bounties.len == 0)
		say("No bounties are currently active.")
		return

	var/consult_menu
	consult_menu += "<center>BOUNTIES<BR>"
	consult_menu += "--------------<BR>"
	for(var/datum/bounty/saved_bounty in bounties)
		var/random_phrasing = rand(1, 3)
		if(random_phrasing == 1)
			consult_menu += "A dire bounty hangs upon the head of [saved_bounty.target], for '[saved_bounty.reason]'.<BR>"
			consult_menu += "The patron, [saved_bounty.employer], offers [saved_bounty.amount] mammons for the task.<BR>"	
		else if(random_phrasing == 2)
			consult_menu += "The head of [saved_bounty.target] is wanted for '[saved_bounty.reason]''.<BR>"
			consult_menu += "The employer, [saved_bounty.employer], offers [saved_bounty.amount] mammons for the deed.<BR>"
		else
			consult_menu += "[saved_bounty.employer] hath offered to pay [saved_bounty.amount] mammons for the head of [saved_bounty.target].<BR>"
			consult_menu += "By reason of the following: '[saved_bounty.reason]'.<BR>"
		consult_menu += "--------------<BR>"

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

	// Finally create bounty
	var/datum/bounty/new_bounty = new /datum/bounty
	new_bounty.amount = round(amount)
	new_bounty.target = target
	new_bounty.reason = reason
	new_bounty.employer = user.real_name
	bounties += new_bounty
	say("The bounty has been set.")
	playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)

/obj/structure/roguemachine/bounty/attack_hand(mob/user)
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
		stored_head.forceMove(src.loc)



