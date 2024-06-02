/datum/job/roguetown/dwarfleader
	title = "Expedition Leader"
	flag = DWARFLEADER
	department_flag = DWARFFORT
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list("Dwarf")
	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD)
	tutorial = "Decades ago, you and six of your kin braved the perilous, swampy wilderness of Enigma to establish an outpost for your Mountainhome. It wasn't long after you'd expanded north through the mountain ridge that your people were discovered by Humens, who had built a town to the north named Rockhill. It came as little surprise that, with how famous craftsdwarfship was throughout the world, the Humen King sent an emissary to your fort to establish trade and diplomatic relations. Since then, many a dwarf has come and gone, taking supplies with them to be part of the growing Humen kingdom. This past winter has been hard on crops, and a recent earthquake dumped your smithy and metalsmiths into the sweltering volcanic cavern below. With supplies running low, and only a singular riddle of steel recovered from the collapse of Malum's Terrace, it comes down to you to organize the remaining residents of your fort, provide for your fellow dwarves, and start attracting skilled migrants from the Mountainhomes once more."
	display_order = JDO_DWARFLEADER
	selection_color = JCOLOR_DWARFFORT
	whitelist_req = FALSE

	outfit = /datum/outfit/job/roguetown/dwarfleader
	min_pq = 1
	max_pq = null

/datum/outfit/job/roguetown/dwarfleader
	name = "Expedition Leader"

/datum/outfit/job/roguetown/dwarfleader/pre_equip(mob/living/carbon/human/H)
	..()
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/sailor
	pants = /obj/item/clothing/under/roguetown/tights/random
	armor = /obj/item/clothing/cloak/stabard
	ADD_TRAIT(H, RTRAIT_SEEPRICES, type)
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	head = /obj/item/clothing/head/roguetown/bardhat
	belt = /obj/item/storage/belt/rogue/leather/plaquesilver
	beltr = /obj/item/rogueweapon/mace/cudgel
	beltl =  /obj/item/flashlight/flare/torch/lantern
	backr = /obj/item/storage/backpack/rogue/satchel/black
	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel = 1, /obj/item/riddleofsteel = 1, /datum/supply_pack/rogue/tools/flint = 1)

	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 6, TRUE)// Like a steward, but skilled in construction and with axes/maces instead of knives.
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/masonry, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/engineering, 5, TRUE)
		H.change_stat("intelligence", 2)
		H.change_stat("perception", 2)
		H.change_stat("speed", -1)
	ADD_TRAIT(H, RTRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, RTRAIT_SEEPRICES, TRAIT_GENERIC)

/datum/job/roguetown/guardsdwarf
	title = "Guardian"
	flag = GUARDSDWARF
	department_flag = DWARFFORT
	faction = "Station"
	total_positions = 4
	spawn_positions = 4

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list("Dwarf")
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)
	tutorial = "Though your fortress has fallen on hard times, and many kin have come and gone, you've never been a fair weather dwarf. It's folk like you, stout, tenacious, and skilled with bows, maces, and flails, who keep the bandits and the bannermen from just knocking down the gates and doing as they please. Assist the aging Expedition Leader in keeping your fort and your fellow dwarves safe."
	display_order = JDO_GUARDSDWARF
	whitelist_req = FALSE

	outfit = /datum/outfit/job/roguetown/guardsdwarf
	min_pq = 1
	max_pq = null

/datum/outfit/job/roguetown/guardsdwarf
	name = "Guardian"
	var/bowman_amount = 0
	/// Maximum amount of bowdwarves that can be spawned
	var/bowman_max = 2

