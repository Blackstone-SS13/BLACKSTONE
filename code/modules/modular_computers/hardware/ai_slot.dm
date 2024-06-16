/obj/item/computer_hardware/ai_slot
	name = "intelliCard interface slot"
	desc = ""
	power_usage = 100 //W
	icon_state = "card_mini"
	w_class = WEIGHT_CLASS_SMALL
	device_type = MC_AI

	var/obj/item/aicard/stored_card = null
	var/locked = FALSE

/obj/item/computer_hardware/ai_slot/handle_atom_del(atom/A)
	if(A == stored_card)
		try_eject(0, null, TRUE)
	. = ..()

/obj/item/computer_hardware/ai_slot/examine(mob/user)
	. = ..()
	if(stored_card)
		. += "There appears to be an intelliCard loaded. There appears to be a pinhole protecting a manual eject button. A screwdriver could probably press it."

/obj/item/computer_hardware/ai_slot/on_install(obj/item/modular_computer/M, mob/living/user = null)
	M.add_verb(device_type)

/obj/item/computer_hardware/ai_slot/on_remove(obj/item/modular_computer/M, mob/living/user = null)
	M.remove_verb(device_type)

/obj/item/computer_hardware/ai_slot/try_insert(obj/item/I, mob/living/user = null)
	if(!holder)
		return FALSE

	if(!istype(I, /obj/item/aicard))
		return FALSE

	if(stored_card)
		to_chat(user, span_warning("I try to insert \the [I] into \the [src], but the slot is occupied."))
		return FALSE
	if(user && !user.transferItemToLoc(I, src))
		return FALSE

	stored_card = I
	to_chat(user, span_notice("I insert \the [I] into \the [src]."))

	return TRUE


/obj/item/computer_hardware/ai_slot/try_eject(slot=0,mob/living/user = null,forced = 0)
	if(!stored_card)
		to_chat(user, span_warning("There is no card in \the [src]."))
		return FALSE

	if(locked && !forced)
		to_chat(user, span_warning("Safeties prevent you from removing the card until reconstruction is complete..."))
		return FALSE

	if(stored_card)
		to_chat(user, span_notice("I remove [stored_card] from [src]."))
		locked = FALSE
		if(user)
			user.put_in_hands(stored_card)
		else
			stored_card.forceMove(drop_location())
		stored_card = null

		return TRUE
	return FALSE

/obj/item/computer_hardware/ai_slot/attackby(obj/item/I, mob/living/user)
	if(..())
		return
	if(I.tool_behaviour == TOOL_SCREWDRIVER)
		to_chat(user, span_notice("I press down on the manual eject button with \the [I]."))
		try_eject(,user,1)
		return
