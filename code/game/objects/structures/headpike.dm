/obj/structure/headpike
	name = "headpike"
	desc = ""
	icon = 'icons/obj/structures.dmi'
	icon_state = "headpike"
	density = FALSE
	anchored = TRUE

	//var/obj/item/grown/log/tree/small/pike
	//var/obj/item/bodypart/head/stored_head

/*
/obj/structure/headpike/log //needs a log, right?
	icon_state = "" // not sure what goes here
	pike = TRUE
	*/
/*
/obj/structure/headpike/CheckParts(list/parts_list)
	..()
	stored_head = locate(/obj/item/bodypart/head) in parts_list
	name = "[stored_head.name]'s head"
	update_icon()
	pike = locate(/obj/item/grown/log/tree/small) in parts_list
*/
	var/list/pikedhead = list() // contain the head/s that will be on the pike
	var/current_heads = 0 // start with no heads
	var/maximum_heads = 3 // you can stack up to 3 heads on the pike

	

/obj/structure/headpike/Initialize()
	. = ..()
	pixel_x = rand(-8, 8)
	update_icon()

/obj/structure/headpike/update_icon()
	..()
	/*
	var/obj/item/bodypart/head/H = locate() in contents
	var/mutable_appearance/MA = new()
	if(H)
		MA.copy_overlays(H)
		MA.pixel_y = 12
		add_overlay(H)
	*/
	if(pikedhead.len == 0)
		return
	else if (pikedhead.len == 1)
		//overlays += /obj/item/bodyparts/head.icon_state
		pixel_y += 2
	else if (pikedhead.len == 2)
		//overlays += /obj/item/bodyparts/head
		pixel_y += 2
		//overlays += /obj/item/bodyparts/head
		pixel_y += 8
	else if (pikedhead.len == 3)
		//overlays += /obj/item/bodyparts/head
		pixel_y += 2
		//overlays += /obj/item/bodyparts/head
		pixel_y += 8
		//overlays += /obj/item/bodyparts/head
		pixel_y += 14

/obj/structure/headpike/examine(mob/user)
	if(pikedhead.len == 1)
		desc = "1 person's head is on this pike."
	if(pikedhead.len == 2)
		desc = "There are 2 heads on this pike."
	if(pikedhead.len == 3)
		desc = "There are 3 heads on this pike!"
	if(pikedhead.len == 0)
		desc = "This pike has no heads. That can be fixed."
	

/obj/structure/headpike/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/bodypart/head))
		if(pikedhead.len < maximum_heads)
			pikedhead.Add(/obj/item/bodypart/head)
			to_chat(user, "<span class='notice'>I add a head to the pike.</span>")
		if(pikedhead.len == maximum_heads)
			to_chat(user, "<span class='notice'>There's no room on this pike for another head!</span>")
	return
	qdel(src)
