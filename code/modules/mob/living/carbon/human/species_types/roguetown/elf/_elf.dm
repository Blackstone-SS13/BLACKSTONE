/mob/living/carbon/human/species/elf
	race = /datum/species/elf

/datum/species/elf
	name = "Elfb"
	id = "elf"
	max_age = 850
	mutanteyes = /obj/item/organ/eyes/elf

/datum/species/elf/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	..()
	RegisterSignal(C, COMSIG_MOB_SAY, PROC_REF(handle_speech))
	C.grant_language(/datum/language/common)
	C.grant_language(/datum/language/elvish)

	var/mob/living/carbon/human/species/elf/H = C
	if(H.age == AGE_YOUNG)
		offset_features = list(OFFSET_ID = list(0,-1), OFFSET_GLOVES = list(0,-1), OFFSET_WRISTS = list(0,-1),\
		OFFSET_CLOAK = list(0,-1), OFFSET_FACEMASK = list(0,-1), OFFSET_HEAD = list(0,-1), \
		OFFSET_FACE = list(0,-1), OFFSET_BELT = list(0,-1), OFFSET_BACK = list(0,-1), \
		OFFSET_NECK = list(0,-1), OFFSET_MOUTH = list(0,-1), OFFSET_PANTS = list(0,-1), \
		OFFSET_SHIRT = list(0,-1), OFFSET_ARMOR = list(0,-1), OFFSET_HANDS = list(0,-1), OFFSET_UNDIES = list(0,-1), \
		OFFSET_ID_F = list(0,-1), OFFSET_GLOVES_F = list(0,-1), OFFSET_WRISTS_F = list(0,-1), OFFSET_HANDS_F = list(0,-2), \
		OFFSET_CLOAK_F = list(0,-1), OFFSET_FACEMASK_F = list(0,-2), OFFSET_HEAD_F = list(0,-2), \
		OFFSET_FACE_F = list(0,-2), OFFSET_BELT_F = list(0,-1), OFFSET_BACK_F = list(0,-2), \
		OFFSET_NECK_F = list(0,-2), OFFSET_MOUTH_F = list(0,-2), OFFSET_PANTS_F = list(0,-1), \
		OFFSET_SHIRT_F = list(0,-1), OFFSET_ARMOR_F = list(0,-1), OFFSET_UNDIES_F = list(0,-1))

		limbs_icon_m = 'icons/roguetown/mob/bodies/m/ms.dmi'
		limbs_icon_f = 'icons/roguetown/mob/bodies/f/fs.dmi'

		hairyness = null

//		soundpack_m = new /datum/voicepack/male/young()
		H.has_stubble = FALSE
		H.facial_hairstyle = "None"
		H.update_hair()
		H.update_body()

/datum/species/elf/after_creation(mob/living/carbon/C)
	..()
//	if(!C.has_language(/datum/language/elvish))
	C.grant_language(/datum/language/elvish)
	to_chat(C, span_info("I can speak Elfish with ,e before my speech."))

/datum/species/elf/on_species_loss(mob/living/carbon/C)
	. = ..()
	UnregisterSignal(C, COMSIG_MOB_SAY)
	C.remove_language(/datum/language/elvish)

/datum/species/elf/qualifies_for_rank(rank, list/features)
	return TRUE

/datum/species/elf/get_skin_list()
	return sortList(list(
	"skin1" = "ffe0d1",
	"skin2" = "fcccb3"
	))

/datum/species/elf/get_hairc_list()
	return sortList(list(
	"black - nightsky" = "0a0707",
	"brown - treebark" = "362e25",
	"blonde - moonlight" = "dfc999",
	"red - autumn" = "a34332"
	))
