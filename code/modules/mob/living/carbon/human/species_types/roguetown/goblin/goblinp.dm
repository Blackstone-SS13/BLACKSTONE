/mob/living/carbon/human/species/goblinp
	race = /datum/species/goblinp


/datum/species/goblinp
	name = "Goblin"
	id = "goblinp"
	desc = "<b>Goblin</b><br>\
	A vile, cursed race of green skinned fiends with brains as small as their hearts. Be not fooled by their appearance - What they lack in stature, they possess in sheer malice."
	species_traits = list(NO_UNDERWEAR,NOEYESPRITES)
	inherent_traits = list(RTRAIT_NOFATSTAM,TRAIT_RESISTCOLD,TRAIT_RESISTHIGHPRESSURE,TRAIT_RESISTLOWPRESSURE,TRAIT_RADIMMUNE)
	no_equip = list(SLOT_SHIRT, SLOT_WEAR_MASK, SLOT_GLOVES, SLOT_SHOES, SLOT_PANTS, SLOT_S_STORE)
	possible_ages = list(AGE_ADULT)
	default_features = list("mcolor" = "FFF", "wings" = "None")
	use_skintones = 1
	limbs_icon_m = 'icons/roguetown/mob/bodies/m/mg.dmi'
	limbs_icon_f = 'icons/roguetown/mob/bodies/m/mg.dmi'
	dam_icon = 'icons/roguetown/mob/bodies/dam/dam_male.dmi'
	dam_icon_f = 'icons/roguetown/mob/bodies/dam/dam_female.dmi'
	soundpack_m = /datum/voicepack/male/goblin
	soundpack_f = /datum/voicepack/male/goblin
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	nojumpsuit = 1
	offset_features = list(OFFSET_ID = list(0,0), OFFSET_WRISTS = list(0,0),\
	OFFSET_CLOAK = list(0,0), \
	OFFSET_FACE = list(0,-4), OFFSET_BELT = list(0,-1), OFFSET_BACK = list(0,-4), \
	OFFSET_NECK = list(0,-4), OFFSET_MOUTH = list(0,-3), \
	OFFSET_ARMOR = list(0,0), OFFSET_HANDS = list(0,-4), \
	OFFSET_ID_F = list(0,-4), OFFSET_WRISTS_F = list(0,-4), OFFSET_HANDS_F = list(0,-4), \
	OFFSET_CLOAK_F = list(0,0), \
	OFFSET_FACE_F = list(0,-5), OFFSET_BELT_F = list(0,-1), OFFSET_BACK_F = list(0,-5), \
	OFFSET_NECK_F = list(0,-5), OFFSET_MOUTH_F = list(0,-3), \
	OFFSET_ARMOR_F = list(0,0), OFFSET_UNDIES = list(0,0), OFFSET_UNDIES_F = list(0,0))


/datum/species/goblinp/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	..()
	RegisterSignal(C, COMSIG_MOB_SAY, PROC_REF(handle_speech))
	C.grant_language(/datum/language/orcish)

	C.cmode_music = 'sound/music/combat_gronn.ogg'