/datum/outfit/job/roguetown/guardsdwarf/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/horned
	pants = /obj/item/clothing/under/roguetown/chainlegs/iron
	cloak = /obj/item/clothing/cloak/stabard/surcoat
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	armor = /obj/item/clothing/suit/roguetown/armor/plate/half/iron
	neck = /obj/item/clothing/neck/roguetown/gorget
	gloves = /obj/item/clothing/gloves/roguetown/plate/iron
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor/iron
	beltl = /obj/item/flashlight/flare/torch/lantern
	belt = /obj/item/storage/belt/rogue/leather/black
	wrists = /obj/item/clothing/wrists/roguetown/bracers/iron
	backr = /obj/item/storage/backpack/rogue/satchel/black
	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel = 1, /obj/item/rope/chain = 1, /datum/supply_pack/rogue/tools/flint = 1)
	if((bowman_amount < bowman_max))
		bowman_amount++
		backl = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
		beltr = /obj/item/quiver/arrows
	else
		backl = /obj/item/rogueweapon/shield/tower/metal
		beltr = /obj/item/rogueweapon/flail/sflail
	if(H.mind)
		assign_skills(H)
	if(H.gender == FEMALE)
		var/acceptable = list("Tomboy", "Bob", "Curly Short")
		if(!(H.hairstyle in acceptable))
			H.hairstyle = pick(acceptable)
			H.update_hair()
	H.verbs |= /mob/proc/haltyell
	ADD_TRAIT(H, RTRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, RTRAIT_MEDIUMARMOR, TRAIT_GENERIC)

/datum/outfit/job/roguetown/guardsdwarf/proc/assign_skills(mob/living/carbon/human/guard)
	guard.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 4, TRUE)
	guard.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	guard.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
	guard.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	guard.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	guard.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 4, TRUE)
	guard.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	guard.mind.adjust_skillrank(/datum/skill/combat/bows, 4, TRUE)
	guard.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
	guard.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	guard.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	guard.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
	guard.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	guard.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	guard.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	guard.change_stat("strength", 1)
	guard.change_stat("perception", 3)
	guard.change_stat("constitution", 1)
	guard.change_stat("endurance", 1)
	guard.change_stat("speed", 2)

/datum/job/roguetown/provisioner
	title = "Provisioner"
	flag = PROVISIONER
	department_flag = DWARFFORT
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list("Dwarf")
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_OLD)
	tutorial = "Of the eight dwarves in your fortress, it often feels like you're the only one getting anything productive done. You're responsible for growing food, producing clothes, brewing ale, fixing tools and armor, and cooking up meals for yourself and your fellow dwarves. You're also second-in-command if the Expedition Leader suffers an unfortunate accident."
	display_order = JDO_PROVISIONER
	whitelist_req = FALSE

	outfit = /datum/outfit/job/roguetown/provisioner
	min_pq = 1
	max_pq = null

/datum/outfit/job/roguetown/provisioner
	name = "Provisioner"

/datum/outfit/job/roguetown/provisioner/pre_equip(mob/living/carbon/human/H)
	..()
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	pants = /obj/item/clothing/under/roguetown/tights
	cloak = /obj/item/clothing/cloak/stabard/surcoat
	armor = /obj/item/clothing/suit/roguetown/armor/leather/studded
	shoes = /obj/item/clothing/shoes/roguetown/boots
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/quiver/arrows
	beltl =  /obj/item/flashlight/flare/torch/lantern
	backl = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
	backr = /obj/item/storage/backpack/rogue/satchel/black
	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel = 1, /obj/item/rogueweapon/hammer/claw = 1, /datum/supply_pack/rogue/tools/flint = 1)
	if(H.mind)
		assign_skills(H)

/datum/outfit/job/roguetown/provisioner/proc/assign_skills(mob/living/carbon/human/provisioner)
	provisioner.mind.adjust_skillrank(/datum/skill/combat/bows, 5, TRUE)
	provisioner.mind.adjust_skillrank(/datum/skill/combat/crossbows, 4, TRUE)
	provisioner.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	provisioner.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	provisioner.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	provisioner.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
	provisioner.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	provisioner.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	provisioner.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	provisioner.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
	provisioner.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	provisioner.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	provisioner.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	provisioner.change_stat("perception", 3)
	provisioner.change_stat("intelligence", 1)
	provisioner.change_stat("speed", 2)

