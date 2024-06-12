/mob/living/simple_animal/hostile/retaliate/rogue/budlet
	icon = 'icons/roguetown/mob/monster/budlet.dmi'
	name = "budlet"
	icon_state = "budlet"
	icon_living = "budlet"
	gender = FEMALE
	emote_hear = null
	emote_see = null
	speak_chance = 2
	turns_per_move = 2
	move_to_delay = 5
	base_intents = list(/datum/intent/unarmed/shove)
	butcher_results = null
	faction = list("plants")
	health = 40
	maxHealth = 40
	melee_damage_lower = 5
	melee_damage_upper = 2
	vision_range = 4
	aggro_vision_range = 5
	retreat_distance = 0
	minimum_distance = 0
	milkies = FALSE
	food_type = list(/obj/item/reagent_containers/food/snacks/rogue/meat, /obj/item/bodypart, /obj/item/organ)
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	pooptype = null
	STACON = 5
	STASTR = 4
	STASPD = 2
	deaggroprob = 50
	defprob = 60
	defdrain = 5
	del_on_deaggro = TRUE
	del_on_death = TRUE
	retreat_health = 0.3
	food = 0
	attack_sound = "plantcross"
	dodgetime = 30
	aggressive = 1
//	stat_attack = UNCONSCIOUS
	remains_type = null

/mob/living/simple_animal/hostile/retaliate/rogue/budlet/Initialize()
	. = ..()
	gender = FEMALE
	if(prob(33))
		gender = MALE
	update_icon()

/mob/living/simple_animal/hostile/retaliate/rogue/budlet/get_sound(input)
	switch(input)
		if("aggro")
			return pick('sound/vo/mobs/plant/attack (2).ogg','sound/vo/mobs/plant/attack (3).ogg')
		if("pain")
			return pick('sound/vo/mobs/plant/pain (1).ogg','sound/vo/mobs/plant/pain (2).ogg','sound/vo/mobs/plant/pain (3).ogg','sound/vo/mobs/plant/pain (4).ogg')
		if("death")
			return pick('sound/misc/woodhit.ogg')

/mob/living/simple_animal/hostile/retaliate/rogue/budlet/taunted(mob/user)
	emote("aggro")
	Retaliate()
	GiveTarget(user)
	return

/mob/living/simple_animal/hostile/retaliate/rogue/budlet/Life()
	..()
	if(pulledby)
		Retaliate()
		GiveTarget(pulledby)


/mob/living/simple_animal/hostile/retaliate/rogue/budlet/simple_limb_hit(zone)
	if(!zone)
		return ""
	switch(zone)
		if(BODY_ZONE_PRECISE_R_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_L_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_NOSE)
			return "nose"
		if(BODY_ZONE_PRECISE_MOUTH)
			return "mouth"
		if(BODY_ZONE_PRECISE_SKULL)
			return "head"
		if(BODY_ZONE_PRECISE_EARS)
			return "head"
		if(BODY_ZONE_PRECISE_NECK)
			return "neck"
		if(BODY_ZONE_PRECISE_L_HAND)
			return "foreleg"
		if(BODY_ZONE_PRECISE_R_HAND)
			return "foreleg"
		if(BODY_ZONE_PRECISE_L_FOOT)
			return "leg"
		if(BODY_ZONE_PRECISE_R_FOOT)
			return "leg"
		if(BODY_ZONE_PRECISE_STOMACH)
			return "stomach"
		if(BODY_ZONE_PRECISE_GROIN)
			return "tail"
		if(BODY_ZONE_HEAD)
			return "head"
		if(BODY_ZONE_R_LEG)
			return "leg"
		if(BODY_ZONE_L_LEG)
			return "leg"
		if(BODY_ZONE_R_ARM)
			return "foreleg"
		if(BODY_ZONE_L_ARM)
			return "foreleg"
	return ..()

