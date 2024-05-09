/*!
This subsystem mostly exists to populate and manage the skill singletons.
*/

SUBSYSTEM_DEF(skills)
	name = "Skills"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_SKILLS
	///Dictionary of skill.type || skill ref
	var/list/all_skills = list()
	///Static assoc list of levels (ints) - strings
	var/static/list/level_names = list(
		SKILL_LEVEL_NOVICE = "<span class='info'><span class='small'>Novice</span></span>", 
		SKILL_LEVEL_APPRENTICE = "<span class='info'>Apprentice</span>", 
		SKILL_LEVEL_JOURNEYMAN = "<span class='biginfo'>Journeyman</span>", 
		SKILL_LEVEL_EXPERT = "<span class='biginfo'>Expert</span>", 
		SKILL_LEVEL_MASTER = "<b>Master</b>", 
		SKILL_LEVEL_LEGENDARY = "<span class='greentext'><b>Legendary</b></span>",
	)//This list is already in the right order, due to indexing

/datum/controller/subsystem/skills/Initialize(timeofday)
	InitializeSkills()
	return ..()

///Ran on initialize, populates the skills dictionary
/datum/controller/subsystem/skills/proc/InitializeSkills(timeofday)
	for(var/type in subtypesof(/datum/skill))
		var/datum/skill/ref = new type
		all_skills[type] = ref
