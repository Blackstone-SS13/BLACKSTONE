/datum/advclass/necromancer
	name = "Necromancer"
	tutorial = "Ostracized and hunted by society for their dark magics and perversion of life, Necromancers have been known to summon ghosts, ghouls, and zombies; you cannot."
	allowed_sexes = list("male", "female")
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Tiefling",
		"Argonian",
		"Dark Elf",
	)
	outfit = /datum/outfit/job/roguetown/adventurer/necromancer
	pickprob = 30
	traits_applied = list(TRAIT_ZOMBIE_IMMUNE)
	given_skills = list(
		/datum/skill/misc/reading = 4, \
		/datum/skill/magic/arcane = 5
	)
	stat_changes = list(
		"strength" = -1, \
		"intelligence" = 3, \
		"constitution" = -2, \
		"endurance" = -1, \
		"speed" = -1 
	)


/datum/outfit/job/roguetown/adventurer/necromancer
	allowed_patrons = list(/datum/patron/inhumen/zizo)

/datum/outfit/job/roguetown/adventurer/necromancer/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/necromhood
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/necromancer
	belt = /obj/item/storage/belt/rogue/leather/rope
	backl = /obj/item/storage/backpack/rogue/satchel
	beltr = /obj/item/reagent_containers/glass/bottle/rogue/manapot
	beltl = /obj/item/rogueweapon/huntingknife
	r_hand = /obj/item/rogueweapon/woodstaff
	H.mind.assign_experiences(/datum/advclass/necromancer::given_skills, TRUE, "skills")
	H.mind.assign_experiences(/datum/advclass/necromancer::stat_changes, TRUE, "stats")

	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/bonechill)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/raise_undead)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/sickness)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/eyebite)
	H.faction |= "undead"
