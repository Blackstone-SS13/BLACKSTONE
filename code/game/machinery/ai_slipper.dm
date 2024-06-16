/obj/machinery/ai_slipper
	name = "foam dispenser"
	desc = ""
	icon = 'icons/obj/device.dmi'
	icon_state = "ai-slipper0"
	layer = PROJECTILE_HIT_THRESHHOLD_LAYER
	plane = FLOOR_PLANE
	max_integrity = 200
	armor = list("blunt" = 50, "slash" = 40, "stab" = 20, "bullet" = 20, "laser" = 20, "energy" = 20, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 30)

	var/uses = 20
	var/cooldown = 0
	var/cooldown_time = 100
	req_access = list(ACCESS_AI_UPLOAD)

/obj/machinery/ai_slipper/examine(mob/user)
	. = ..()
	. += span_notice("It has <b>[uses]</b> uses of foam remaining.")

/obj/machinery/ai_slipper/update_icon_state()
	if(stat & BROKEN)
		return
	if((stat & NOPOWER) || cooldown_time > world.time || !uses)
		icon_state = "ai-slipper0"
	else
		icon_state = "ai-slipper1"

/obj/machinery/ai_slipper/interact(mob/user)
	if(!allowed(user))
		to_chat(user, span_danger("Access denied."))
		return
	if(!uses)
		to_chat(user, span_warning("[src] is out of foam and cannot be activated!"))
		return
	if(cooldown_time > world.time)
		to_chat(user, span_warning("[src] cannot be activated for <b>[DisplayTimeText(world.time - cooldown_time)]</b>!"))
		return
	new /obj/effect/particle_effect/foam(loc)
	uses--
	to_chat(user, span_notice("I activate [src]. It now has <b>[uses]</b> uses of foam remaining."))
	cooldown = world.time + cooldown_time
	power_change()
	addtimer(CALLBACK(src, PROC_REF(power_change)), cooldown_time)
