/turf/open/floor/plasteel/maniac
	icon = 'icons/roguetown/maniac/dreamer_floors.dmi'
	icon_state = "polar"
	broken_states = list("ldamaged1", "ldamaged2", "ldamaged3", "ldamaged4")
	burnt_states = list("lscorched1", "lscorched2")

/turf/open/floor/plasteel/maniac/damaged
	icon_state = "ldamaged1"

/turf/open/floor/plasteel/maniac/damaged/Initialize(mapload)
	. = ..()
	break_tile()
