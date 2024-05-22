/datum/anvil_recipe/armor
	appro_skill = /datum/skill/craft/armorsmithing

/datum/anvil_recipe/armor/ichainmail
	name = "chainmail"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/suit/roguetown/armor/chainmail/iron

/datum/anvil_recipe/armor/ichaincoif
	name = "chain coif"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/neck/roguetown/chaincoif/iron

/datum/anvil_recipe/armor/gorget
	name = "iron gorget"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/neck/roguetown/gorget

/datum/anvil_recipe/armor/ibreastplate
	name = "iron breastplate (+iron)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/half/iron

/datum/anvil_recipe/armor/ichainglove
	name = "chain gauntlets"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/gloves/roguetown/chain/iron

/datum/anvil_recipe/armor/ichainleg
	name = "chain chausses"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/under/roguetown/chainlegs/iron

/datum/anvil_recipe/armor/platemask
	name = "iron mask"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/mask/rogue/facemask

/datum/anvil_recipe/armor/skullcap
	name = "iron skullcap"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/head/roguetown/helmet/skullcap

/datum/anvil_recipe/armor/studded
	name = "studded leather armor (+leather armor)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/clothing/suit/roguetown/armor/leather)
	created_item = /obj/item/clothing/suit/roguetown/armor/leather/studded

/datum/anvil_recipe/armor/helmetgoblin
	name = "iron goblin helmet (+iron)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron)
	created_item = /obj/item/clothing/head/roguetown/helmet/goblin

/datum/anvil_recipe/armor/plategoblin
	name = "iron goblin mail (+iron)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/half/iron/goblin

/datum/anvil_recipe/armor/wizardironcap
	name = "Wizard Iron Cap"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/wizardironcap

// --------- STEEL -----------

/datum/anvil_recipe/armor/haubergeon
	name = "haubergeon"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/suit/roguetown/armor/chainmail

/datum/anvil_recipe/armor/hauberk
	name = "hauberk (+steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk

/datum/anvil_recipe/armor/plate
	name = "half-plate armor (+2 steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel,/obj/item/ingot/steel)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate

/datum/anvil_recipe/armor/platefull
	name = "full-plate armor (+3 steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/ingot/steel, /obj/item/ingot/steel)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/full

/datum/anvil_recipe/armor/coatplates
	name = "coat of plates (+hide)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/natural/hide)
	created_item = /obj/item/clothing/suit/roguetown/armor/brigandine/coatplates

/datum/anvil_recipe/armor/brigandine
	name = "brigandine (+steel + gambeson)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/clothing/suit/roguetown/armor/gambeson)
	created_item = /obj/item/clothing/suit/roguetown/armor/brigandine

/datum/anvil_recipe/armor/chaincoif
	name = "chain coif"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/neck/roguetown/chaincoif

/datum/anvil_recipe/armor/chainglove
	name = "chain gauntlets"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/gloves/roguetown/chain

/datum/anvil_recipe/armor/plateglove
	name = "plate gauntlets"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/gloves/roguetown/plate

/datum/anvil_recipe/armor/chainleg
	name = "chain chausses"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/under/roguetown/chainlegs

/datum/anvil_recipe/armor/platelegs
	name = "plated chausses (+steel)"
	req_bar = /obj/item/ingot/steel 
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/under/roguetown/platelegs

/datum/anvil_recipe/armor/hplate
	name = "cuirass (+steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/half

/datum/anvil_recipe/armor/scalemail
	name = "scalemail"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/scale

/datum/anvil_recipe/armor/platebracer
	name = "plate bracers"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/wrists/roguetown/bracers

/datum/anvil_recipe/armor/helmetnasal
	name = "steel helmet"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/head/roguetown/helmet

/datum/anvil_recipe/armor/bervor
	name = "steel bervor"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/neck/roguetown/bervor

/datum/anvil_recipe/armor/helmetsall
	name = "sallet"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/head/roguetown/helmet/sallet

/datum/anvil_recipe/armor/helmetsallv
	name = "visored sallet (+steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/sallet/visored

/datum/anvil_recipe/armor/helmetbuc
	name = "bucket helmet (+steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/bucket

/datum/anvil_recipe/armor/helmetpig
	name = "pigface helmet (+steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/pigface

/datum/anvil_recipe/armor/bascinet
	name = "bascinet helmet"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/head/roguetown/helmet/bascinet

/datum/anvil_recipe/armor/helmetknight
	name = "knight's helmet (+steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/knight

/datum/anvil_recipe/armor/plateboot
	name = "plated boots"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/shoes/roguetown/boots/armor

/datum/anvil_recipe/armor/platemask/steel
	name = "steel mask"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/mask/rogue/facemask/steel

/datum/anvil_recipe/armor/astratahelm
	name = "astrata helmet (+steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/astratahelm

/datum/anvil_recipe/armor/necrahelm
	name = "necra helmet (+steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/necrahelm

/datum/anvil_recipe/armor/nochelm
	name = "noc helmet (+steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/nochelm

/datum/anvil_recipe/armor/dendorhelm
	name = "dendor helmet (+steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/dendorhelm

// ------------- RACIAL ---------------------

// Dwarf Punisher & Knights Armors

/datum/anvil_recipe/armor/dwarfhelm/knight
	name = "Dwarf Knight Helmet (+ Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/racial/dwarfknight

/datum/anvil_recipe/armor/dwarfhelm/punisher
	name = "Dwarf Punisher Helmet (+ Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/racial/dwarfpunisher

/datum/anvil_recipe/armor/dwarfhelm/overseer
	name = "Dwarf Overseer Helmet"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/racial/dwarfoverseer

/datum/anvil_recipe/armor/dwarfhelm/engineer
	name = "Dwarf Engineer Helmet"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/racial/dwarfengineer

/datum/anvil_recipe/armor/dwarfchest/punisher // Chestplate
	name = "Dwarf Punisher Chestplate (+ Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/suit/roguetown/armor/racial/dwarfpunisherchestplate

/datum/anvil_recipe/armor/dwarfchest/knight
	name = "Dwarf Knight Chestplate (+ Steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/suit/roguetown/armor/racial/dwarfknightchestplate

/datum/anvil_recipe/armor/dwarflegs/punisher // Leggings
	name = "Dwarf Punisher Leggings"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/shoes/roguetown/racial/dwarfpunisherboots

/datum/anvil_recipe/armor/dwarflegs/knight
	name = "Dwarf Knight Leggings"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/shoes/roguetown/racial/dwarfknightboots

/datum/anvil_recipe/armor/dwarfgloves/knight // Gloves
	name = "Dwarf Knight Gauntlets"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/gloves/roguetown/racial/dwarfknightgloves

/datum/anvil_recipe/armor/dwarfpunisher/gloves
	name = "Dwarf Punisher Gauntlets"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/gloves/roguetown/racial/dwarfpunishergloves
