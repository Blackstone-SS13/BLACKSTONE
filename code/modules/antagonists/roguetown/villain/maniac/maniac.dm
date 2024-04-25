
/datum/antagonist/maniac
	name = "Maniac"
	roundend_category = "maniacs"
	antagpanel_category = "Maniac"
	antag_memory = "<b>Recently I've been visited by a lot of VISIONS. They're all about another WORLD, ANOTHER life. I will do EVERYTHING to know the TRUTH, and return to the REAL world.</b>"
	job_rank = ROLE_MANIAC
	antag_hud_type = ANTAG_HUD_TRAITOR
	antag_hud_name = "villain"
	confess_lines = list("I gave the lady no time to squeal.", "I am down on whores.", "I shant quit ripping them.")
	/// Traits we apply to the owner
	var/static/list/applied_traits = list(
		RTRAIT_CRITICAL_RESISTANCE,
		RTRAIT_DECEIVING_MEEKNESS,
		RTRAIT_NOSTINK,
		RTRAIT_EMPATH,
		TRAIT_STEELHEARTED,
		TRAIT_NOMOOD,
		TRAIT_NOFATSTAM,
		TRAIT_HARDDISMEMBER,
		TRAIT_NOSLEEP,
		TRAIT_SHOCKIMMUNE,
		TRAIT_STABLEHEART,
		TRAIT_STABLELIVER,
		TRAIT_ANTIMAGIC,
		TRAIT_SCHIZO_AMBIENCE,
	)
	/// Cached old stats in case we get removed
	var/STASTR
	var/STACON 
	var/STAEND
	/// Weapons we can give to the dreamer
	var/static/list/possible_weapons = list(
		/obj/item/rogueweapon/huntingknife/cleaver,
		/obj/item/rogueweapon/huntingknife/cleaver/combat,
		/obj/item/rogueweapon/huntingknife/idagger/steel/special,
	)
	/// Wonder recipes
	var/static/list/recipe_progression = list(
		/datum/crafting_recipe/roguetown/structure/wonder/first, 
		/datum/crafting_recipe/roguetown/structure/wonder/second, 
		/datum/crafting_recipe/roguetown/structure/wonder/third, 
		/datum/crafting_recipe/roguetown/structure/wonder/fourth,
	)
	/// Key number > Key text 
	var/list/num_keys = list()
	/// Key text > key number
	var/list/key_nums = list()
	/// Every heart inscryption we have seen
	var/list/hearts_seen = list()
	/// Sum of the numbers of every key
	var/sum_keys = 0
	/// Keeps track of which wonder we are gonna make next
	var/current_wonder = 1
	/// Set to TRUE when we are on the last wonder (waking up)
	var/waking_up = FALSE
	/// Wonders we have made
	var/list/wonders_made = list()
	/// Hallucinations screen object
	var/obj/screen/fullscreen/maniac/hallucinations

/datum/antagonist/maniac/New()
	set_keys()
	return ..()

/datum/antagonist/maniac/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/datum/antagonist/maniac/on_gain()
	. = ..()
	owner.special_role = ROLE_MANIAC
	owner.special_items["Maniac"] = pick(possible_weapons)
	owner.special_items["Surgical Kit"] = /obj/item/storage/backpack/rogue/backpack/surgery
	if(owner.current)
		if(ishuman(owner.current))
			var/mob/living/carbon/human/dreamer = owner.current
			dreamer.cmode_music = 'sound/music/combatmaniac2.ogg'
			owner.adjust_skillrank(/datum/skill/combat/knives, 6, TRUE)
			owner.adjust_skillrank(/datum/skill/combat/wrestling, 5, TRUE)
			owner.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
			STASTR = dreamer.STASTR
			STACON = dreamer.STACON
			STAEND = dreamer.STAEND
			dreamer.STASTR = 20
			dreamer.STACON = 20
			dreamer.STAEND = 20
		for(var/trait in applied_traits)
			ADD_TRAIT(owner.current, trait, "[type]")
		hallucinations = owner.current.overlay_fullscreen("maniac", /obj/screen/fullscreen/maniac)
	LAZYINITLIST(owner.learned_recipes)
	owner.learned_recipes |= recipe_progression[1]
	forge_villain_objectives()
	if(length(objectives))
		SEND_SOUND(owner.current, 'sound/villain/dreamer_warning.ogg')
		to_chat(owner.current, "<span class='danger'>[antag_memory]</span>")
		owner.announce_objectives()
	START_PROCESSING(SSobj, src)

