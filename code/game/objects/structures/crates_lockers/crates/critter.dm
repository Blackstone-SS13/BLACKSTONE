/obj/structure/closet/crate/critter
	name = "critter crate"
	desc = ""
	icon_state = "crittercrate"
	horizontal = FALSE
	allow_objects = FALSE
	breakout_time = 600
	material_drop_amount = 4
	delivery_icon = "deliverybox"
	open_sound = 'sound/blank.ogg'
	close_sound = 'sound/blank.ogg'
	open_sound_volume = 25
	close_sound_volume = 50
	var/obj/item/tank/internals/emergency_oxygen/tank

/obj/structure/closet/crate/critter/Initialize()
	. = ..()
	tank = new

/obj/structure/closet/crate/critter/Destroy()
	var/turf/T = get_turf(src)
	if(tank)
		tank.forceMove(T)
		tank = null

	return ..()

/obj/structure/closet/crate/critter/update_icon()
	cut_overlays()
	if(opened)
		add_overlay("crittercrate_door_open")
	else
		add_overlay("crittercrate_door")
		if(manifest)
			add_overlay("manifest")

/obj/structure/closet/crate/critter/return_air()
	if(tank)
		return tank.air_contents
	else
		return loc.return_air()

/obj/structure/closet/crate/critter/return_analyzable_air()
	if(tank)
		return tank.return_analyzable_air()
	else
		return null
