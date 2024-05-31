/obj/item/natural/worms/leech
	name = "leech"
	desc = "A disgusting, blood-sucking parasite."
	icon = 'icons/roguetown/items/surgery.dmi'
	icon_state = "leech"
	baitchance = 100
	fishloot = list(/obj/item/reagent_containers/food/snacks/fish/carp = 5,
					/obj/item/reagent_containers/food/snacks/fish/eel = 5,
					/obj/item/reagent_containers/food/snacks/fish/angler = 1)
	embedding = list(
		"embed_chance" = 100,
		"embedded_unsafe_removal_time" = 0, 
		"embedded_pain_chance" = 0,
		"embedded_fall_chance" = 0,
		"embedded_bloodloss"= 0,
	)
	/// Are we giving or receiving blood?
	var/giving = FALSE
	/// How much blood we suck on on_embed_life()
	var/blood_sucking = 2
	/// How much toxin damage we heal on on_embed_life()
	var/toxin_healing = -2
	/// Amount of blood we have stored
	var/blood_storage = 0
	/// Maximum amount of blood we can store
	var/blood_maximum = BLOOD_VOLUME_SURVIVE

/obj/item/natural/worms/leech/Initialize()
	. = ..()
	//leech lore
	color = get_color()

/obj/item/natural/worms/leech/examine(mob/user)
	. = ..()
	switch(blood_storage/blood_maximum)
		if(0.9 to 1)
			. += "<span class='bloody'><B>[p_theyre(TRUE)] fat and engorged with blood.</B></span>"
		if(0.5 to 0.9)
			. += "<span class='bloody'>[p_theyre(TRUE)] well fed.</span>"
		if(0.1 to 0.5)
			. += "<span class='warning'>[p_they(TRUE)] want[p_s()] a meal.</span>"
		if(0 to 0.1)
			. += "<span class='dead'>[p_theyre(TRUE)] starved.</span>"

/obj/item/natural/worms/leech/attack(mob/living/M, mob/user)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		var/obj/item/bodypart/affecting = H.get_bodypart(check_zone(user.zone_selected))
		if(!affecting)
			return
		if(!get_location_accessible(H, check_zone(user.zone_selected)))
			to_chat(user, "<span class='warning'>Something in the way.</span>")
			return
		var/used_time = 70 - (H.mind.get_skill_level(/datum/skill/misc/medicine) * 10)
		if(!do_mob(user, H, used_time))
			return
		if(!H)
			return
		user.dropItemToGround(src)
		src.forceMove(H)
		affecting.add_embedded_object(src, silent = TRUE, crit_message = FALSE)
		if(M == user)
			user.visible_message("<span class='notice'>[user] places [src] on [user.p_their()] [affecting].</span>", "<span class='notice'>I place a leech on my [affecting].</span>")
		else
			user.visible_message("<span class='notice'>[user] places [src] on [M]'s [affecting].</span>", "<span class='notice'>I place a leech on [M]'s [affecting].</span>")
		return
	return ..()

/obj/item/natural/worms/leech/on_embed_life(mob/living/user, obj/item/bodypart/bodypart)
	if(!user)
		return
	user.adjustToxLoss(toxin_healing)
	if(giving)
		var/blood_given = min(BLOOD_VOLUME_MAXIMUM - user.blood_volume, blood_storage, blood_sucking)
		user.blood_volume += blood_given
		blood_storage = max(blood_storage - blood_given, 0)
		if((blood_storage <= 0) || (user.blood_volume >= BLOOD_VOLUME_MAXIMUM))
			if(bodypart)
				bodypart.remove_embedded_object(src)
			else
				user.simple_remove_embedded_object(src)
			return TRUE
	else
		var/blood_extracted = min(blood_maximum - blood_storage, user.blood_volume, blood_sucking)
		user.blood_volume = max(user.blood_volume - blood_extracted, 0)
		blood_storage += blood_extracted
		if((blood_storage >= blood_maximum) || (user.blood_volume <= 0))
			if(bodypart)
				bodypart.remove_embedded_object(src)
			else
				user.simple_remove_embedded_object(src)
			return TRUE
	return FALSE

/// LEECH LORE... Collect em all!
/obj/item/natural/worms/leech/proc/get_color()
	var/static/list/leech_lore = list(
		"#472783" = 10,
		"#276c83" = 2,
		"#368327" = 2,
		"#ff7878" = 1,
		"#ff31e4" = 1,
	)
	return pickweight(leech_lore)

/obj/item/natural/worms/leech/cheele
	name = "cheele"
	desc = "A beautiful, blood-infusing altruistic organism made by Pestra herself."
	icon_state = "cheele"
	blood_storage = BLOOD_VOLUME_SAFE
	blood_maximum = BLOOD_VOLUME_BAD

/obj/item/natural/worms/leech/cheele/examine(mob/user)
	. = ..()
	if(giving)
		. += "<span class='warning'>[p_theyre(TRUE)] slurping.</span>"
	else
		. += "<span class='notice'>[p_theyre(TRUE)] gorfing.</span>"

/obj/item/natural/worms/leech/cheele/attack_right(mob/user)
	. = ..()
	giving = !giving
	if(giving)
		user.visible_message("<span class='notice'>[user] squeezes [src].</span>"
							"<span class='notice'>I squeeze [src]. It will now infuse blood.</span>")
	else
		user.visible_message("<span class='notice'>[user] squeezes [src].</span>"
							"<span class='notice'>I squeeze [src]. It will now extract blood.</span>")

// Cheeles never have any color
/obj/item/natural/worms/leech/get_color()
	return null