/datum/antagonist/maniac/on_removal()
	STOP_PROCESSING(SSobj, src)
	if(owner.current)
		if(!silent)
			to_chat(owner.current,"<span class='danger'>I am no longer a MANIAC!</span>")
		if(ishuman(owner.current))
			var/mob/living/carbon/human/dreamer = owner.current
			dreamer.STASTR = STASTR
			dreamer.STACON = STACON
			dreamer.STAEND = STAEND
		for(var/trait in applied_traits)
			REMOVE_TRAIT(owner.current, trait, "[type]")
		owner.current.clear_fullscreen("maniac")
	QDEL_LIST(wonders_made)
	wonders_made = null
	owner.learned_recipes -= recipe_progression
	owner.special_role = null
	hallucinations = null
	return ..()

/datum/antagonist/maniac/proc/set_keys()
	key_nums = list()
	num_keys = list()
	//We need 4 numbers and four keys
	for(var/i in 1 to 4)
		//Make the number first
		var/randumb
		while(!randumb || (randumb in num_keys))
			randumb = "[rand(0,9)][rand(0,9)][rand(0,9)][rand(0,9)]"
		//Make the key second
		var/rantelligent
		while(!rantelligent || (rantelligent in key_nums))
			rantelligent = uppertext("[pick(GLOB.alphabet)][pick(GLOB.alphabet)][pick(GLOB.alphabet)][pick(GLOB.alphabet)]")

		//Stick then in the lists, continue the loop
		num_keys[randumb] = rantelligent
		key_nums[rantelligent] = randumb
	
	sum_keys = 0
	for(var/i in num_keys)
		sum_keys += text2num(i)

/datum/antagonist/maniac/proc/forge_villain_objectives()
	var/datum/objective/maniac/wakeup = new()
	objectives += wakeup

/datum/antagonist/maniac/proc/agony(mob/living/carbon/dreamer)
	var/sound/im_sick = sound('sound/villain/imsick.ogg', TRUE, FALSE, CHANNEL_IMSICK, 100)
	SEND_SOUND(dreamer, im_sick)
	dreamer.overlay_fullscreen("dream", /obj/screen/fullscreen/dreaming)
	dreamer.overlay_fullscreen("wakeup", /obj/screen/fullscreen/dreaming/waking_up)
	waking_up = TRUE

