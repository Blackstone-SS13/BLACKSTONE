/mob/living/carbon/monkey/help_shake_act(mob/living/carbon/M)
	if(health < 0 && ishuman(M))
		var/mob/living/carbon/human/H = M
		H.do_cpr(src)
	else
		..()

/mob/living/carbon/monkey/attack_paw(mob/living/M)
	if(..()) //successful monkey bite.
		var/dam_zone = pick(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_L_HAND, BODY_ZONE_PRECISE_R_HAND, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
		var/obj/item/bodypart/affecting = get_bodypart(ran_zone(dam_zone))
		if(!affecting)
			affecting = get_bodypart(BODY_ZONE_CHEST)
		if(M.limb_destroyer)
			dismembering_strike(M, affecting.body_zone)
		if(stat != DEAD)
			var/dmg = rand(1, 5)
			apply_damage(dmg, BRUTE, affecting)

/mob/living/carbon/monkey/attack_larva(mob/living/carbon/alien/larva/L)
	if(..()) //successful larva bite.
		var/damage = rand(1, 3)
		if(stat != DEAD)
			L.amount_grown = min(L.amount_grown + damage, L.max_grown)
			var/obj/item/bodypart/affecting = get_bodypart(ran_zone(L.zone_selected))
			if(!affecting)
				affecting = get_bodypart(BODY_ZONE_CHEST)
			apply_damage(damage, BRUTE, affecting)

/mob/living/carbon/monkey/attack_hand(mob/living/carbon/human/M)
	if(..())	//To allow surgery to return properly.
		return

	switch(M.used_intent.type)
		if(INTENT_HELP)
			help_shake_act(M)
		if(INTENT_GRAB)
			grabbedby(M)
		if(INTENT_HARM)
			M.do_attack_animation(src, ATTACK_EFFECT_PUNCH)
			if (prob(75))
				visible_message(span_danger("[M] punches [name]!"), \
								span_danger("[M] punches you!"), span_hear("I hear a sickening sound of flesh hitting flesh!"), COMBAT_MESSAGE_RANGE, M)
				to_chat(M, span_danger("I punch [name]!"))

				playsound(loc, "punch", 25, TRUE, -1)
				var/damage = rand(5, 10)
				if(prob(40))
					damage = rand(10, 15)
					if(AmountUnconscious() < 100 && health > 0)
						Unconscious(rand(200, 300))
						visible_message(span_danger("[M] knocks [name] out!"), \
										span_danger("[M] knocks you out!"), span_hear("I hear a sickening sound of flesh hitting flesh!"), 5, M)
						to_chat(M, span_danger("I knock [name] out!"))
				var/obj/item/bodypart/affecting = get_bodypart(ran_zone(M.zone_selected))
				if(!affecting)
					affecting = get_bodypart(BODY_ZONE_CHEST)
				apply_damage(damage, BRUTE, affecting)
				log_combat(M, src, "attacked")

			else
				playsound(loc, 'sound/blank.ogg', 25, TRUE, -1)
				visible_message(span_danger("[M]'s punch misses [name]!"), \
								span_danger("I avoid [M]'s punch!"), span_hear("I hear a swoosh!"), COMBAT_MESSAGE_RANGE, M)
				to_chat(M, span_warning("My punch misses [name]!"))
		if(INTENT_DISARM)
			if(!IsUnconscious())
				M.do_attack_animation(src, ATTACK_EFFECT_DISARM)
				if (prob(25))
					Paralyze(40)
					playsound(loc, 'sound/blank.ogg', 50, TRUE, -1)
					log_combat(M, src, "pushed")
					visible_message(span_danger("[M] pushes [src] down!"), \
									span_danger("[M] pushes you down!"), span_hear("I hear aggressive shuffling followed by a loud thud!"), null, M)
					to_chat(M, span_danger("I push [src] down!"))
				else if(dropItemToGround(get_active_held_item()))
					playsound(src, 'sound/blank.ogg', 50, TRUE, -1)
					visible_message(span_danger("[M] disarms [src]!"), \
									span_danger("[M] disarms you!"), span_hear("I hear aggressive shuffling!"), COMBAT_MESSAGE_RANGE, M)
					to_chat(M, span_danger("I disarm [src]!"))

/mob/living/carbon/monkey/attack_alien(mob/living/carbon/alien/humanoid/M)
	if(..()) //if harm or disarm intent.
		if (M.used_intent.type == INTENT_HARM)
			if ((prob(95) && health > 0))
				playsound(loc, 'sound/blank.ogg', 25, TRUE, -1)
				var/damage = rand(15, 30)
				if (damage >= 25)
					damage = rand(20, 40)
					if(AmountUnconscious() < 300)
						Unconscious(rand(200, 300))
					visible_message(span_danger("[M] wounds [name]!"), \
									span_danger("[M] wounds you!"), span_hear("I hear a sickening sound of flesh hitting flesh!"), COMBAT_MESSAGE_RANGE, M)
					to_chat(M, span_danger("I wound [name]!"))
				else
					visible_message(span_danger("[M] slashes [name]!"), \
									span_danger("[M] slashes you!"), span_hear("I hear a sickening sound of a slice!"), COMBAT_MESSAGE_RANGE, M)
					to_chat(M, span_danger("I slash [name]!"))

				var/obj/item/bodypart/affecting = get_bodypart(ran_zone(M.zone_selected))
				log_combat(M, src, "attacked")
				if(!affecting)
					affecting = get_bodypart(BODY_ZONE_CHEST)
				if(!dismembering_strike(M, affecting.body_zone)) //Dismemberment successful
					return 1
				apply_damage(damage, BRUTE, affecting)

			else
				playsound(loc, 'sound/blank.ogg', 25, TRUE, -1)
				visible_message(span_danger("[M]'s lunge misses [name]!"), \
								span_danger("I avoid [M]'s lunge!"), span_hear("I hear a swoosh!"), COMBAT_MESSAGE_RANGE, M)
				to_chat(M, span_warning("My lunge misses [name]!"))

		if (M.used_intent.type == INTENT_DISARM)
			var/obj/item/I = null
			playsound(loc, 'sound/blank.ogg', 25, TRUE, -1)
			if(prob(95))
				Paralyze(20)
				visible_message(span_danger("[M] tackles [name] down!"), \
								span_danger("[M] tackles you down!"), span_hear("I hear aggressive shuffling followed by a loud thud!"), COMBAT_MESSAGE_RANGE, M)
				to_chat(M, span_danger("I tackle [name] down!"))
			else
				I = get_active_held_item()
				if(dropItemToGround(I))
					visible_message(span_danger("[M] disarms [name]!"), \
									span_danger("[M] disarms you!"), span_hear("I hear aggressive shuffling!"), COMBAT_MESSAGE_RANGE, M)
					to_chat(M, span_danger("I disarm [name]!"))
				else
					I = null
			log_combat(M, src, "disarmed", "[I ? " removing \the [I]" : ""]")
			updatehealth()


/mob/living/carbon/monkey/attack_animal(mob/living/simple_animal/M)
	. = ..()
	if(.)
		var/damage = rand(M.melee_damage_lower, M.melee_damage_upper)
		var/dam_zone = dismembering_strike(M, pick(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_L_HAND, BODY_ZONE_PRECISE_R_HAND, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG))
		if(!dam_zone) //Dismemberment successful
			return TRUE
		var/obj/item/bodypart/affecting = get_bodypart(ran_zone(dam_zone))
		if(!affecting)
			affecting = get_bodypart(BODY_ZONE_CHEST)
		apply_damage(damage, M.melee_damage_type, affecting)

/mob/living/carbon/monkey/attack_slime(mob/living/simple_animal/slime/M)
	if(..()) //successful slime attack
		var/damage = rand(5, 35)
		if(M.is_adult)
			damage = rand(20, 40)
		var/dam_zone = dismembering_strike(M, pick(BODY_ZONE_HEAD, BODY_ZONE_CHEST, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG))
		if(!dam_zone) //Dismemberment successful
			return 1
		var/obj/item/bodypart/affecting = get_bodypart(ran_zone(dam_zone))
		if(!affecting)
			affecting = get_bodypart(BODY_ZONE_CHEST)
		apply_damage(damage, BRUTE, affecting)

/mob/living/carbon/monkey/acid_act(acidpwr, acid_volume, bodyzone_hit)
	. = 1
	if(!bodyzone_hit || bodyzone_hit == BODY_ZONE_HEAD)
		if(wear_mask)
			if(!(wear_mask.resistance_flags & UNACIDABLE))
				wear_mask.acid_act(acidpwr, acid_volume)
			else
				to_chat(src, span_warning("My mask protects you from the acid."))
			return
		if(head)
			if(!(head.resistance_flags & UNACIDABLE))
				head.acid_act(acidpwr, acid_volume)
			else
				to_chat(src, span_warning("My hat protects you from the acid."))
			return
	take_bodypart_damage(acidpwr * min(0.6, acid_volume*0.1))


/mob/living/carbon/monkey/ex_act(severity, target, origin)
	if(origin && istype(origin, /datum/spacevine_mutation) && isvineimmune(src))
		return
	..()

	switch (severity)
		if (EXPLODE_DEVASTATE)
			gib()
			return

		if (EXPLODE_HEAVY)
			take_overall_damage(60, 60)
			damage_clothes(200, BRUTE, "bomb")
			adjustEarDamage(30, 120)
			if(prob(70))
				Unconscious(200)

		if(EXPLODE_LIGHT)
			take_overall_damage(30, 0)
			damage_clothes(50, BRUTE, "bomb")
			adjustEarDamage(15,60)
			if (prob(50))
				Unconscious(160)


	//attempt to dismember bodyparts
	if(severity <= 2)
		var/max_limb_loss = round(4/severity) //so you don't lose four limbs at severity 3.
		for(var/X in bodyparts)
			var/obj/item/bodypart/BP = X
			if(prob(50/severity) && BP.body_zone != BODY_ZONE_CHEST)
				BP.brute_dam = BP.max_damage
				BP.dismember()
				max_limb_loss--
				if(!max_limb_loss)
					break
