
/obj/item/natural/feather
	name = "feather"
	icon_state = "feather"
	possible_item_intents = list(/datum/intent/use)
	desc = "A fluffy feather."
	force = 0
	throwforce = 0
	obj_flags = null
	firefuel = null
	resistance_flags = FLAMMABLE
	slot_flags = ITEM_SLOT_MOUTH|ITEM_SLOT_HEAD|ITEM_SLOT_HIP
	body_parts_covered = null
	experimental_onhip = TRUE
	max_integrity = 20
	muteinmouth = TRUE
	spitoutmouth = FALSE
	w_class = WEIGHT_CLASS_TINY

/obj/item/natural/feather/magic
	name = "magic feather"
	color = "#ffee00"
	desc = "A fluffy feather that seems to shimmer with a faint magical aura."
	var/uses = 0
	var/max_uses = 3 // TODO: Balance this
	