/* I don't have the patience to code this right now
/datum/antagonist/dreamer/proc/spawn_trey_liam()
	var/turf/spawnturf
	var/obj/effect/landmark/treyliam/trey = locate(/obj/effect/landmark/treyliam) in world
	if(trey)
		spawnturf = get_turf(trey)
	if(spawnturf)
		var/mob/living/carbon/human/trey_liam = new /mob/living/carbon/human(spawnturf)
		trey_liam.fully_replace_character_name(trey_liam.name, "Trey Liam")
		trey_liam.gender = MALE
		trey_liam.skin_tone = "ffe0d1"
		trey_liam.hair_color = "999999"
		trey_liam.hair_style = "Plain Long"
		trey_liam.facial_haircolor = "999999"
		trey_liam.facial_hairstyle = "Knowledge"
		trey_liam.age = AGE_OLD
		trey_liam.equipOutfit(/datum/outfit/treyliam)
		trey_liam.regenerate_icons()
		for(var/obj/machinery/vr_sleeper/chungus in get_turf(trey_liam))
			chungus.buckle_mob(trey_liam, TRUE, FALSE)
		return trey_liam
*/ 
/datum/antagonist/maniac/proc/wake_up()
	STOP_PROCESSING(SSobj, src)
	var/mob/living/carbon/dreamer = owner.current
	// var/client/dreamer_client = dreamer.client // Trust me, we need it later
	dreamer.clear_fullscreen("dream")
	dreamer.clear_fullscreen("wakeup")
	for(var/datum/objective/objective in objectives)
		objective.completed = TRUE
	for(var/mob/connected_player in GLOB.player_list)
		if(!connected_player.client)
			continue
		SEND_SOUND(connected_player, sound(null))
		SEND_SOUND(connected_player, 'sound/villain/dreamer_win.ogg')
	/* Can't be fucked with this right now
	var/mob/living/carbon/human/trey_liam = spawn_trey_liam()
	if(trey_liam)
		owner.transfer_to(trey_liam)
		//Explodie all our wonders
		for(var/obj/structure/wonder/wondie as anything in wonders_done)
			if(istype(wondie))
				explosion(wondie, 8, 16, 32, 64)
		var/obj/item/organ/brain/brain = dreamer.getorganslot(ORGAN_SLOT_BRAIN)
		var/obj/item/bodypart/head/head = dreamer.get_bodypart(BODY_ZONE_HEAD)
		if(head)
			head.dismember(BURN)
			if(!QDELETED(head))
				qdel(head)
		if(brain)
			qdel(brain)
		H.SetSleeping(250)
		dreamer_client.chatOutput?.loaded = FALSE
		dreamer_client.chatOutput?.start()
		dreamer_client.chatOutput?.load()
		H.add_stress(/datum/stressevent/maniac_woke_up)
		sleep(15)
		to_chat(H, "<span class='big bold'><span class='deadsay'>... WHERE AM I? ...</span></span>")
		sleep(30)
		to_chat(H, "<span class='deadsay'>... Rockhill? No ... It doesn't exist ...</span>")
		sleep(30)
		to_chat(H, "<span class='deadsay'>... My name is Trey. Trey Liam, Scientific Overseer ...</span>")
		sleep(30)
		to_chat(H, "<span class='deadsay'>... I'm on NT Aeon, a self sustaining ship, used to preserve what remains of humanity ...</span>")
		sleep(30)
		to_chat(H, "<span class='deadsay'>... Launched into the stars, INRL preserves their memories ... Their personalities ...</span>")
		sleep(30)
		to_chat(H, "<span class='deadsay'>... Keeps them alive in cyberspace, oblivious to the catastrophe ...</span>")
		sleep(30)
		to_chat(H, "<span class='deadsay'>... There is no hope left. Only the cyberspace deck lets me live in the forgery ...</span>")
		sleep(30)
		to_chat(H, "<span class='deadsay'>... What have i done!? ...</span>")
		sleep(40)
	else
		cant_wake_up()
	*/
	sleep(1 MINUTES)
	to_chat(world, "<span class='deadsay'><span class='reallybig'>The Maniac has TRIUMPHED!</span></span>")
	SSticker.declare_completion()
	SSticker.Reboot("The Maniac has TRIUMPHED.", "The Maniac has TRIUMPHED.", delay = 60 SECONDS)

/datum/antagonist/dreamer/proc/cant_wake_up()
	if(!iscarbon(owner?.current))
		return
	to_chat(owner.current, "<span class='deadsay'><span class='big bold'>I CAN'T WAKE UP.</span></span>")
	sleep(20)
	to_chat(owner.current, "<span class='deadsay'><span class='big bold'>ICANTWAKEUP</span></span>")
	sleep(10)
	var/mob/living/carbon/dreamer = owner.current
	var/obj/item/organ/brain/brain = dreamer.getorganslot(ORGAN_SLOT_BRAIN)
	var/obj/item/bodypart/head/head = dreamer.get_bodypart(BODY_ZONE_HEAD)
	if(head)
		head.dismember(BURN)
		if(!QDELETED(head))
			qdel(head)
	if(brain)
		qdel(brain)

//TODO Collate
/datum/antagonist/roundend_report()
	var/traitorwin = TRUE

	printplayer(owner)

	var/count = 0
	if(objectives.len)//If the traitor had no objectives, don't need to process this.
		for(var/datum/objective/objective in objectives)
			objective.update_explanation_text()
			if(objective.check_completion())
				to_chat(world, "<B>Dream #[count]</B>: [objective.explanation_text] <span class='greentext'>TRIUMPH!</span>")
			else
				to_chat(world, "<B>Dream #[count]</B>: [objective.explanation_text] <span class='redtext'>Failure.</span>")
				traitorwin = FALSE
			count += objective.triumph_count

	var/special_role_text = lowertext(name)
	if(!considered_alive(owner))
		traitorwin = FALSE

	if(traitorwin)
		if(count)
			if(owner)
				owner.adjust_triumphs(count)
		to_chat(world, "<span class='greentext'>The [special_role_text] has TRIUMPHED!</span>")
		if(owner?.current)
			owner.current.playsound_local(get_turf(owner.current), 'sound/misc/triumph.ogg', 100, FALSE, pressure_affected = FALSE)
	else
		to_chat(world, "<span class='redtext'>The [special_role_text] has FAILED!</span>")
		if(owner?.current)
			owner.current.playsound_local(get_turf(owner.current), 'sound/misc/fail.ogg', 100, FALSE, pressure_affected = FALSE)
