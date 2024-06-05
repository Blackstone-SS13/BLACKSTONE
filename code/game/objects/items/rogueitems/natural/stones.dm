GLOBAL_LIST_INIT(stone_sharpness_names, list(
	"Sharp",
	"Vicious",
	"Cutthroat",
	"Keen",
	"Acute",
	"Edged",
	"Fierce",
	"Stinging",
))

GLOBAL_LIST_INIT(stone_sharpness_descs, list(
	"It has a vicious edge.",
	"This stone is akin to a knife.",
	"It has a pointed side.",
	"It has a serrated edge.",
))

GLOBAL_LIST_INIT(stone_bluntness_names, list(
	"Blunt",
	"Rotund",
	"Heavy",
	"Solid",
	"Chubby",
	"Portly",
	"Meaty",
	"Dumpy",
	"Stout",
	"Plump",
))

GLOBAL_LIST_INIT(stone_bluntness_descs, list(
	"It is very blunt.",
	"It is kinda hefty.",
	"It fills the hand.",
	"It is quite a handfull",
	"This stone feels like it was made for ME!",
))

GLOBAL_LIST_INIT(stone_magic_names, list(
	"Shimmering",
	"Glowing",
	"Enchanted",
	"Ancient",
	"Mystic",
	"Enhanced",
	"Magic",
	"Mysterious",
	"Radiant",
	"Singing",
	"Beautiful",
	"Tantalizing",
	"Allurring",
	"Wicked",
	"Mythical",
	"Baleful",
	"Heavenly",
	"Angelic",
	"Demonic",
	"Devilish",
	"Mischievous",
))

GLOBAL_LIST_INIT(stone_magic_descs, list(
	"It hums with internal energy.",
	"It has a faint aura.",
	"It has an odd sigil on it.",
	"It has a small red stone pressed into it.",
	"It is covered in tiny cracks.",
	"It looks unsafe.",
))

GLOBAL_LIST_INIT(stone_personalities, list(
	"Hatred",
	"Idiocy",
	"Mourning",
	"Glory",
	"Rock-Solidness",
	"Calmness",
	"Anger",
	"Rage",
	"Vainglory",
	"Risk-aversedness",
	"Daredevil",
	"Barbarics",
	"Fanciness",
	"Relaxing",	
	"Blacked",
	"Greed",
	"Evil",
	"Good",
	"Neutrality",
	"Pride",
	"Lust",
	"Sloth",
	"Victory",
	"Defeat",
	"Recoil",
	"Impact",
	"Goring",
	"Destruction",
	"Hell",
	"Zizo",
	"Flames",
	"Darkness",
	"Light",
	"Heroism",
	"Heaven",
	"Cowards",
	"Conquerors",
	"Conquest",
	"Horripilation",
	"Terror",
	"Earthquakes",
	"Thunder",
))

GLOBAL_LIST_INIT(stone_personality_descs, list(
	"This stone is full of personality!",
	"They say the intelligent races built their foundations with stones.",
	"One must think, where did this stone come from?",
	"If all stones were like this, then they would be some pretty great stones.",
	"I wish my personality was like this stone's...",
	"I could sure do a whole lot with this stone.", 
	"I love stones!",
))

/obj/item/natural/stone
	name = "stone"
	icon_state = "stone1"
	desc = "A piece of rough ground stone."
	gripped_intents = null
	dropshrink = 0.75
	possible_item_intents = list(INTENT_GENERIC)
	force = 10
	throwforce = 15
	slot_flags = ITEM_SLOT_MOUTH
	obj_flags = null
	w_class = WEIGHT_CLASS_TINY

/obj/item/natural/stone/Initialize()
	. = ..()
	stone_lore()

