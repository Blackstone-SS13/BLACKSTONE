

/obj/item/clothing/ring
	name = "ring"
	desc = ""
	w_class = WEIGHT_CLASS_TINY
	icon = 'icons/roguetown/clothing/rings.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/rings.dmi'
	sleeved = 'icons/roguetown/clothing/onmob/rings.dmi'
	sleevetype = "shirt"
	icon_state = ""
	slot_flags = ITEM_SLOT_RING
	resistance_flags = FIRE_PROOF | ACID_PROOF
	anvilrepair = /datum/skill/craft/armorsmithing

/obj/item/clothing/ring/silver
	name = "silver ring"
	icon_state = "ring_s"
	sellprice = 33

/obj/item/clothing/ring/gold
	name = "gold ring"
	icon_state = "ring_g"
	sellprice = 45

/obj/item/clothing/ring/active
	var/active = FALSE
	desc = "Unfortunately, like most magic rings, it must be used sparingly. (Right-click me to activate)"
	var/cooldowny
	var/cdtime
	var/activetime
	var/activate_sound

/obj/item/clothing/ring/active/attack_right(mob/user)
	if(loc != user)
		return
	if(cooldowny)
		if(world.time < cooldowny + cdtime)
			to_chat(user, "<span class='warning'>Nothing happens.</span>")
			return
	user.visible_message("<span class='warning'>[user] twists the [src]!</span>")
	if(activate_sound)
		playsound(user, activate_sound, 100, FALSE, -1)
	cooldowny = world.time
	addtimer(CALLBACK(src, PROC_REF(demagicify)), activetime)
	active = TRUE
	update_icon()
	activate(user)

/obj/item/clothing/ring/active/proc/activate(mob/user)
	user.update_inv_wear_id()

/obj/item/clothing/ring/active/proc/demagicify()
	active = FALSE
	update_icon()
	if(ismob(loc))
		var/mob/user = loc
		user.visible_message("<span class='warning'>The ring settles down.</span>")
		user.update_inv_wear_id()


/obj/item/clothing/ring/active/nomag
	name = "ring of null magic"
	icon_state = "ruby"
	activate_sound = 'sound/magic/antimagic.ogg'
	cdtime = 10 MINUTES
	activetime = 30 SECONDS
	sellprice = 100

/obj/item/clothing/ring/active/nomag/update_icon()
	..()
	if(active)
		icon_state = "rubyactive"
	else
		icon_state = "ruby"

/obj/item/clothing/ring/active/nomag/activate(mob/user)
	. = ..()
	AddComponent(/datum/component/anti_magic, TRUE, FALSE, FALSE, ITEM_SLOT_RING, INFINITY, FALSE)

/obj/item/clothing/ring/active/nomag/demagicify()
	. = ..()
	var/datum/component/magcom = GetComponent(/datum/component/anti_magic)
	if(magcom)
		magcom.RemoveComponent()

//gold rings
/obj/item/clothing/ring/emerald
    name = "gemerald ring"
    icon_state = "g_ring_emerald"
    sellprice = 195

/obj/item/clothing/ring/ruby
    name = "rontz ring"
    icon_state = "g_ring_ruby"
    sellprice = 255

/obj/item/clothing/ring/topaz
    name = "toper ring"
    icon_state = "g_ring_topaz"
    sellprice = 180

/obj/item/clothing/ring/quartz
    name = "blortz ring"
    icon_state = "g_ring_quartz"
    sellprice = 245

/obj/item/clothing/ring/sapphire
    name = "saffira ring"
    icon_state = "g_ring_sapphire"
    sellprice = 200

/obj/item/clothing/ring/diamond
    name = "dorpel ring"
    icon_state = "g_ring_diamond"
    sellprice = 270

//steel rings
/obj/item/clothing/ring/emeralds
    name = "gemerald ring"
    icon_state = "s_ring_emerald"
    sellprice = 80

/obj/item/clothing/ring/rubys
    name = "rontz ring"
    icon_state = "s_ring_ruby"
    sellprice = 130

/obj/item/clothing/ring/topazs
    name = "toper ring"
    icon_state = "s_ring_topaz"
    sellprice = 65

/obj/item/clothing/ring/quartzs
    name = "blortz ring"
    icon_state = "s_ring_quartz"
    sellprice = 110

/obj/item/clothing/ring/sapphires
    name = "saffira ring"
    icon_state = "s_ring_sapphire"
    sellprice = 95

/obj/item/clothing/ring/diamonds
    name = "dorpel ring"
    icon_state = "s_ring_diamond"
    sellprice = 140
