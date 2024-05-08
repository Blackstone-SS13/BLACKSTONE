/obj/structure/roguemachine/bounty
	name = "Excidium"
	desc = ""
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "atm-b"
	density = FALSE
	blade_dulling = DULLING_BASH

	/// List of all created and non-completed bounties
	var/list/bounties = list()

/datum/bounty
	var/amount
	var/target
	var/reason


/obj/structure/roguemachine/bounty/attack_hand(mob/user)
	if(!ishuman(user)) return

	var/mob/living/carbon/human/H = user

	// menu will look like this:
	// 1. Consult bounties
	// 2. Create bounty

	// Main Menu
	var/list/choices = list("Consult bounties", "Set bounty")
	var/selection = input(user, "The Excidium listens", src) as null|anything in choices
	switch(selection)
		if("Consult bounties")

			//...

		if("Set bounty")

			// Set bounty procedure
			var/target = input(user, "Whose name shall be etched on the wanted list?", src) as GLOB.player_list
			if(!target)
				say("No target selected.")
				return

			var/amount = input(user, "How much silver shall be stained red for their demise?", src) as num
			if(amount < 1 || !amount)
				say("Invalid amount.")
				return

			var/reason = input(user, "For what sin do you summon the hounds of hell?", src) as text
			if(reason == ""	|| !reason)
				say("No reason given.")
				return

			var/confirm = input(user, "Do you dare to unleash this darkness upon the world?", src) as null|anything in list("Yes", "No")	
			if(confirm == "No" || !confirm) return

			say("Bounty set.")
			//now the Excidium waits X seconds for the user to insert the sum
			//else the procedure fails
			
			// Create bounty
			var/datum/bounty/new_bounty
			new_bounty.amount = amount
			//new_bounty.target = target
			new_bounty.reason = reason
			bounties += new_bounty
			say("Bounty set.")

/obj/structure/roguemachine/atm/attackby(obj/item/P, mob/user, params)
	if(ishuman(user)) return

	//if you're putting a head...


