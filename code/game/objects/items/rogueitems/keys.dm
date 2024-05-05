
/obj/item/roguekey
	name = "key"
	desc = "An unremarkable iron key."
	icon_state = "iron"
	icon = 'icons/roguetown/items/keys.dmi'
	lefthand_file = 'icons/mob/inhands/misc/food_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/food_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	dropshrink = 0.75
	throwforce = 0
	var/lockhash = 0
	var/lockid = null
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_MOUTH|ITEM_SLOT_NECK

/obj/item/roguekey/Initialize()
	. = ..()
	if(lockid)
		if(GLOB.lockids[lockid])
			lockhash = GLOB.lockids[lockid]
		else
			lockhash = rand(100,999)
			while(lockhash in GLOB.lockhashes)
				lockhash = rand(100,999)
			GLOB.lockhashes += lockhash
			GLOB.lockids[lockid] = lockhash
	else if(!lockhash)
		qdel(src)

/obj/item/roguekey/lord
	name = "master key"
	desc = "The Lord's key."
	icon_state = "bosskey"
	lockid = "lord"

/obj/item/roguekey/lord/pre_attack(target, user, params)
	. = ..()
	if(istype(target, /obj/structure/closet))
		var/obj/structure/closet/C = target
		if(C.masterkey)
			lockhash = C.lockhash
	if(istype(target, /obj/structure/mineral_door))
		var/obj/structure/mineral_door/D = target
		if(D.masterkey)
			lockhash = D.lockhash


/obj/item/roguekey/manor
	name = "manor key"
	desc = "This key will open any manor doors."
	icon_state = "mazekey"
	lockid = "manor"

/obj/item/roguekey/garrison
	name = "town watch key"
	desc = "This key belongs to the town guards."
	icon_state = "spikekey"
	lockid = "garrison"

/obj/item/roguekey/dungeon
	name = "dungeon key"
	desc = "This key should unlock the rusty bars and doors of the dungeon."
	icon_state = "rustkey"
	lockid = "dungeon"

/obj/item/roguekey/vault
	name = "vault key"
	desc = "This key opens the mighty vault."
	icon_state = "cheesekey"
	lockid = "vault"

/obj/item/roguekey/sheriff
	name = "sheriff's key"
	icon_state = "cheesekey"
	lockid = "sheriff"

/obj/item/roguekey/bailiff
	name = "bailiff's key"
	desc = "This key belongs to the town sheriff."
	icon_state = "cheesekey"
	lockid = "sheriff"

/obj/item/roguekey/merchant
	name = "merchant's key"
	desc = "A merchant's key."
	icon_state = "cheesekey"
	lockid = "merchant"

/obj/item/roguekey/shop
	name = "shop key"
	desc = "This key opens and closes a shop door."
	icon_state = "ekey"
	lockid = "shop"

/obj/item/roguekey/tavern
	name = "tavern key"
	desc = "This key should open and close any tavern door."
	icon_state = "hornkey"
	lockid = "tavern"

/obj/item/roguekey/velder
	name = "elder's key"
	desc = "This key should open and close the elder's home."
	icon_state = "brownkey"
	lockid = "velder"

/obj/item/roguekey/roomi
	name = "room I key"
	desc = "The key to the first room."
	icon_state = "brownkey"
	lockid = "roomi"

/obj/item/roguekey/roomii
	name = "room II key"
	desc = "The key to the second room."
	icon_state = "brownkey"
	lockid = "roomii"

/obj/item/roguekey/roomiii
	name = "room III key"
	desc = "The key to the third room."
	icon_state = "brownkey"
	lockid = "roomiii"

/obj/item/roguekey/roomiv
	name = "room IV key"
	desc = "The key to the fourth room."
	icon_state = "brownkey"
	lockid = "roomiv"

/obj/item/roguekey/roomv
	name = "room V key"
	desc = "The key to the fifth room."
	icon_state = "brownkey"
	lockid = "roomv"

