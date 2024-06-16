/obj/structure/handcart
	name = "cart"
	desc = "A wooden cart that will help you carry many things."
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "cart-empty"
	density = TRUE
	max_integrity = 600
	anchored = FALSE
	climbable = TRUE

	var/list/stuff_shit = list()

	var/current_capacity = 0
	var/maximum_capacity = 60 //arbitrary maximum amount of weight allowed in the cart before it says fuck off

	var/arbitrary_living_creature_weight = 10 // The arbitrary weight for any thing of a mob and living variety
	facepull = FALSE
	throw_range = 1

/obj/structure/handcart/Initialize(mapload)
	if(mapload)		// if closed, any item at the crate's loc is put in the contents
		addtimer(CALLBACK(src, PROC_REF(take_contents)), 0)
	. = ..()
	update_icon()

/obj/structure/handcart/container_resist(mob/living/user)
	var/atom/L = drop_location()
	for(var/atom/movable/AM in stuff_shit)
		if(AM == user)
			AM.forceMove(L)
			stuff_shit -= AM
			current_capacity = max(current_capacity-arbitrary_living_creature_weight, 0)
			update_icon()
			break

/obj/structure/handcart/dump_contents()
	var/atom/L = drop_location()
	for(var/atom/movable/AM in src)
		AM.forceMove(L)
	stuff_shit = list()
	current_capacity = 0

/obj/structure/handcart/Destroy()
	dump_contents()
	return ..()

/obj/structure/handcart/MouseDrop_T(atom/movable/O, mob/living/user)
	if(!istype(O) || !isturf(O.loc) || istype(O, /atom/movable/screen))
		return
	if(!istype(user) || user.incapacitated())
		return
	if(!Adjacent(user) || !user.Adjacent(O))
		return
	if(user == O) //try to climb into or onto it
		if(!(user.mobility_flags & MOBILITY_STAND))
			if(!do_after(user, 20, target = src))
				return FALSE
			if(put_in(O))
				playsound(loc, 'sound/foley/cartadd.ogg', 100, FALSE, -1)
			return TRUE
		return ..()
	if(!insertion_allowed(O))
		return
	//only these intents should be able to move objects into handcarts
	if(user.used_intent.type == INTENT_HELP || user.used_intent.type == /datum/intent/grab/move)
		if(isliving(O))
			var/list/targets = list(O, src)
			if(!do_after_mob(user, targets, 20))
				return FALSE
		if(put_in(O))
			playsound(loc, 'sound/foley/cartadd.ogg', 100, FALSE, -1)
		return TRUE

/obj/structure/handcart/attackby(obj/item/P, mob/user, params)
	if(!user.cmode)
		if(!insertion_allowed(P))
			return
		if(put_in(P, user))
			playsound(loc, 'sound/foley/cartadd.ogg', 100, FALSE, -1)
		return
	..()

/obj/structure/handcart/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(user.cmode)
		return
	var/turf/T = get_turf(user)
	if(isturf(T))
		user.changeNext_move(CLICK_CD_MELEE)
		var/fou
		for(var/obj/item/I in T)
			if(!insertion_allowed(I))
				continue
			put_in(I)
			fou = TRUE
		if(fou)
			playsound(loc, 'sound/foley/cartadd.ogg', 100, FALSE, -1)

/obj/structure/handcart/proc/put_in(atom/movable/O, mob/user)
	var/weight = 0
	if(isitem(O))
		var/obj/item/I = O
		if((current_capacity + I.w_class) > maximum_capacity)
			return FALSE
		weight = I.w_class
	if(isliving(O))
		if((current_capacity + arbitrary_living_creature_weight) > maximum_capacity)
			return FALSE
		weight = arbitrary_living_creature_weight
	if(user && !user.transferItemToLoc(O, src))
		return FALSE
	else
		O.forceMove(src)
	current_capacity += weight
	stuff_shit += O
	update_icon()
	return TRUE

/obj/structure/handcart/proc/take_contents()
	var/atom/L = drop_location()
	for(var/atom/movable/AM in L)
		if(AM != src && put_in(AM)) // limit reached
			break

/obj/structure/handcart/update_icon()
	. = ..()
	if(stuff_shit.len)
		icon_state = "cart-full"
	else
		icon_state = "cart-empty"

/obj/structure/handcart/attack_right(mob/user)
	. = ..()
	if(.)
		return
	user.changeNext_move(CLICK_CD_MELEE)
	if(stuff_shit.len)
		dump_contents()
		visible_message(span_info("[user] dumps out [src]!"))
		playsound(loc, 'sound/foley/cartdump.ogg', 100, FALSE, -1)
	update_icon()

/obj/structure/handcart/proc/insertion_allowed(atom/movable/AM)
	if(ismob(AM))
		if(!isliving(AM)) //let's not put ghosts or camera mobs inside closets...
			return FALSE
		var/mob/living/L = AM
		if(L.anchored || (L.buckled && L.buckled != src) || L.incorporeal_move || L.has_buckled_mobs())
			return FALSE
		if(L.mob_size > MOB_SIZE_TINY) // Tiny mobs are treated as items.
			if(L.density)
				return FALSE
		L.stop_pulling()

	else if(isobj(AM))
		if((AM.density) || AM.anchored || AM.has_buckled_mobs())
			return FALSE
		else
			if(isitem(AM))
				var/obj/item/I = AM
				if(HAS_TRAIT(I, TRAIT_NODROP) || I.item_flags & ABSTRACT)
					return FALSE
	else // not a mob or object
		return FALSE

	return TRUE
