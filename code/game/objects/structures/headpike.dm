/obj/structure/headpike
	name = "head on a pike"
	desc = ""
	icon = 'icons/obj/structures.dmi'
	icon_state = "headpike"
	density = FALSE
	anchored = TRUE

	var/obj/item/grown/log/tree/small/pike
	var/obj/item/bodypart/head/stored_head

/obj/structure/headpike/log //needs a log, right?
	icon_state = "" // not sure what goes here
	pike = TRUE

/obj/structure/headpike/CheckParts(list/parts_list)
	..()
	stored_head = locate(/obj/item/bodypart/head) in parts_list
	name = "[stored_head.name]'s head"
	update_icon()
	pike = locate(/obj/item/grown/log/tree/small) in parts_list

/obj/structure/headpike/Initialize()
	. = ..()
	pixel_x = rand(-8, 8)

/obj/structure/headpike/update_icon()
	..()
	var/obj/item/bodypart/head/H = locate() in contents
	var/mutable_appearance/MA = new()
	if(H)
		MA.copy_overlays(H)
		MA.pixel_y = 12
		add_overlay(H)

/obj/structure/headpike/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	to_chat(user, "<span class='notice'>I take down [src].</span>")
	stored_head.forceMove(drop_location())
	stored_head = null
	pike.forceMove(drop_location())
	pike = null
	qdel(src)