/datum/job/roguetown/tunneler
	title = "Tunneler"
	flag = DWARFMINER
	department_flag = DWARFFORT
	faction = "Station"
	total_positions = 2
	spawn_positions = 2

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list("Dwarf")
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_OLD)
	tutorial = "With the recent collapse of Malum's Terrace, the beating heart of your fortress' steel industry, the lives of many of your fellow miners were lost. As one of the two remaining tunnelers, you provide the muscle needed for the fortress to expand and recover. Keep the fort supplied with ore and help your kin carve out new rooms and facilities so that the population and industry may grow."
	display_order = JDO_PROVISIONER
	whitelist_req = FALSE

	outfit = /datum/outfit/job/roguetown/tunneler
	min_pq = 1
	max_pq = null

/datum/outfit/job/roguetown/tunneler/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/armingcap/dwarf
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	pants = /obj/item/clothing/under/roguetown/tights
	cloak = /obj/item/clothing/cloak/stabard/surcoat
	armor = /obj/item/clothing/suit/roguetown/armor/leather
	shoes = /obj/item/clothing/shoes/roguetown/boots
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	gloves = /obj/item/clothing/gloves/roguetown/leather
	belt = /obj/item/storage/belt/rogue/leather
	beltl =  /obj/item/flashlight/flare/torch/lantern
	backl = /obj/item/storage/backpack/rogue/satchel
	backr = /obj/item/storage/backpack/rogue/backpack
	backpack_contents = list(/datum/supply_pack/rogue/tools/flint = 1, /obj/item/storage/roguebag = 1)
	if(H.mind)
		assign_skills(H)

/datum/outfit/job/roguetown/tunneler/proc/assign_skills(mob/living/carbon/human/tunneler)
	tunneler.mind.adjust_skillrank(/datum/skill/combat/wrestling, 5, TRUE) //Drown a bandit in the lake today!
	tunneler.mind.adjust_skillrank(/datum/skill/combat/unarmed, 5, TRUE) //Punch a Dark Elf in the groin!
	tunneler.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
	tunneler.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
	tunneler.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
	tunneler.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	tunneler.mind.adjust_skillrank(/datum/skill/misc/athletics, 6, TRUE)
	tunneler.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	tunneler.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	tunneler.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	tunneler.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	tunneler.mind.adjust_skillrank(/datum/skill/craft/carpentry, 2, TRUE)
	tunneler.mind.adjust_skillrank(/datum/skill/craft/masonry, 3, TRUE)
	tunneler.change_stat("strength", 2)

/datum/job/roguetown/emissary
	title = "Emissary"
	flag = DWARFLEADER
	department_flag = DWARFFORT
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_sexes = list(MALE)
	allowed_races = list("Humen", "Dwarf")
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_OLD)
	tutorial = "Responsible for attempting to maintain amicable, even profitable relations between Humen and Dwarf, you are the liason between His Majesty, the King of Rockhill, and the Dwarven Fortress known as Steelrest. Once a pillar of Rockhill's steel industry, the fortress was famous for a multi-floor lava foundry constructed in the shaft of the volcano, known as Malum's Terrace. Not but a few years ago, earthquakes broke the Terrance loose of its moorings and tumbled it into the molten rock below, killing most of the fort's industrial workers and bringing its steel production to a halt. Your task is to keep watch on the remaining dwarves and represent the interests of the Crown to them, and to represent their interests to the Crown in turn."
	display_order = JDO_EMISSARY
	selection_color = JCOLOR_DWARFFORT
	whitelist_req = FALSE

	outfit = /datum/outfit/job/roguetown/emissary
	min_pq = 1
	max_pq = null

/datum/outfit/job/roguetown/emissary
	name = "Emissary"

/datum/outfit/job/roguetown/emissary/pre_equip(mob/living/carbon/human/H)
	..()
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	pants = /obj/item/clothing/under/roguetown/tights
	armor = /obj/item/clothing/cloak/stabard/guard
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	head = /obj/item/clothing/head/roguetown/bardhat
	belt = /obj/item/storage/belt/rogue/leather/plaquesilver
	beltl =  /obj/item/flashlight/flare/torch/lantern
	backr = /obj/item/storage/backpack/rogue/satchel/black
	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel = 1, /datum/supply_pack/rogue/tools/flint = 1)

	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.change_stat("intelligence", 2)
		H.change_stat("perception", 2)
		H.change_stat("speed", -1)
	ADD_TRAIT(H, RTRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, RTRAIT_SEEPRICES, TRAIT_GENERIC)
