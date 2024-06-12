#define SHIELD_BASH		/datum/intent/shield/bash
#define SHIELD_BLOCK		/datum/intent/shield/block
#define SHIELD_BANG_COOLDOWN (3 SECONDS)

/obj/item/rogueweapon/shield
	name = ""
	desc = ""
	icon_state = ""
	icon = 'icons/roguetown/weapons/32.dmi'
	slot_flags = ITEM_SLOT_BACK
	flags_1 = null
	force = 10
	throwforce = 5
	throw_speed = 1
	throw_range = 3
	w_class = WEIGHT_CLASS_BULKY
	possible_item_intents = list(SHIELD_BASH, SHIELD_BLOCK)
	block_chance = 0
	sharpness = IS_BLUNT
	wlength = WLENGTH_SHORT
	resistance_flags = FLAMMABLE
	can_parry = TRUE
	wdefense = 15
	var/coverage = 90
	parrysound = "parrywood"
	attacked_sound = "parrywood"
	max_integrity = 150
	blade_dulling = DULLING_BASHCHOP
	anvilrepair = /datum/skill/craft/armorsmithing
	COOLDOWN_DECLARE(shield_bang)


/obj/item/rogueweapon/shield/attackby(obj/item/attackby_item, mob/user, params)

	// Shield banging
	if(src == user.get_inactive_held_item())
		if(istype(attackby_item, /obj/item/rogueweapon))
			if(!COOLDOWN_FINISHED(src, shield_bang))
				return
			user.visible_message(span_danger("[user] bangs [src] with [attackby_item]!"))
			playsound(user.loc, 'sound/combat/shieldbang.ogg', 50, TRUE)
			COOLDOWN_START(src, shield_bang, SHIELD_BANG_COOLDOWN)
			return

	return ..()

/obj/item/rogueweapon/shield/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the projectile", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	SEND_SIGNAL(src, COMSIG_ITEM_HIT_REACT, args)
	if(attack_type == THROWN_PROJECTILE_ATTACK || attack_type == PROJECTILE_ATTACK)
		if(owner.client?.chargedprog == 100 && owner.used_intent?.tranged)
			owner.visible_message(span_danger("[owner] blocks [hitby] with [src]!"))
			return 1
		else
			if(prob(coverage))
				owner.visible_message(span_danger("[owner] blocks [hitby] with [src]!"))
				return 1
	return 0

/datum/intent/shield/bash
	name = "bash"
	icon_state = "inbash"
	chargetime = 0

/datum/intent/shield/block
	name = "block"
	icon_state = "inblock"
	tranged = 1 //we can't attack directly with this intent, but we can charge it
	tshield = 1
	chargetime = 1
	warnie = "shieldwarn"

/obj/item/rogueweapon/shield/wood
	name = "wooden shield"
	desc = "A sturdy wooden shield. Will block anything you can imagine."
	icon_state = "woodsh"
	dropshrink = 0.8
	wdefense = 15
	coverage = 40

/obj/item/rogueweapon/shield/wood/attack_hand(mob/user)
	if(!overlays.len)
		var/icon/J = new('icons/roguetown/weapons/wood_heraldry.dmi')
		var/list/istates = J.IconStates()
		var/picked_name = input(user, "Choose a Heraldry", "ROGUETOWN", name) as null|anything in sortList(istates)
		if(!picked_name)
			picked_name = "none"
		var/mutable_appearance/M = mutable_appearance('icons/roguetown/weapons/wood_heraldry.dmi', picked_name)
		M.alpha = 178
		add_overlay(M)
		var/mutable_appearance/MU = mutable_appearance(icon, "woodsh_detail")
		MU.alpha = 114
		add_overlay(MU)
	else
		..()

/obj/item/rogueweapon/shield/wood/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -5,"sy" = -1,"nx" = 6,"ny" = -1,"wx" = 0,"wy" = -2,"ex" = 0,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0)
			if("onback")
				return list("shrink" = 0.6,"sx" = 1,"sy" = 4,"nx" = 1,"ny" = 2,"wx" = 3,"wy" = 3,"ex" = 0,"ey" = 2,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 8,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)

/obj/item/rogueweapon/shield/tower
	name = "tower shield"
	desc = "A huge iron shield!"
	icon_state = "shield_tower"
	force = 15
	throwforce = 10
	throw_speed = 1
	throw_range = 3
	wlength = WLENGTH_NORMAL
	resistance_flags = FLAMMABLE
	wdefense = 15
	coverage = 70
	parrysound = list('sound/combat/parry/shield/towershield (1).ogg','sound/combat/parry/shield/towershield (2).ogg','sound/combat/parry/shield/towershield (3).ogg')
	max_integrity = 200

