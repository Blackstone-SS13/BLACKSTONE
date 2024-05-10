/mob/living/carbon/human/species/halfork
	race = /datum/species/halfork

/datum/species/halfork
	name = "Half Ork"
	id = "human"
	desc = "<b>Half Orks</b><br>\
	Half Orks are usually born through unconsentual relations of Ork and Human \
	Half Orks are known for their strength and lineage derived from their orkish heritage. \
	They mostly take their cosmetics characteristics from their human side. \
	Most of Civilized society is reviled and disgusted with half orks. \
	The only known human nation to completely integrate half orks are the tribes of gronn. \""


	skin_tone_wording = "Clan"

	species_traits = list(EYECOLOR,HAIR,FACEHAIR,LIPS,STUBBLE,OLDGREY)
	inherent_traits = list(TRAIT_NOMOBSWAP)
	default_features = list("mcolor" = "FFF", "wings" = "None")
	use_skintones = 1
	skinned_type = /obj/item/stack/sheet/animalhide/human
	disliked_food = NONE
	liked_food = NONE
	possible_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_OLD)
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	limbs_icon_m = 'icons/roguetown/mob/bodies/m/mt.dmi'
	limbs_icon_f = 'icons/roguetown/mob/bodies/f/fm.dmi'
	dam_icon = 'icons/roguetown/mob/bodies/dam/dam_male.dmi'
	dam_icon_f = 'icons/roguetown/mob/bodies/dam/dam_female.dmi'
	hairyness = "t1"
	soundpack_m = /datum/voicepack/male/elf
	soundpack_f = /datum/voicepack/female/elf
	offset_features = list(OFFSET_ID = list(0,1), OFFSET_GLOVES = list(0,1), OFFSET_WRISTS = list(0,1),\
	OFFSET_CLOAK = list(0,1), OFFSET_FACEMASK = list(0,1), OFFSET_HEAD = list(0,1), \
	OFFSET_FACE = list(0,1), OFFSET_BELT = list(0,1), OFFSET_BACK = list(0,1), \
	OFFSET_NECK = list(0,1), OFFSET_MOUTH = list(0,1), OFFSET_PANTS = list(0,1), \
	OFFSET_SHIRT = list(0,1), OFFSET_ARMOR = list(0,1), OFFSET_HANDS = list(0,1), OFFSET_UNDIES = list(0,1), \
	OFFSET_ID_F = list(0,-1), OFFSET_GLOVES_F = list(0,0), OFFSET_WRISTS_F = list(0,0), OFFSET_HANDS_F = list(0,0), \
	OFFSET_CLOAK_F = list(0,0), OFFSET_FACEMASK_F = list(0,-1), OFFSET_HEAD_F = list(0,-1), \
	OFFSET_FACE_F = list(0,-1), OFFSET_BELT_F = list(0,-1), OFFSET_BACK_F = list(0,-1), \
	OFFSET_NECK_F = list(0,-1), OFFSET_MOUTH_F = list(0,-1), OFFSET_PANTS_F = list(0,0), \
	OFFSET_SHIRT_F = list(0,0), OFFSET_ARMOR_F = list(0,0), OFFSET_UNDIES_F = list(0,0))
	specstats = list("strength" = 1, "perception" = -1, "intelligence" = -1, "constitution" = 2, "endurance" = 1, "speed" = 1, "fortune" = 0)
	specstats_f = list("strength" = 1, "perception" = -1, "intelligence" = -1, "constitution" = 1, "endurance" = 2, "speed" = 1, "fortune" = 0)
	enflamed_icon = "widefire"


/datum/species/halfork/check_roundstart_eligible()
	return FALSE

/datum/species/halfork/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	..()
	RegisterSignal(C, COMSIG_MOB_SAY, PROC_REF(handle_speech))
	C.grant_language(/datum/language/common)

/datum/species/halfork/after_creation(mob/living/carbon/C)
	..()
	C.grant_language(/datum/language/orcish)
	to_chat(C, "<span class='info'>I can speak Orcish with ,o before my speech.</span>")

/datum/species/halfork/on_species_loss(mob/living/carbon/C)
	. = ..()
	UnregisterSignal(C, COMSIG_MOB_SAY)
	C.remove_language(/datum/language/orcish)

/datum/species/halfork/handle_speech(datum/source, mob/speech_args)
	. = ..()
	var/message = speech_args[SPEECH_MESSAGE]
	if(message)
		if(message[1])
			if(message[1] != "*")
				message = " [message]"
				var/list/accent_words = strings("accent_universal.json", "universal")

				for(var/key in accent_words)
					var/value = accent_words[key]
					if(islist(value))
						value = pick(value)

					message = replacetextEx(message, " [uppertext(key)]", " [uppertext(value)]")
					message = replacetextEx(message, " [capitalize(key)]", " [capitalize(value)]")
					message = replacetextEx(message, " [key]", " [value]")

	speech_args[SPEECH_MESSAGE] = trim(message)

/datum/species/halfork/qualifies_for_rank(rank, list/features)
	return TRUE

/datum/species/halfork/get_skin_list()
	return list(
		"Shellcrest Raiders" = SKIN_COLOR_SHELLCREST,
		"Bloodaxe Clan"	   =  SKIN_COLOR_BLOOD_AXE,
		"Gronn" = SKIN_COLOR_GROONN, //gronns are the dominant ones with orks
		"Black Hammer Tribe" = SKIN_COLOR_BLACK_HAMMER,
		"Skullseeker Sect" = SKIN_COLOR_SKULL_SEEKER
	)

/datum/species/aasimar/get_hairc_list()
	return sortList(list(
	"Minotaur" = "58433b",
	"Volf" = "48322a",
	"Maneater" = "458745",
	"Mud" = "201616",
	))

/datum/species/tieberian/random_name(gender,unique,lastname)

	var/randname
	if(unique)
		if(gender == MALE)
			for(var/i in 1 to 10)
				randname = pick( world.file2list("strings/rt/names/other/halforkm.txt") )
				if(!findname(randname))
					break
		if(gender == FEMALE)
			for(var/i in 1 to 10)
				randname = pick( world.file2list("strings/rt/names/other/halforkf.txt") )
				if(!findname(randname))
					break
	else
		if(gender == MALE)
			randname = pick( world.file2list("strings/rt/names/other/halforkm.txt") )
		if(gender == FEMALE)
			randname = pick( world.file2list("strings/rt/names/other/halforkf.txt") )
	return randname

/datum/species/halfork/random_surname()
	return

/datum/species/halfork/get_accent(mob/living/carbon/human/H)
	return strings("proper_replacement.json", "proper")
