/// DEFINITIONS ///
#define CLERIC_T0 0
#define CLERIC_T1 1
#define CLERIC_T2 2
#define CLERIC_T3 3

#define CLERIC_REQ_0 0
#define CLERIC_REQ_1 100
#define CLERIC_REQ_2 250
#define CLERIC_REQ_3 500

// Cleric Holder Datums

/datum/devotion
	/// Mob that owns this datum
	var/mob/living/carbon/human/holder
	/// Patron this holder is for
	var/datum/patron/patron
	/// Current devotion we are holding
	var/devotion = 0
	/// Maximum devotion we can hold at once
	var/max_devotion = CLERIC_REQ_3 * 2
	/// Current progression (experience)
	var/progression = 0
	/// Maximum progression (experience) we can achieve
	var/max_progression = CLERIC_REQ_3
	/// Current spell tier, basically
	var/level = CLERIC_T0
	/// How much devotion is gained per process call
	var/passive_devotion_gain = 0
	/// How much progression is gained per process call
	var/passive_progression_gain = 0
	/// How much devotion is gained per prayer cycle
	var/prayer_effectiveness = 2
	/// Spells we have granted thus far
	var/list/granted_spells

/datum/devotion/New(mob/living/carbon/human/holder, datum/patron/patron)
	. = ..()
	src.holder = holder
	holder?.devotion = src
	src.patron = patron

/datum/devotion/Destroy(force)
	. = ..()
	holder?.devotion = null
	holder = null
	patron = null
	granted_spells = null
	STOP_PROCESSING(SSobj, src)
	
/datum/devotion/process()
	if(!passive_devotion_gain && !passive_progression_gain)
		return PROCESS_KILL
	var/devotion_multiplier = 1
	if(holder?.mind)
		devotion_multiplier += (holder.mind.get_skill_level(/datum/skill/magic/holy) / SKILL_LEVEL_LEGENDARY)
	update_devotion(round(passive_devotion_gain * devotion_multiplier), round(passive_progression_gain * devotion_multiplier), silent = TRUE)

/datum/devotion/proc/check_devotion(obj/effect/proc_holder/spell/spell)
	if(devotion - spell.devotion_cost < 0)
		return FALSE
	return TRUE

/datum/devotion/proc/update_devotion(dev_amt, prog_amt, silent = FALSE)
	devotion = clamp(devotion + dev_amt, 0, max_devotion)
	//Max devotion limit
	if((devotion >= max_devotion) && !silent)
		to_chat(holder, span_warning("I have reached the limit of my devotion..."))
	if(!prog_amt) // no point in the rest if it's just an expenditure
		return TRUE
	progression = clamp(progression + prog_amt, 0, max_progression)
	var/obj/effect/spell_unlocked
	switch(level)
		if(CLERIC_T0)
			if(progression >= CLERIC_REQ_1)
				spell_unlocked = patron.t1
				level = CLERIC_T1
		if(CLERIC_T1)
			if(progression >= CLERIC_REQ_2)
				spell_unlocked = patron.t2
				level = CLERIC_T2
		if(CLERIC_T2)
			if(progression >= CLERIC_REQ_3)
				spell_unlocked = patron.t3
				level = CLERIC_T3
	if(!spell_unlocked || !holder?.mind || holder.mind.has_spell(spell_unlocked, specific = FALSE))
		return TRUE
	spell_unlocked = new spell_unlocked
	if(!silent)
		to_chat(holder, span_boldnotice("I have unlocked a new spell: [spell_unlocked]"))
	usr.mind.AddSpell(spell_unlocked)
	LAZYADD(granted_spells, spell_unlocked)
	return TRUE

/datum/devotion/proc/grant_spells(mob/living/carbon/human/H)
	if(!H || !H.mind || !patron)
		return

	var/list/spelllist = list(patron.t0, patron.t1)
	for(var/spell_type in spelllist)
		if(!spell_type || H.mind.has_spell(spell_type))
			continue
		var/newspell = new spell_type
		H.mind.AddSpell(newspell)
		LAZYADD(granted_spells, newspell)
	level = CLERIC_T1
	update_devotion(50, 50, silent = TRUE)

