/obj/structure/roguemachine/bounty
	name = "Excidium"
	desc = ""
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "atm-b"
	density = FALSE
	blade_dulling = DULLING_BASH


/obj/structure/roguemachine/bounty/attack_hand(mob/user)
	if(!ishuman(user)) return

	var/mob/living/carbon/human/H = user

/obj/structure/roguemachine/atm/attackby(obj/item/P, mob/user, params)
