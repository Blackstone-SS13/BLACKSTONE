/obj/effect/proc_holder/spell/invoked/bonechill
	name = "Bone Chill"
	overlay_state = "astrata"
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	range = 15
	warnie = "sydwarning"
	movement_interrupt = FALSE
//	chargedloop = /datum/looping_sound/invokeholy
	chargedloop = null
	req_items = list(/obj/item/clothing/suit/roguetown/shirt/robe/necromancer)
	sound = 'sound/magic/whiteflame.ogg'
	associated_skill = /datum/skill/magic/arcane
	antimagic_allowed = TRUE
	charge_max = 5 SECONDS
	miracle = FALSE

/obj/effect/proc_holder/spell/invoked/heal/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(target == user)
			return FALSE
		if(get_dist(user, target) > 7)
			return FALSE
		if(target.mob_biotypes & MOB_UNDEAD) //positive energy harms the undead
			target.visible_message("<span class='danger'>[target] reforms under the vile energy!</span>", "<span class='notice'>I'm remade by dark magic!</span>")
			target.adjustFireLoss(-50)
			target.adjustBruteLoss(-50)
			return TRUE
		target.visible_message("<span class='info'>Necrotic energy floods over [target]!</span>", "<span class='userdanger'>I feel colder as the dark energy fades!</span>")
		if(iscarbon(target))
			var/mob/living/carbon/C = target
			target.Paralyze(50)
		else
			target.adjustBruteLoss(20)
		return TRUE
	else
		return FALSE
