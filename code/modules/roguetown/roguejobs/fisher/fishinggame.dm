/atom/movable/fishingoverlay //all of the code is handled in the fishing rod item, this is just for the ui elements
	name = null
	icon = 'icons/roguetown/hud/fishingmeme.dmi'
	screen_loc = "CENTER:-16,CENTER:-16"
	appearance_flags = PIXEL_SCALE
	plane = ABOVE_LIGHTING_LAYER
	layer = ABOVE_LIGHTING_LAYER

/atom/movable/fishingoverlay/base
	icon_state = "fishingbase"

/atom/movable/fishingoverlay/pointer1
	icon_state = "reelstate"

/atom/movable/fishingoverlay/pointer2
	icon_state = "fishstate"