/*
	This right here is stone lore,
	Yakub from BBC lore has inspired me
*/
/obj/item/natural/stone/proc/stone_lore()
	var/stone_title = "stone" // Our stones title
	var/stone_desc = "[desc]" // Total Bonus desc the stone will be getting

	icon_state = "stone[rand(1,5)]" 

	var/bonus_force = 0 // Total bonus force the rock will be getting
	var/list/given_intent_list = list(/datum/intent/hit) // By default you get this at least
	var/list/extra_intent_list = list() // List of intents that we can possibly give it by the end of this
	var/list/blunt_intents = list(/datum/intent/mace/strike/wood, /datum/intent/mace/smash/wood)
	var/list/sharp_intents = list(/datum/intent/dagger/cut, /datum/intent/dagger/thrust, /datum/intent/dagger/chop)

	var/bluntness_rating = rand(0,10)
	var/sharpness_rating = rand(0,10)

	var/stone_personality_rating = rand(0,25)

	//This is so sharpness and bluntness's name and descs come in randomly before or after each other
	//Magic will always be in front for now, and personality will be after magic.
	var/list/name_jumbler = list()
	var/list/desc_jumbler = list()

	switch(bluntness_rating)
		if(2 to 8)
			extra_intent_list += pick(blunt_intents) // Add one
		if(9 to 10)
			for(var/muhdik in blunt_intents) // add all intent to possible things
				extra_intent_list += muhdik

			name_jumbler += pick(GLOB.stone_bluntness_names)
			desc_jumbler += pick(GLOB.stone_bluntness_descs)

	switch(sharpness_rating)
		if(2 to 8)
			extra_intent_list += pick(sharp_intents) // Add one
		if(9 to 10)
			for(var/mofugga in sharp_intents) // add all intent to possible things
				extra_intent_list += mofugga

			name_jumbler += pick(GLOB.stone_sharpness_names)
			desc_jumbler += pick(GLOB.stone_sharpness_descs)

	if(name_jumbler.len) // Both name jumbler and desc jumbler should be symmetrical in insertions conceptually anyways.
		for(var/i in 1 to name_jumbler.len) //Theres only two right now 
			if(!name_jumbler.len) // If list somehow empty get the hell out! Now~!
				break
			//Remove so theres no repeats
			var/picked_name = pick(name_jumbler)
			name_jumbler -= picked_name
			var/picked_desc = pick(desc_jumbler)
			desc_jumbler -= picked_desc

			stone_title = "[picked_name] [stone_title]" // Prefix and then stone
			stone_desc += " [picked_desc]" // We put the descs after the original one

	switch(stone_personality_rating)
		if(10 to 22)
			if(prob(3)) // Stone has a 3 percent chance to have a personality despite missing its roll
				stone_title = "[stone_title] of [pick(GLOB.stone_personalities)]"
				stone_desc += " [pick(GLOB.stone_personality_descs)]"
				bonus_force += rand(1,5) // Personality gives a stone some more power too
		if(23 to 25)
			stone_title = "[stone_title] of [pick(GLOB.stone_personalities)]"
			stone_desc += " [pick(GLOB.stone_personality_descs)]"
			bonus_force += rand(1,5) // Personality gives a stone some more power too

	var/max_force_range = sharpness_rating + bluntness_rating // Add them together
	//max_force_range = round(max_force_range/2) // Divide by 2 and round jus incase

	bonus_force = rand(0, max_force_range) // Your total bonus force is now between 1 and your sharpness/bluntness totals

	if(prob(5)) // We hit the jackpot, a magical stone! JUST FOR ME!
		filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))
		var/magic_force = rand(1,10) //Roll, we need this seperate for now otherwise people will know the blunt/sharp boosts too
		stone_title = "[pick(GLOB.stone_magic_names)] [stone_title] +[magic_force]"
		stone_desc += " [pick(GLOB.stone_magic_descs)]"
		bonus_force += magic_force // Add on the magic force modifier

	if(extra_intent_list.len)
		for(var/i in 1 to min(4, extra_intent_list.len))
			// No more than 4 bro, and if we are empty on intents just stop here
			if(!length(extra_intent_list))
				break
			var/cock = pick(extra_intent_list) // We pick one
			given_intent_list += cock // Add it to the list
			extra_intent_list -= cock // Remove it from the prev list
	
	//Now that we have built the history and lore of this stone, we apply it to the main vars.
	name = stone_title
	desc = stone_desc
	force += bonus_force // This will result in a stone that has only 40 max at a extremely low chance damage at this time of this PR.
	throwforce += bonus_force // It gets added to throw damage too
	possible_item_intents = given_intent_list // And heres ur new extra intents too

