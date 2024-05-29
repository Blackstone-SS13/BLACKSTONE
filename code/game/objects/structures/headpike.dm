/obj/structure/headpike
	name = "[victim.name]'s head on a pike"
	desc = "oh yike, head on a pike"
	icon = 'icons/obj/structures.dmi'
	icon_state = "headpike"
	density = FALSE
	anchored = TRUE
	var/obj/item/log/stake
	var/obj/item/bodypart/head/victim

/obj/structure/headpike/log //needs a log, right?
	icon_state = "" // not sure what goes here
	log_stake = TRUE

/obj/structure/headpike/CheckParts(list/parts_list)
	..()
	victim = locate(/obj/item/bodypart/head) in parts_list
	name = "[victim.name]'s head"
	update_icon()
	if(log_stake)
		stake = locate(/obj/item/log/log_stake) in parts_list
	else
		stake = locate(/obj/item/log/stake) in parts_list

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
	victim.forceMove(drop_location())
	victim = null
	stake.forceMove(drop_location())
	stake = null
	qdel(src)
