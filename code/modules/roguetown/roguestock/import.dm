/datum/roguestock/import
	import_only = TRUE
	stable_price = TRUE

/datum/roguestock/import/crackers
	name = "Bin of Rations"
	desc = "Low moisture bread that keeps well."
	item_type = /obj/item/roguebin/crackers
	export_price = 100
	importexport_amt = 1

/obj/item/roguebin/crackers/Initialize()
	. = ..()
	new /obj/item/reagent_containers/food/snacks/rogue/crackerscooked(src)
	new /obj/item/reagent_containers/food/snacks/rogue/crackerscooked(src)
	new /obj/item/reagent_containers/food/snacks/rogue/crackerscooked(src)
	new /obj/item/reagent_containers/food/snacks/rogue/crackerscooked(src)
	new /obj/item/reagent_containers/food/snacks/rogue/crackerscooked(src)
	new /obj/item/reagent_containers/food/snacks/rogue/crackerscooked(src)
	new /obj/item/reagent_containers/food/snacks/rogue/crackerscooked(src)
	new /obj/item/reagent_containers/food/snacks/rogue/crackerscooked(src)
	new /obj/item/reagent_containers/food/snacks/rogue/crackerscooked(src)
	new /obj/item/reagent_containers/food/snacks/rogue/crackerscooked(src)

/obj/structure/closet/crate/chest/steward
	lockid = "steward"
	locked = TRUE
	masterkey = TRUE

/datum/roguestock/import/bogguard
	name = "Bog Guard Equipment Crate"
	desc = "Starting kit for a new Bog Guard."
	item_type = /obj/structure/closet/crate/chest/steward/bogguard
	export_price = 50
	importexport_amt = 1

/obj/structure/closet/crate/chest/steward/bogguard/Initialize()
	. = ..()
	new /obj/item/clothing/cloak/stabard/bog(src)
	new /obj/item/keyring/watchmen(src)
	new /obj/item/clothing/suit/roguetown/armor/gambeson(src)
	new /obj/item/rogueweapon/mace/cudgel(src)
	new /obj/item/rope/chain(src)
	
/datum/roguestock/import/watchmen
	name = "Watchmen Equipment Crate"
	desc = "Starting kit for a new Watchmen"
	item_type = /obj/structure/closet/crate/chest/steward/watchmen
	export_price = 50
	importexport_amt = 1

/obj/structure/closet/crate/chest/steward/watchmen/Initialize()
	. = ..()
	new /obj/item/clothing/cloak/stabard/guard(src)
	new /obj/item/keyring/guard(src)
	new /obj/item/clothing/suit/roguetown/armor/gambeson(src)
	new /obj/item/rogueweapon/mace/cudgel(src)
	new /obj/item/rope/chain(src)

/datum/roguestock/import/redpotion
	name = "Crate of Health Potions"
	desc = "Red that keeps men alive."
	item_type = /obj/structure/closet/crate/chest/steward/redpotion
	export_price = 100
	importexport_amt = 1

/obj/structure/closet/crate/chest/steward/redpotion/Initialize()
	. = ..()
	new /obj/item/reagent_containers/glass/bottle/rogue/healthpot(src)
	new /obj/item/reagent_containers/glass/bottle/rogue/healthpot(src)
	new /obj/item/reagent_containers/glass/bottle/rogue/healthpot(src)
	new /obj/item/reagent_containers/glass/bottle/rogue/healthpot(src)
	new /obj/item/reagent_containers/glass/bottle/rogue/healthpot(src)
