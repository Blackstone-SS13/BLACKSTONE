

/obj/item/rogueweapon/huntingknife
	force = 12
	possible_item_intents = list(/datum/intent/dagger/cut, /datum/intent/dagger/thrust, /datum/intent/dagger/chop)
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_MOUTH
	name = "hunting knife"
	desc = "This survival knife might be able to get you through the wild."
	icon_state = "huntingknife"
	icon = 'icons/roguetown/weapons/32.dmi'
	item_state = "bone_dagger"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	gripsprite = FALSE
	//dropshrink = 0.75
	wlength = WLENGTH_SHORT
	w_class = WEIGHT_CLASS_SMALL
	parrysound = list('sound/combat/parry/bladed/bladedsmall (1).ogg','sound/combat/parry/bladed/bladedsmall (2).ogg','sound/combat/parry/bladed/bladedsmall (3).ogg')
	max_blade_int = 100
	max_integrity = 175
	swingsound = list('sound/combat/wooshes/bladed/wooshsmall (1).ogg','sound/combat/wooshes/bladed/wooshsmall (2).ogg','sound/combat/wooshes/bladed/wooshsmall (3).ogg')
	associated_skill = /datum/skill/combat/knives
	pickup_sound = 'sound/foley/equip/swordsmall2.ogg'
	throwforce = 12
	wdefense = 3
	wbalance = 1
	thrown_bclass = BCLASS_CUT
	anvilrepair = /datum/skill/craft/weaponsmithing
	smeltresult = /obj/item/ingot/steel



/datum/intent/dagger
	clickcd = 8

/datum/intent/dagger/cut
	name = "cut"
	icon_state = "incut"
	attack_verb = list("cuts", "slashes")
	animname = "cut"
	blade_class = BCLASS_CUT
	hitsound = list('sound/combat/hits/bladed/smallslash (1).ogg', 'sound/combat/hits/bladed/smallslash (2).ogg', 'sound/combat/hits/bladed/smallslash (3).ogg')
	penfactor = 0
	chargetime = 0
	swingdelay = 0
	clickcd = 10
	item_d_type = "slash"

/datum/intent/dagger/thrust
	name = "thrust"
	icon_state = "instab"
	attack_verb = list("thrusts")
	animname = "stab"
	blade_class = BCLASS_STAB
	hitsound = list('sound/combat/hits/bladed/genstab (1).ogg', 'sound/combat/hits/bladed/genstab (2).ogg', 'sound/combat/hits/bladed/genstab (3).ogg')
	penfactor = 40
	chargetime = 0
	clickcd = 8
	item_d_type = "stab"

/datum/intent/dagger/thrust/pick
	name = "icepick stab"
	icon_state = "inpick"
	attack_verb = list("stabs", "impales")
	hitsound = list('sound/combat/hits/bladed/genstab (1).ogg', 'sound/combat/hits/bladed/genstab (2).ogg', 'sound/combat/hits/bladed/genstab (3).ogg')
	penfactor = 80
	clickcd = 14
	swingdelay = 12
	damfactor = 1.1

/obj/item/rogueweapon/huntingknife/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.4,"sx" = -10,"sy" = 0,"nx" = 11,"ny" = 0,"wx" = -4,"wy" = 0,"ex" = 2,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)


/datum/intent/dagger/chop
	name = "chop"
	icon_state = "inchop"
	attack_verb = list("chops")
	animname = "chop"
	blade_class = BCLASS_CHOP
	hitsound = list('sound/combat/hits/bladed/smallslash (1).ogg', 'sound/combat/hits/bladed/smallslash (2).ogg', 'sound/combat/hits/bladed/smallslash (3).ogg')
	penfactor = 10
	damfactor = 1.5
	swingdelay = 5
	clickcd = 10
	item_d_type = "slash"

