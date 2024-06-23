
/obj/structure/flora/roguegrass/tangler
	name = "grass"
	desc = "Green, soft and....I think I saw it move!"
	icon = 'icons/roguetown/mob/monster/tangler.dmi'
	icon_state = "tangler"
	max_integrity = 5
	var/faction = list("plants")

/obj/structure/flora/roguegrass/tangler/update_icon()
	return

/obj/structure/flora/roguegrass/tangler/real
	var/aggroed = 1
	max_integrity = 40
	integrity_failure = 0.15
	attacked_sound = 'sound/misc/woodhit.ogg'
	var/list/eatablez = list(/obj/item/bodypart, /obj/item/organ, /obj/item/reagent_containers/food/snacks/rogue/meat)
	var/last_eat
	buckle_lying = 0
	buckle_prevents_pull = 1

/obj/structure/flora/roguegrass/tangler/real/Initialize()
	. = ..()
	proximity_monitor = new(src, 1)

/obj/structure/flora/roguegrass/tangler/real/Destroy()
	QDEL_NULL(proximity_monitor)
	unbuckle_all_mobs()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/structure/flora/roguegrass/tangler/real/obj_break(damage_flag)
	..()
	QDEL_NULL(proximity_monitor)
	unbuckle_all_mobs()
	STOP_PROCESSING(SSobj, src)
	update_icon()

/obj/structure/flora/roguegrass/tangler/real/process()
	if(!has_buckled_mobs())
		if(world.time > last_eat + 5)
			var/list/around = view(1, src)
			for(var/mob/living/M in around)
				HasProximity(M)
				return
			for(var/obj/item/F in around)
				if(is_type_in_list(F, eatablez))
					aggroed = world.time
					last_eat = world.time
					playsound(src,'sound/misc/eat.ogg', rand(30,60), TRUE)
					qdel(F)
					return
		if(world.time > aggroed + 60 SECONDS)
			aggroed = 0
			update_icon()
			STOP_PROCESSING(SSobj, src)
			return TRUE

/obj/structure/flora/roguegrass/tangler/real/update_icon()
	if(obj_broken)
		name = "dry vine"
		desc = "" // i think this might break, dunno
		icon_state = "tangler-dead"
		return
	if(aggroed)
		name = "twisting vine"
		icon_state = "tangler"
	else
		name = "twisting vine"
		icon_state = "tangler-hidden"

/obj/structure/flora/roguegrass/tangler/real/user_unbuckle_mob(mob/living/M, mob/user)
	if(obj_broken)
		..()
		return
	if(isliving(user))
		var/mob/living/L = user
		var/time2mount = CLAMP((L.STASTR * 2), 1, 99)
		user.changeNext_move(CLICK_CD_RAPID)
		if(user != M)
			if(prob(time2mount))
				..()
			else
				user.visible_message("<span class='warning'>[user] tries to pull [M] free of [src]!</span>")
			return
		if(prob(time2mount))
			..()
		else
			user.visible_message("<span class='warning'>[user] tries to break free of [src]!</span>")

/obj/structure/flora/roguegrass/tangler/real/user_buckle_mob(mob/living/M, mob/living/user) //Don't want them getting put on the rack other than by spiking
	return

/obj/structure/flora/roguegrass/tangler/real/HasProximity(atom/movable/AM)
	if(has_buckled_mobs())
		return
	if(world.time > last_eat + 5)
		var/list/around = view(src, 1) // scan for enemies
		if(!(AM in around))
			return
		if(istype(AM, /mob/living))
			var/mob/living/L = AM
			if(!aggroed)
				if(L.m_intent != MOVE_INTENT_RUN)
					return
			aggroed = world.time
			last_eat = world.time
			update_icon()
			buckle_mob(L, TRUE, check_loc = FALSE)
			START_PROCESSING(SSobj, src)
			if(!HAS_TRAIT(L, TRAIT_NOPAIN))
				L.emote("painscream", forced = FALSE)
			src.visible_message("<span class='danger'>[src] snatches [L]!</span>")
			playsound(src.loc, "plantcross", 100, FALSE, -1)
		if(istype(AM, /obj/item))
			if(is_type_in_list(AM, eatablez))
				aggroed = world.time
				last_eat = world.time
				START_PROCESSING(SSobj, src)
				update_icon()
				playsound(src,'sound/misc/eat.ogg', rand(30,60), TRUE)
				qdel(AM)
				return
			aggroed = world.time
/obj/structure/flora/roguegrass/tangler/real/attackby(obj/item/W, mob/user, params)
	. = ..()
	aggroed = world.time
	update_icon()
