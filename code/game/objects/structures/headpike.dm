// basic item stuff
/obj/structure/headpike
	name = "headpike"
	desc = ""
	icon = 'icons/obj/structures.dmi' // reusing the headpike that already exists for now, i might change it later
	icon_state = "headpike"
	density = TRUE // make a wall of headpikes, fill your enemies with fear and disgust
	anchored = TRUE // can't be moved once it's made
	max_integrity = 10 // it's just a stick bro

	var/list/pikedhead = list() // contain the head/s that will be on the pike
	var/maximum_heads = 1 // only 1 head per pike for now while i figure the necessities out

/obj/structure/headpike/Initialize() // this initialize was already here so keeping it as is
	. = ..()
	pixel_x = rand(-8, 8)
	update_icon()

/obj/structure/headpike/update_icon()
	..()
	// check if there are heads in the list, and overlay them onto the pike
	var/obj/item/bodypart/head/H = locate() in pikedhead
	var/mutable_appearance/MA = new()
	if(H)
		MA.copy_overlays(H)
		MA.pixel_y = 30
		add_overlay(H)
	if(!(H))
		cut_overlays()

/obj/structure/headpike/attackby(obj/item/P, mob/user, params)
	// if user is not human, do nothing
	if(!(ishuman(user)))
		return
	// if item in hand is not a head, do nothing
	if(P.type != /obj/item/bodypart/head)
		return
	// if there is already a head contained, say so and do nothing
	if(pikedhead.len > 0)
		to_chat(user, "<span class='notice'>There's no room for another head.</span>")
		return

	// add the head to the list
	var/obj/item/bodypart/head/stored_head = P
	pikedhead.Add(P)
	// success message in chat
	to_chat(user, "<span class='notice'>I add [stored_head.name] onto the pike.</span>")
	playsound(src, "sound/foley/butcher.ogg", 50, FALSE, -1)
	// update the icon
	update_icon()
	// remove the head from the user's hand
	qdel(P)

/obj/structure/headpike/attack_hand(mob/user)
	. = ..()
	// if there is a head on the pike, give it to the user
	var/obj/item/bodypart/head/H = locate() in pikedhead
	if(H)
		user.put_in_active_hand(H)
		playsound(src, "sound/foley/butcher.ogg", 50, FALSE, -1)
		//success msg in chat
		to_chat(user, "I take down [H.name].")
		// then remove from the list and update the icon
		pikedhead.Remove(H)
		update_icon()

/obj/structure/headpike/examine(mob/user)
	. = ..()
	// check for heads in the list, and if they exist add a line that says the name of the head
	var/obj/item/bodypart/head/H = locate() in pikedhead
	if(H)
		. += "[H.name] is on this pike."

		
/*		
		if(pikedhead.len < maximum_heads)
			pikedhead.Add(/obj/item/bodypart/head)
			to_chat(user, "<span class='notice'>I add a head to the pike.</span>")
		if(pikedhead.len == maximum_heads)
			to_chat(user, "<span class='notice'>There's no room on this pike for another head!</span>")
	return
	qdel(src)
/obj/structure/headpike/dump_contents()
	var/atom/L = drop_location()
	for(var/atom/movable/AM in src)
		AM.forceMove(L)
	pikedhead = list()

/obj/structure/headpike/Destroy()
	
	return ..()
	*/