/datum/devotion/proc/grant_spells_templar(mob/living/carbon/human/H)
	if(!H || !H.mind || !patron)
		return

	var/list/spelllist = list(/obj/effect/proc_holder/spell/targeted/churn, patron.t0)
	for(var/spell_type in spelllist)
		if(!spell_type || H.mind.has_spell(spell_type))
			continue
		var/newspell = new spell_type
		H.mind.AddSpell(newspell)
		LAZYADD(granted_spells, newspell)
	level = CLERIC_T0
	max_devotion = CLERIC_REQ_1 //Max devotion limit - Paladins are stronger but cannot pray to gain all abilities beyond t1
	max_progression = CLERIC_REQ_1

/datum/devotion/proc/grant_spells_churchling(mob/living/carbon/human/H)
	if(!H || !H.mind || !patron)
		return

	var/list/spelllist = list(patron.t0)
	for(var/spell_type in spelllist)
		if(!spell_type || H.mind.has_spell(spell_type))
			continue
		var/newspell = new spell_type
		H.mind.AddSpell(newspell)
		LAZYADD(granted_spells, newspell)
	level = CLERIC_T0
	max_devotion = CLERIC_REQ_1 //Max devotion limit - Churchlings only get the t0 spell
	max_progression = CLERIC_REQ_0

/datum/devotion/proc/grant_spells_priest(mob/living/carbon/human/H)
	if(!H || !H.mind || !patron)
		return

	granted_spells = list()
	var/list/spelllist = list(patron.t0, patron.t1, patron.t2, patron.t3)
	for(var/spell_type in spelllist)
		if(!spell_type || H.mind.has_spell(spell_type))
			continue
		var/newspell = new spell_type
		H.mind.AddSpell(newspell)
		LAZYADD(granted_spells, newspell)
	level = CLERIC_T3
	passive_devotion_gain = 1
	update_devotion(300, CLERIC_REQ_3, silent = TRUE)
	START_PROCESSING(SSobj, src)

// Debug verb
/mob/living/carbon/human/proc/devotionchange()
	set name = "(DEBUG)Change Devotion"
	set category = "Special Verbs"

	if(!devotion)
		return FALSE

	var/changeamt = input(src, "My devotion is [devotion.devotion]. How much to change?", "How much to change?") as null|num
	if(!changeamt)
		return FALSE
	devotion.update_devotion(changeamt)
	return TRUE

/mob/living/carbon/human/proc/devotionreport()
	set name = "Check Devotion"
	set category = "Cleric"

	if(!devotion)
		return FALSE
	
	to_chat(src,"My devotion is [devotion.devotion].")
	return TRUE

/mob/living/carbon/human/proc/clericpray()
	set name = "Give Prayer"
	set category = "Cleric"
	
	if(!devotion)
		return FALSE

	var/prayersesh = 0
	visible_message("[src] kneels their head in prayer to the Gods.", "I kneel my head in prayer to [devotion.patron.name].")
	for(var/i in 1 to 50)
		if(devotion.devotion >= devotion.max_devotion)
			to_chat(src, "<span class='warning'>I have reached the limit of my devotion...</warning>")
			break
		if(!do_after(src, 30))
			break
		var/devotion_multiplier = 1
		if(mind)
			devotion_multiplier += (mind.get_skill_level(/datum/skill/magic/holy) / SKILL_LEVEL_LEGENDARY)
		var/prayer_effectiveness = round(devotion.prayer_effectiveness * devotion_multiplier)
		devotion.update_devotion(prayer_effectiveness, prayer_effectiveness)
		prayersesh += prayer_effectiveness
	visible_message("[src] concludes their prayer.", "I conclude my prayer.")
	to_chat(src, "<font color='purple'>I gained [prayersesh] devotion!</font>")
	return TRUE