/obj/item/rogueweapon/huntingknife/cleaver
	force = 15
	name = "cleaver"
	desc = "Chop, chop, chop!"
	possible_item_intents = list(/datum/intent/dagger/cut, /datum/intent/dagger/chop/cleaver)
	icon_state = "cleav"
	icon = 'icons/roguetown/weapons/32.dmi'
	parrysound = list('sound/combat/parry/bladed/bladedmedium (1).ogg','sound/combat/parry/bladed/bladedmedium (2).ogg','sound/combat/parry/bladed/bladedmedium (3).ogg')
	swingsound = list('sound/combat/wooshes/bladed/wooshmed (1).ogg','sound/combat/wooshes/bladed/wooshmed (2).ogg','sound/combat/wooshes/bladed/wooshmed (3).ogg')
	throwforce = 15
	slot_flags = ITEM_SLOT_HIP
	thrown_bclass = BCLASS_CHOP
	w_class = WEIGHT_CLASS_NORMAL
	smeltresult = null

/obj/item/rogueweapon/huntingknife/cleaver/combat
	force = 16
	name = "knife"
	desc = "A combat knife. Swift and deadly if you hit."
	possible_item_intents = list(/datum/intent/dagger/cut, /datum/intent/dagger/chop/cleaver)
	icon_state = "combatknife"
	icon = 'icons/roguetown/weapons/32.dmi'
	parrysound = list('sound/combat/parry/bladed/bladedmedium (1).ogg','sound/combat/parry/bladed/bladedmedium (2).ogg','sound/combat/parry/bladed/bladedmedium (3).ogg')
	swingsound = list('sound/combat/wooshes/bladed/wooshmed (1).ogg','sound/combat/wooshes/bladed/wooshmed (2).ogg','sound/combat/wooshes/bladed/wooshmed (3).ogg')
	throwforce = 16
	slot_flags = ITEM_SLOT_HIP
	thrown_bclass = BCLASS_CHOP
	w_class = WEIGHT_CLASS_NORMAL
	smeltresult = null

/obj/item/rogueweapon/huntingknife/cleaver/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,
"sx" = -10,
"sy" = 0,
"nx" = 13,
"ny" = 2,
"wx" = -8,
"wy" = 2,
"ex" = 5,
"ey" = 2,
"northabove" = 0,
"southabove" = 1,
"eastabove" = 1,
"westabove" = 0,
"nturn" = 21,
"sturn" = -18,
"wturn" = -18,
"eturn" = 21,
"nflip" = 0,
"sflip" = 8,
"wflip" = 8,
"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)


/datum/intent/dagger/chop/cleaver
	hitsound = list('sound/combat/hits/bladed/genchop (1).ogg', 'sound/combat/hits/bladed/genchop (2).ogg', 'sound/combat/hits/bladed/genchop (3).ogg')
	penfactor = 30

/obj/item/rogueweapon/huntingknife/idagger
	possible_item_intents = list(/datum/intent/dagger/thrust,/datum/intent/dagger/cut, /datum/intent/dagger/thrust/pick)
	force = 15
	max_integrity = 100
	name = "iron dagger"
	desc = "This is a common dagger of iron."
	icon_state = "idagger"
	smeltresult = /obj/item/ingot/iron

/obj/item/rogueweapon/huntingknife/idagger/steel
	name = "steel dagger"
	desc = "This is a dagger made of solid steel, more durable."
	icon_state = "sdagger"
	max_integrity = 150
	smeltresult = /obj/item/ingot/steel

/obj/item/rogueweapon/huntingknife/idagger/steel/special
	icon_state = "sdaggeralt"

/obj/item/rogueweapon/huntingknife/idagger/silver
	name = "silver dagger"
	desc = "This silver dagger can be the banishment of vampires and werewolves."
	icon_state = "sildagger"
	smeltresult = null
	sellprice = 50
	smeltresult = /obj/item/ingot/silver
	var/last_used = 0

/obj/item/rogueweapon/huntingknife/idagger/silver/pickup(mob/user)
	. = ..()
	var/mob/living/carbon/human/H = user
	var/datum/antagonist/vampirelord/V_lord = H.mind.has_antag_datum(/datum/antagonist/vampirelord/)
	if(ishuman(H))
		if(H.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser))
			to_chat(H, "<span class='userdanger'>I can't pick up the silver, it is my BANE!</span>")
			H.Knockdown(20)
			H.adjustFireLoss(60)
			H.Paralyze(20)
			H.fire_act(1,5)
		if(V_lord)
			if(V_lord.vamplevel < 4 && !H.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser))
				to_chat(H, "<span class='userdanger'>I can't pick up the silver, it is my BANE!</span>")
				H.Knockdown(10)
				H.Paralyze(10)
			