/obj/item/natural/stone/attackby(obj/item/W, mob/user, params)
	user.changeNext_move(CLICK_CD_MELEE)
	if(istype(W, /obj/item/natural/stone))
		playsound(src.loc, pick('sound/items/stonestone.ogg'), 100)
		user.visible_message("<span class='info'>[user] strikes the stones together.</span>")
		if(prob(10))
			var/datum/effect_system/spark_spread/S = new()
			var/turf/front = get_step(user,user.dir)
			S.set_up(1, 1, front)
			S.start()
	else
		..()

/obj/item/natural/rock
	name = "rock"
	desc = "A rock protudes from the ground."
	icon_state = "stonebig1"
	dropshrink = 0
	throwforce = 25
	throw_range = 2
	force = 18
	obj_flags = CAN_BE_HIT
	force_wielded = 15
	gripped_intents = list(INTENT_GENERIC)
	w_class = WEIGHT_CLASS_HUGE
	twohands_required = TRUE
	var/obj/item/stack/ore/mineralType = null
	var/mineralAmt = 1
	blade_dulling = DULLING_BASH
	max_integrity = 90
	destroy_sound = 'sound/foley/smash_rock.ogg'
	attacked_sound = 'sound/foley/hit_rock.ogg'


/obj/item/natural/rock/Initialize()
	icon_state = "stonebig[rand(1,2)]"
	..()


/obj/item/natural/rock/Crossed(mob/living/L)
	if(istype(L) && !L.throwing)
		if(L.m_intent == MOVE_INTENT_RUN)
			L.visible_message("<span class='warning'>[L] trips over the rock!</span>","<span class='warning'>I trip over the rock!</span>")
			L.Knockdown(10)
			L.consider_ambush()
	..()

/obj/item/natural/rock/deconstruct(disassembled = FALSE)
	if(!disassembled)
		if(mineralType && mineralAmt)
			new mineralType(src.loc, mineralAmt)
		for(var/i in 1 to rand(1,4))
			var/obj/item/S = new /obj/item/natural/stone(src.loc)
			S.pixel_x = rand(25,-25)
			S.pixel_y = rand(25,-25)
	qdel(src)

/obj/item/natural/rock/take_damage(damage_amount, damage_type = BRUTE, damage_flag = 0, sound_effect = 1, attack_dir)
	. = ..()
	if(.) //damage received
		if(damage_amount > 10)
			if(prob(10))
				var/datum/effect_system/spark_spread/S = new()
				var/turf/front = get_turf(src)
				S.set_up(1, 1, front)
				S.start()

/obj/item/natural/rock/attackby(obj/item/W, mob/user, params)
	user.changeNext_move(CLICK_CD_MELEE)
	if(istype(W, /obj/item/natural/stone))
		user.visible_message("<span class='info'>[user] strikes the stone against the rock.</span>")
		playsound(src.loc, 'sound/items/stonestone.ogg', 100)
		if(prob(35))
			var/datum/effect_system/spark_spread/S = new()
			var/turf/front = get_turf(src)
			S.set_up(1, 1, front)
			S.start()
		return
	if(istype(W, /obj/item/natural/rock))
		playsound(src.loc, pick('sound/items/stonestone.ogg'), 100)
		user.visible_message("<span class='info'>[user] strikes the rocks together.</span>")
		if(prob(10))
			var/datum/effect_system/spark_spread/S = new()
			var/turf/front = get_turf(src)
			S.set_up(1, 1, front)
			S.start()
		return
	..()

//begin ore loot rocks
/obj/item/natural/rock/gold
	mineralType = /obj/item/rogueore/gold

/obj/item/natural/rock/iron
	mineralType = /obj/item/rogueore/iron

/obj/item/natural/rock/coal
	mineralType = /obj/item/rogueore/coal

/obj/item/natural/rock/salt
	mineralType = /obj/item/reagent_containers/powder/flour/salt

/obj/item/natural/rock/gem
	mineralType = /obj/item/roguegem/random
