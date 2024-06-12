
/obj/effect/proc_holder/spell/invoked/growvines
	name = "Grow vines"
	overlay_state = "tangling"
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	range = 15
	warnie = "spellwarning"
	movement_interrupt = FALSE
	chargedloop = null
	req_items = list(/obj/item/clothing/neck/roguetown/dherbs)
	sound = 'sound/magic/grow_vine.ogg'
	associated_skill = /datum/skill/magic/druidic
	antimagic_allowed = TRUE
	charge_max = 60 SECONDS

/obj/effect/proc_holder/spell/invoked/growvines/cast(list/targets, mob/living/user)
	. = ..()
	user.blood_volume -= BLOOD_VOLUME_SURVIVE/3
	var/turf/T = get_turf(targets[1])
	user.visible_message("<font color='green'>[user] points at [T]!</font>","<span class='notice'>You feel light-headed!</span>")
	if(!isclosedturf(T) && !locate(/turf/open/transparent/openspace) in T)
		new /obj/structure/flora/roguegrass/tangler/real(T)

/obj/effect/proc_holder/spell/invoked/budlet
	name = "Summon Buds"
	range = 5
	overlay_state = "dendor"
	releasedrain = 30
	charge_max = 120 SECONDS
	req_items = list(/obj/item/clothing/neck/roguetown/dherbs)
	cast_without_targets = TRUE
	sound = 'sound/magic/grow_vine.ogg'
	associated_skill = /datum/skill/magic/druidic
	antimagic_allowed = TRUE
	invocation = "By the power of Dendor, come forth!"
	invocation_type = "shout" //can be none, whisper, emote and shout

/obj/effect/proc_holder/spell/invoked/budlet/cast(list/targets, mob/living/user)
	. = ..()
	var/turf/T = user.loc
	for(var/X in GLOB.cardinals)
		user.faction |= "plants"
		user.blood_volume -= BLOOD_VOLUME_SURVIVE/2
		var/turf/TT = get_step(T, X)
		if(!isclosedturf(TT) && !locate(/mob/living/simple_animal/hostile/retaliate/rogue/budlet) in TT)
			new /mob/living/simple_animal/hostile/retaliate/rogue/budlet(TT)
	return TRUE

/obj/effect/proc_holder/spell/invoked/bloodberry
	name = "Blood berry"
	range = 2
	overlay_state = "bberry"
	releasedrain = 15
	charge_max = 30 SECONDS
	req_items = list(/obj/item/clothing/neck/roguetown/dherbs)
	cast_without_targets = TRUE
	sound = 'sound/magic/webspin.ogg'
	associated_skill = /datum/skill/magic/druidic
	antimagic_allowed = TRUE
	invocation = "I clench my fist"
	invocation_type = "emote" //can be none, whisper, emote and shout

/obj/effect/proc_holder/spell/invoked/bloodberry/cast(list/targets, mob/living/user)
	. = ..()
	var/obj/item/reagent_containers/food/snacks/grown/berries/rogue/blood/I = new
		user.put_in_hands(I)
