/datum/anvil_recipe/armor
	appro_skill = /datum/skill/craft/armorsmithing
	craftdiff = 1

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
	craftdiff = 2
	
/datum/anvil_recipe/armor/plategoblin
	name = "iron goblin mail (+iron)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/half/iron/goblin
	craftdiff = 2

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
	craftdiff = 2

/datum/anvil_recipe/armor/plate
	name = "half-plate armor (+2 steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel,/obj/item/ingot/steel)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate
	craftdiff = 3

/datum/anvil_recipe/armor/platefull
	name = "full-plate armor (+3 steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/ingot/steel, /obj/item/ingot/steel)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/full
	craftdiff = 4

/datum/anvil_recipe/armor/coatplates
	name = "coat of plates (+hide)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/natural/hide)
	created_item = /obj/item/clothing/suit/roguetown/armor/brigandine/coatplates
	craftdiff = 2

/datum/anvil_recipe/armor/brigandine
	name = "brigandine (+steel + gambeson)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/clothing/suit/roguetown/armor/gambeson)
	created_item = /obj/item/clothing/suit/roguetown/armor/brigandine
	craftdiff = 3

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
	craftdiff = 2

/datum/anvil_recipe/armor/hplate
	name = "cuirass (+steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/suit/roguetown/armor/plate/half
	craftdiff = 2

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
	craftdiff = 2

/datum/anvil_recipe/armor/helmetbuc
	name = "bucket helmet (+steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/bucket
	craftdiff = 2

/datum/anvil_recipe/armor/helmetpig
	name = "pigface helmet (+steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/pigface
	craftdiff = 2

/datum/anvil_recipe/armor/bascinet
	name = "bascinet helmet"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/head/roguetown/helmet/bascinet
	craftdiff = 2

/datum/anvil_recipe/armor/helmetknight
	name = "knight's helmet (+steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/knight
	craftdiff = 2

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
	craftdiff = 2

/datum/anvil_recipe/armor/necrahelm
	name = "necra helmet (+steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/necrahelm
	craftdiff = 2

/datum/anvil_recipe/armor/nochelm
	name = "noc helmet (+steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/nochelm
	craftdiff = 2

/datum/anvil_recipe/armor/dendorhelm
	name = "dendor helmet (+steel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/roguetown/helmet/heavy/dendorhelm
	craftdiff = 2