/obj/item/roguekey/roomvi
	name = "room VI key"
	desc = "The key to the sixth room."
	icon_state = "brownkey"
	lockid = "roomvi"

/obj/item/roguekey/roomhunt
	name = "room HUNT key"
	desc = "This is the HUNT key!"
	icon_state = "brownkey"
	lockid = "roomhunt"

//vampire mansion//
/obj/item/roguekey/vampire
	name = "mansion key"
	desc = "The key to a vampire lord's castle."
	icon_state = "vampkey"
	lockid = "mansionvampire"
//

/obj/item/roguekey/blacksmith
	name = "blacksmith key"
	desc = "This key opens a blacksmith's workshop."
	icon_state = "brownkey"
	lockid = "blacksmith"

/obj/item/roguekey/blacksmith/town
	name = "town blacksmith key"
	lockid = "townblacksmith"

/obj/item/roguekey/walls
	name = "walls key"
	desc = "This is a rusty key."
	icon_state = "rustkey"
	lockid = "walls"

/obj/item/roguekey/farm
	name = "farm key"
	desc = "This is a rusty key that'll open farm doors."
	icon_state = "rustkey"
	lockid = "farm"

/obj/item/roguekey/butcher
	name = "butcher key"
	desc = "This is a rusty key that'll open butcher doors."
	icon_state = "rustkey"
	lockid = "butcher"

/obj/item/roguekey/church
	name = "church key"
	desc = "This bronze key should open almost all doors in the church."
	icon_state = "brownkey"
	lockid = "church"

/obj/item/roguekey/priest
	name = "priest's key"
	desc = "This is the master key of the church."
	icon_state = "cheesekey"
	lockid = "priest"

/obj/item/roguekey/tower
	name = "tower key"
	desc = "This key should open anything within the tower."
	icon_state = "greenkey"
	lockid = "tower"

/obj/item/roguekey/mage
	name = "magicians's key"
	desc = "This is the court wizard's key. It watches you..."
	icon_state = "eyekey"
	lockid = "mage"

/obj/item/roguekey/graveyard
	name = "crypt key"
	desc = "This rusty key belongs to the gravekeeper."
	icon_state = "rustkey"
	lockid = "graveyard"

/obj/item/roguekey/mason
	name = "mason's key"
	desc = "This bronze key should open the mason's guild."
	icon_state = "brownkey"
	lockid = "mason"

/obj/item/roguekey/nightman
	name = "nightmaster's key"
	desc = "This regal key opens a few doors within the castle."
	icon_state = "greenkey"
	lockid = "nightman"

/obj/item/roguekey/nightmaiden
	name = "nightmaiden's key"
	desc = "This regal key opens a few doors within the castle."
	icon_state = "brownkey"
	lockid = "nightmaiden"

/obj/item/roguekey/mercenary
	name = "mercenary key"
	desc = "Why, a mercenary would not kick doors down."
	icon_state = "greenkey"
	lockid = "merc"

/obj/item/roguekey/puritan
	name = "puritan's key"
	desc = "This is an intricate key." // i have no idea what is this key about
	icon_state = "mazekey"
	lockid = "puritan"

/obj/item/roguekey/confession
	name = "confessional key"
	desc = "This key opens the doors of the confessional."
	icon_state = "brownkey"
	lockid = "confession"

/obj/item/roguekey/hand
	name = "hand's key"
	desc = "This regal key belongs to the King's Right Hand."
	icon_state = "cheesekey"
	lockid = "hand"

/obj/item/roguekey/steward
	name = "steward's key"
	desc = "This key belongs to the court's greedy steward."
	icon_state = "cheesekey"
	lockid = "steward"

/obj/item/roguekey/archive
	name = "archive key"
	desc = "This key looks barely used."
	icon_state = "ekey"
	lockid = "archive"
//grenchensnacker
/obj/item/roguekey/porta
	name = "strange key"
	desc = "Was this key enchanted by a wizard locksmith..?"//what is grenchensnacker.
	icon_state = "eyekey"
	lockid = "porta"
