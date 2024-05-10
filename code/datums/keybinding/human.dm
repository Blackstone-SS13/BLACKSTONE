/datum/keybinding/human
	category = CATEGORY_HUMAN
	weight = WEIGHT_MOB

/*
/datum/keybinding/human/quick_equip
	hotkey_keys = list("E")
	name = "quick_equip"
	full_name = "Quick Equip"
	description = "Quickly puts an item in the best slot available"

/datum/keybinding/human/quick_equip/down(client/user)
	var/mob/living/carbon/human/H = user.mob
	H.quick_equip()
	return TRUE

/datum/keybinding/human/quick_equipbelt
	hotkey_keys = list("ShiftE")
	name = "quick_equipbelt"
	full_name = "Quick equip belt"
	description = "Put held thing in belt or take out most recent thing from belt"

/datum/keybinding/human/quick_equipbelt/down(client/user)
	var/mob/living/carbon/human/H = user.mob
	H.smart_equipbelt()
	return TRUE

/datum/keybinding/human/bag_equip
	hotkey_keys = list("ShiftB")
	name = "bag_equip"
	full_name = "Bag equip"
	description = "Put held thing in backpack or take out most recent thing from backpack"

/datum/keybinding/human/bag_equip/down(client/user)
	var/mob/living/carbon/human/H = user.mob
	H.smart_equipbag()
	return TRUE
*/

/datum/keybinding/human/fixeye
	hotkey_keys = list("F")
	name = "fix_eye"
	full_name = "Fixed Eye"
	description = "Focus in a direction."

/datum/keybinding/human/fixeye/down(client/user)
	var/mob/living/carbon/human/H = user.mob
	H.toggle_eye_intent(H)
	return TRUE

/datum/keybinding/human/looc // First, I laughed how blackstone had no RP. But it was just getting sad. So I'm adding this in.
	hotkey_keys = list("L")
	name = "looc"
	full_name = "Local OOC"
	description = "Finally communicate in a seperate channel without having to use IC chat for OOC stuff."

/datum/keybinding/human/looc/down(client/user)
	var/message = input(usr, "SPEAK YOUR VIEWS OF THE FABRIC", "ROGUETOWN")
	if(message)
		for(var/mob/living/L in view(7, user.mob))
			to_chat(L, "<LOOC> [user.mob.real_name]: [message]") // You're not getting colors.
