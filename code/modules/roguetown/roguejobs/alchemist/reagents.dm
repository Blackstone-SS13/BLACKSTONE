/datum/reagent/medicine/healthpot
	name = "Health Potion"
	description = "Gradually regenerates all types of damage."
	reagent_state = LIQUID
	color = "#ff0000"
	taste_description = "red"
	overdose_threshold = 0
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	alpha = 173

/datum/reagent/medicine/healthpot/on_mob_life(mob/living/carbon/M)
	if(M.blood_volume < BLOOD_VOLUME_NORMAL)
		M.blood_volume = min(M.blood_volume+50, BLOOD_VOLUME_MAXIMUM)
	else
		//can overfill you with blood, but at a slower rate
		M.blood_volume = min(M.blood_volume+10, BLOOD_VOLUME_MAXIMUM)
	M.adjustBruteLoss(-0.5*REM, 0)
	M.adjustFireLoss(-0.5*REM, 0)
	M.adjustOxyLoss(-1, 0)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, -1*REM)
	M.adjustCloneLoss(-1*REM, 0)
	..()
	. = 1

/datum/reagent/medicine/manapot
	name = "Mana Potion"
	description = "Gradually regenerates stamina."
	reagent_state = LIQUID
	color = "#0000ff"
	taste_description = "manna"
	overdose_threshold = 0
	metabolization_rate = 20 * REAGENTS_METABOLISM
	alpha = 173

/datum/reagent/medicine/manapot/on_mob_life(mob/living/carbon/M)
	M.rogstam_add(100)
	..()
	. = 1

/datum/reagent/medicine/strengthpot
	name = "Strength Potion"
	description = "A viscous, thick, black-blood like liquid. Expands muscles in the upper body for some time, and makes your skin harder to pierce."
	reagent_state = LIQUID
	color = "#3f0000"
	taste_description = "bitter and meaty"
	overdose_threshold = 0
	metabolization_rate = 0.35 * REAGENTS_METABOLISM
	alpha = 173

/datum/status_effect/buff/strong
    id = "strong"
    alert_type = null
    effectedstats = list("strength" = 6, "constitution" = 3, "endurance" = 3, "speed" = -9, "intelligence" = -5, "fortune" = -1)
    duration = 45 SECONDS

/atom/movable/screen/alert/status_effect/buff/strong
    name = "Strong"
    desc = "I could lift anything!"
    icon_state = ""

/datum/reagent/strengthpot/on_mob_life(mob/living/carbon/M)
    M.apply_status_effect(/datum/status_effect/buff/strong)
    ..()

/datum/reagent/medicine/swiftpot
	name = "Swiftness Potion"
	description = "A bubbling, bright green liquid, it seems to be swirling by itself. Greatly increases speed for a short period of time, and gives you stamina, at the cost of making you more prone to devestating, lethal injuries and making your bones soft and plyable."
	reagent_state = LIQUID
	color = "#56e300"
	taste_description = "fur and dirt"
	metabolization_rate = 1.25 * REAGENTS_METABOLISM
	alpha = 173

/datum/status_effect/buff/speedy
    id = "zoomies"
    alert_type = null
    effectedstats = list("speed" = 12, "endurance" = -8, "fortune" = -15)
    duration = 12 SECONDS

/atom/movable/screen/alert/status_effect/buff/speedy
    name = "Zoomies"
    desc = "I got the zoomies!"
    icon_state = ""

/datum/reagent/swiftpot/on_mob_life(mob/living/carbon/M)
	M.apply_status_effect(/datum/status_effect/buff/speedy)
	ADD_TRAIT(M, TRAIT_NOROGSTAM, INNATE_TRAIT)
	..()

/datum/reagent/medicine/swiftpot/on_remove()
    REMOVE_TRAIT(M, TRAIT_NOROGSTAM, source)
    . = ..()

/datum/reagent/berrypoison
	name = "Berry Poison"
	description = "Contains a poisonous thick, dark purple liquid."
	reagent_state = LIQUID
	color = "#00B4FF"
	metabolization_rate = 0.1

/datum/reagent/berrypoison/on_mob_life(mob/living/carbon/M)
	if(!HAS_TRAIT(M, TRAIT_NASTY_EATER))
		M.add_nausea(9)
		M.adjustToxLoss(3, 0)
	return ..()

/datum/reagent/organpoison
	name = "Organ Poison"
	description = "A viscous black liquid clings to the glass."
	reagent_state = LIQUID
	color = "#ff2f00"
	metabolization_rate = 0.1

/datum/reagent/organpoison/on_mob_life(mob/living/carbon/M)
	if(!HAS_TRAIT(M, TRAIT_NASTY_EATER) && !HAS_TRAIT(M, TRAIT_ORGAN_EATER))
		M.add_nausea(9)
		M.adjustToxLoss(3, 0)
	return ..()
