/obj/item/fishingrod
	force = 12
	possible_item_intents = list(ROD_CAST, SPEAR_BASH)
	name = "fishing rod"
	desc = ""
	icon_state = "rod"
	icon = 'icons/roguetown/weapons/tools.dmi'
	sharpness = IS_BLUNT
	wlength = 33
	slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_HIP
	w_class = WEIGHT_CLASS_BULKY
	///The current bait that we have attached to our fishing rod
	var/obj/item/baited = null
	//attachments for the fishing rod
	var/obj/item/fishing/line/reel
	var/obj/item/fishing/hook/hook
	var/obj/item/fishing/lineattach/line //this last one isnt needed to fish
	//checks to see if currently fishing
	var/currentlyfishing
	//so that process() can check for actively held
	var/mob/living/fisher
	//these affect the below modifiers, and determine what you catch
	var/fishrarity
	var/fishtype
	var/fishsize
	//how much the velocity can change per tick
	var/acceleration
	//how fast the angle can change
	var/maxvelocity
	//degrees from target angle that wont affect fish desired angle
	var/errormargin
	//multiplier for angle change per angle of difference past margin of error, should not go above 10
	var/difficulty
	//the current desired angle, moves based on velocity
	var/target
	//fish health
	var/fishhealth
	//how many ticks the meter can be in the danger zone for before snapping, regenerates while input is at the target boundaries
	var/linehealth
	//time in ticks to hook a fish
	var/hookwindow
	//ui elements
	var/backdrop
	var/reelstate
	var/fishstate

/datum/intent/cast
	name = "cast"
	chargetime = 0
	noaa = TRUE
	misscost = 0
	icon_state = "inuse"
	no_attack = TRUE

/obj/item/fishingrod/attackby(obj/item/I, mob/user, params)
	if(istype(I,/obj/item/natural/worms))
		var/obj/item/natural/worms/W = I
		W.forceMove(src)
		baited = W
	else if(istype(I,/obj/item/fishing/bait))
		var/obj/item/natural/worms/W = I
		W.forceMove(src)
		baited = W
	else if(istype(I,/obj/item/natural/bundle/worms))
/*
	if(I.baitchance && !baited)
		user.visible_message("<span class='notice'>[user] hooks something to the line.</span>", \
							"<span class='notice'>I hook [I] to my line.</span>")
		playsound(src.loc, 'sound/foley/pierce.ogg', 50, FALSE)
		I.forceMove(src)
		baited = I
		if(istype(I,/obj/item/natural/worms))
			var/obj/item/natural/worms/W = I
			if(W.amt > 1)
				W.amt--
				var/obj/item/natural/worms/N = new W.type(src)
				baited = N
			else
				W.forceMove(src)
				baited = W
		update_icon()
		return
	. = ..()
*/

/obj/item/fishingrod/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -17,"sy" = -1,"nx" = 11,"ny" = -1,"wx" = -14,"wy" = 0,"ex" = 3,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

#define fishrarityweights = list("gold" = 1, "ultra" =40, "rare"=50, "com"=900)

/obj/item/fishingrod/proc/checkreqs(mob/living/user, turf/target)
	. = FALSE
	if(user.get_active_held_item() != src)//half of this code is basically ripped out of do_after, don't hold it against me
		return
	if(!user.Process_Spacemove(0) && user.inertia_dir)
		return
	if(user.doing)
		return
	if(get_dist(user, target) > 5)
		return
	if(L.IsStun() || L.IsParalyzed())
		return
	return TRUE

/obj/item/fishingrod/proc/createui(mob/living/user)
	backdrop = new /atom/movable/fishingoverlay/base
	reelstate = new /atom/movable/fishingoverlay/pointer1
	fishstate = new /atom/movable/fishingoverlay/pointer2
	user.client.screen += backdrop
	user.client.screen += reelstate
	user.client.screen += fishstate

/obj/item/fishingrod/proc/deleteui(mob/living/user)
	backdrop = null
	reelstate = null
	fishstate = null
	user.client.screen -= backdrop
	user.client.screen -= reelstate
	user.client.screen -= fishstate

/obj/item/fishingrod/proc/process()

/obj/item/fishingrod/afterattack(turf/target, mob/living/user, proximity)
	if(!check_allowed_items(target,target_self=1) \
	|| !istype(target, /turf/open/water) \
	|| user.used_intent.type != ROD_CAST \
	|| user.doing \
	|| !isliving(user) \
	)
		return

	if(get_dist(user, target) > 5)
		to_chat(current_fisherman, "<span class='warning'>It's too far away...</span>")
		return

	

/*

	var/mob/living/current_fisherman = user
	current_fisherman.visible_message("<span class='warning'>[current_fisherman] casts a line!</span>", \
						"<span class='notice'>I cast a line.</span>")
	playsound(loc, 'sound/items/fishing_plouf.ogg', 100, TRUE)
	var/atom/movable/fishingoverlay/overlay = new /atom/movable/fishingoverlay
	user.client.screen += overlay

	var/amt2raise = 0 //How much exp we gain on catch
	var/casting_time = (rand(8 SECONDS, 15 SECONDS)) //How long before a fish bites
	var/fishing_time = 3 SECONDS //How long to reel in our catch
	var/skill_level 
	if(current_fisherman.mind)
		skill_level = current_fisherman.mind.get_skill_level(/datum/skill/labor/fishing)
		if(skill_level)
			casting_time = clamp((casting_time - skill_level SECONDS), 1, 15 SECONDS) //Can't go under 1
			fishing_time = clamp((fishing_time / skill_level), 1, 3 SECONDS)

	if(!do_after(current_fisherman, casting_time, target = target))
		user.client.screen -= overlay
		return
	if(!baited)
		to_chat(current_fisherman, "<span class='warning'>This seems pointless.</span>")
		user.client.screen -= overlay
		return

	if(!prob(baited.baitchance))
		to_chat(current_fisherman, "<span class='warning'>Damn, got away...</span>")
		QDEL_NULL(baited)
		update_icon()
		user.client.screen-= overlay
		return

	to_chat(current_fisherman, "<span class='notice'>Something tugs the line!</span>")
	playsound(loc, 'sound/items/fishing_plouf.ogg', 100, TRUE)
	if(!do_after(current_fisherman, fishing_time, target = target))
		to_chat(current_fisherman, "<span class='warning'>Damn, got away...</span>")
		QDEL_NULL(baited)
		update_icon()
		user.client.screen -= overlay
		return

	var/caught_thing = pickweight(baited.fishloot)
	new caught_thing(current_fisherman.loc)
	amt2raise = current_fisherman.STAINT
	var/boon = user.mind.get_learning_boon(skill_level)
	playsound(loc, 'sound/items/Fish_out.ogg', 100, TRUE)
	user.client.screen -= overlay

	QDEL_NULL(baited)
	current_fisherman.mind.adjust_experience(/datum/skill/labor/fishing, amt2raise * boon) 
	update_icon()

*/

/obj/item/fishingrod/update_icon()
	cut_overlays()
	if(baited)
		var/obj/item/I = baited
		I.pixel_x = 6
		I.pixel_y = -6
		add_overlay(new /mutable_appearance(I))
	if(ismob(loc))
		var/mob/M = loc
		M.update_inv_hands()