/obj/item/rogueweapon/shield/tower/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -5,"sy" = -1,"nx" = 6,"ny" = -1,"wx" = 0,"wy" = -2,"ex" = 0,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0)
			if("onback")
				return list("shrink" = 0.6,"sx" = 1,"sy" = 4,"nx" = 1,"ny" = 2,"wx" = 3,"wy" = 3,"ex" = 0,"ey" = 2,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 8,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)

/obj/item/rogueweapon/shield/tower/metal
	name = "kite shield"
	desc = "A kite-shaped iron shield. Reliable and sturdy."
	icon_state = "ironsh"
	force = 20
	throwforce = 10
	throw_speed = 1
	throw_range = 3
	wlength = WLENGTH_NORMAL
	resistance_flags = null
	flags_1 = CONDUCT_1
	wdefense = 18
	coverage = 70
	attacked_sound = list('sound/combat/parry/shield/metalshield (1).ogg','sound/combat/parry/shield/metalshield (2).ogg','sound/combat/parry/shield/metalshield (3).ogg')
	parrysound = list('sound/combat/parry/shield/metalshield (1).ogg','sound/combat/parry/shield/metalshield (2).ogg','sound/combat/parry/shield/metalshield (3).ogg')
	max_integrity = 300
	blade_dulling = DULLING_BASH
	sellprice = 30

/obj/item/rogueweapon/shield/tower/metal/getonmobprop(tag)
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -5,"sy" = -1,"nx" = 6,"ny" = -1,"wx" = 0,"wy" = -2,"ex" = 0,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0)
			if("onback")
				return list("shrink" = 0.6,"sx" = 1,"sy" = 4,"nx" = 1,"ny" = 2,"wx" = 3,"wy" = 3,"ex" = 0,"ey" = 2,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 8,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)
	return ..()

/obj/item/rogueweapon/shield/tower/metal/attack_hand(mob/user)
	if(!overlays.len)
		var/icon/J = new('icons/roguetown/weapons/shield_heraldry.dmi')
		var/list/istates = J.IconStates()
		var/picked_name = input(user, "Choose a Heraldry", "ROGUETOWN", name) as null|anything in sortList(istates)
		if(!picked_name)
			picked_name = "none"
		var/mutable_appearance/M = mutable_appearance('icons/roguetown/weapons/shield_heraldry.dmi', picked_name)
		M.alpha = 190
		add_overlay(M)
		var/mutable_appearance/MU = mutable_appearance(icon, "ironsh_detail")
		MU.alpha = 90
		add_overlay(MU)
	else
		..()

obj/item/rogueweapon/shield/buckler
	name = "buckler shield"
	desc = "A sturdy buckler shield. Will block anything you can imagine."
	icon_state = "bucklersh"
	slot_flags = ITEM_SLOT_HIP | ITEM_SLOT_BACK
	force = 20
	throwforce = 10
	dropshrink = 0.8
	resistance_flags = null
	wdefense = 9
	coverage = 10
	attacked_sound = list('sound/combat/parry/shield/metalshield (1).ogg','sound/combat/parry/shield/metalshield (2).ogg','sound/combat/parry/shield/metalshield (3).ogg')
	parrysound = list('sound/combat/parry/shield/metalshield (1).ogg','sound/combat/parry/shield/metalshield (2).ogg','sound/combat/parry/shield/metalshield (3).ogg')
	max_integrity = 300
	blade_dulling = DULLING_BASH
	associated_skill = 0

obj/item/rogueweapon/shield/buckler/proc/bucklerskill(mob/living/user)
	if(!ishuman(user))
		return
	var/mob/living/carbon/bucklerer = user
	var/obj/item/mainhand = bucklerer.get_active_held_item()
	var/weapon_parry = FALSE
	if(mainhand)
		if(mainhand.can_parry)
			weapon_parry = TRUE
	if(istype(mainhand, /obj/item/rogueweapon/shield/buckler))
		associated_skill = 0
	if(weapon_parry && mainhand.associated_skill)
		associated_skill = mainhand.associated_skill
	else
		associated_skill = 0

/obj/item/rogueweapon/shield/buckler/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -5,"sy" = -1,"nx" = 6,"ny" = -1,"wx" = 0,"wy" = -2,"ex" = 0,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 1,"eflip" = 0)
			if("onback")
				return list("shrink" = 0.6,"sx" = 1,"sy" = 4,"nx" = 1,"ny" = 2,"wx" = 3,"wy" = 3,"ex" = 0,"ey" = 2,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 8,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)

#undef SHIELD_BANG_COOLDOWN
