
/obj/item/roguegem
	name = "rontz"
	icon_state = "ruby_cut"
	icon = 'icons/roguetown/items/gems.dmi'
	desc = "Its facets shine so brightly.."
	lefthand_file = 'icons/mob/inhands/misc/food_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/food_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_MOUTH
	dropshrink = 0.4
	drop_sound = 'sound/items/gem.ogg'
	sellprice = 100
	static_price = FALSE

/obj/item/roguegem/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.4,"sx" = -1,"sy" = 0,"nx" = 11,"ny" = 1,"wx" = 0,"wy" = 1,"ex" = 4,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 15,"sturn" = 0,"wturn" = 0,"eturn" = 39,"nflip" = 8,"sflip" = 0,"wflip" = 0,"eflip" = 8)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/roguegem/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	playsound(loc, pick('sound/items/gems (1).ogg','sound/items/gems (2).ogg'), 100, TRUE, -2)
	..()

/obj/item/roguegem/green
	name = "gemerald"
	icon_state = "emerald_cut"
	sellprice = 22
	desc = "Glints with verdant brilliance."

/obj/item/roguegem/blue
	name = "blortz"
	icon_state = "quartz_cut"
	sellprice = 88
	desc = "White, like a frozen tear." // i am not sure if this is really quartz.

/obj/item/roguegem/yellow
	name = "toper"
	icon_state = "topaz_cut"
	sellprice = 14
	desc = "Its amber hues remind you of the sunset."

/obj/item/roguegem/violet
	name = "saffira"
	icon_state = "sapphire_cut"
	sellprice = 56
	desc = "This gem is admired by many wizards."


/// riddle


/obj/item/riddleofsteel
	name = "riddle of steel"
	icon_state = "ros"
	icon = 'icons/roguetown/items/gems.dmi'
	desc = "Flesh, mind."
	lefthand_file = 'icons/mob/inhands/misc/food_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/food_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_MOUTH
	dropshrink = 0.4
	drop_sound = 'sound/items/gem.ogg'
	sellprice = 554

/obj/item/riddleofsteel/Initialize()
	..()
	set_light(2, 1, "#ff0d0d")