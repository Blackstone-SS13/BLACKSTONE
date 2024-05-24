/datum/advclass/mage
	name = "Mage"
	tutorial = "Mages are usually grown-up apprentices of wizards. They are seeking adventure, using their arcyne knowledge to aid or ward off other adventurers."
	allowed_sexes = list("male")
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Argonian",
		"Dark Elf",
		"Aasimar"
	)
	outfit = /datum/outfit/job/roguetown/adventurer/mage
	given_skills = list(
		/datum/skill/combat/polearms = 1,
		/datum/skill/combat/bows = 1,
		/datum/skill/combat/wrestling = list(0, 1, 2),
		/datum/skill/combat/unarmed = list(0, 1, 2),
		/datum/skill/misc/swimming = 1,
		/datum/skill/misc/climbing = list(0, 1),
		/datum/skill/misc/athletics = 1,
		/datum/skill/combat/swords = list(0, 1),
		/datum/skill/combat/knives = list(0, 1, 2),
		/datum/skill/craft/crafting = list(0, 1),
		/datum/skill/misc/medicine = list(0, 1),
		/datum/skill/misc/riding = 1,
		/datum/skill/misc/reading = 4,
		/datum/skill/magic/arcane = 3
	)

	stat_changes = list(
		"strength" = -1,
		"intelligence" = 3,
		"constitution" = 1,
		"endurance" = -1
	)

/datum/outfit/job/roguetown/adventurer/mage
	allowed_patrons = list(/datum/patron/divine/noc)

/datum/outfit/job/roguetown/adventurer/mage/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/roguehood/mage
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	pants = /obj/item/clothing/under/roguetown/trou/leather
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/mage
	belt = /obj/item/storage/belt/rogue/leather/rope
	beltr = /obj/item/reagent_containers/glass/bottle/rogue/manapot
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	beltl = /obj/item/rogueweapon/huntingknife
	backl = /obj/item/storage/backpack/rogue/satchel
	r_hand = /obj/item/rogueweapon/woodstaff
	if(H.mind)
		to_chat(H, "<span class='warning'>Magic is often times refered to as an art. At times it is treated as a primordial beast, chaos incarnate. To more learned men it is a precise science, to be studied and examined. In the end, magic is all three of the above. It is Art, Chaos, and Science: a blessing, a curse, and progress. It all depends on who calls upon it, and for what purpose.</span>")
		H.mind.assign_experiences(/datum/advclass/mage::given_skills, TRUE, "skills")
		H.mind.assign_experiences(/datum/advclass/mage::stat_changes, TRUE, "stats")
		if(H.age == AGE_OLD)
			head = /obj/item/clothing/head/roguetown/wizhat/gen
			armor = /obj/item/clothing/suit/roguetown/shirt/robe
			H.change_stat("intelligence", 1)
			H.mind.adjust_skillrank(/datum/skill/magic/arcane, 2, TRUE)
			H.change_stat("strength", -1)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/fireball)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/lightningbolt)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/fetch)