/obj/item/rogueweapon/huntingknife/idagger/silver/mob_can_equip(mob/living/M, mob/living/equipper, slot, disable_warning = FALSE, bypass_equip_delay_self = FALSE)
	. = ..()
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		var/datum/antagonist/vampirelord/V_lord = H.mind.has_antag_datum(/datum/antagonist/vampirelord/)
		if(H.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser))
			H.Knockdown(20)
			H.adjustFireLoss(60)
			H.Paralyze(20)
			H.fire_act(1,5)
		if(V_lord)
			if(V_lord.vamplevel < 4 && !H.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser))
				H.Knockdown(10)
				H.Paralyze(10)


/obj/item/rogueweapon/huntingknife/idagger/silver/funny_attack_effects(mob/living/target, mob/living/user = usr, nodmg)
	if(world.time < src.last_used + 100)
		to_chat(user, "<span class='notice'>The silver effect is on cooldown.</span>")
		return
	
	
	
	. = ..()
	if(ishuman(target))
		var/mob/living/carbon/human/s_user = user
		var/mob/living/carbon/human/H = target
		var/datum/antagonist/vampirelord/lesser/V = H.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser)
		var/datum/antagonist/vampirelord/V_lord = H.mind.has_antag_datum(/datum/antagonist/vampirelord/)
		if(V)
			if(V.disguised)
				H.Stun(20)
				H.visible_message("<font color='white'>The silver weapon manifests the [H] curse!</font>")
				to_chat(H, "<span class='userdanger'>I'm hit by my BANE!</span>")
				H.adjustFireLoss(30)
				H.Paralyze(20)
				H.fire_act(1,4)
				H.apply_status_effect(/datum/status_effect/debuff/silver_curse)
				src.last_used = world.time
			else
				H.Stun(20)
				to_chat(H, "<span class='userdanger'>I'm hit by my BANE!</span>")
				H.adjustFireLoss(30)
				H.Paralyze(20)
				H.fire_act(1,4)
				H.apply_status_effect(/datum/status_effect/debuff/silver_curse)
				src.last_used = world.time
		if(V_lord)
			if(V_lord.vamplevel < 4 && !V)
				H.Stun(10)
				to_chat(H, "<span class='userdanger'>I'm hit by my BANE!</span>")
				H.adjustFireLoss(25)
				H.Paralyze(10)
				H.fire_act(1,4)
				src.last_used = world.time
			if(V_lord.vamplevel == 4 && !V)
				s_user.Stun(10)
				s_user.Paralyze(10)
				to_chat(s_user, "<font color='red'> The silver weapon fails!</font>")
				H.visible_message(H, "<span class='userdanger'>This feeble metal can't hurt me, I AM THE ANCIENT!</span>")


/obj/item/rogueweapon/huntingknife/stoneknife
	possible_item_intents = list(/datum/intent/dagger/cut,/datum/intent/dagger/chop)
	name = "stone knife"
	desc = "A crudely crafted knife made of stone."
	icon_state = "stone_knife"
	smeltresult = null
	max_integrity = 50
	max_blade_int = 50
	wdefense = 1

/obj/item/rogueweapon/huntingknife/elvish
	possible_item_intents = list(/datum/intent/dagger/thrust,/datum/intent/dagger/cut)
	name = "elvish dagger"
	desc = "This beautiful dagger is of intricate, elvish design. Sharper, too."
	force = 19
	icon_state = "elfdagger"
	item_state = "elfdag"

/obj/item/rogueweapon/huntingknife/elvish/drow
	name = "nite elf dagger"
	desc = "This ominous, dark handled dagger was crafted by the assassin race of nite elves."
	force = 25
