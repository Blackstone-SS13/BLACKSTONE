/* To be added for later, MAGNUM Request - Sark

/obj/effect/proc_holder/spell/general/blindness
    name = "Blindness"
    overlay_state = "blindness"
    releasedrain = 30
    chargedrain = 0
    chargetime = 0
    range = 15
    warnie = "sydwarning"
    movement_interrupt = FALSE
    sound = 'sound/magic/churn.ogg'
    invocation = "Darkness guards me!"
    invocation_type = "shout" //can be none, whisper, emote and shout
    associated_skill = /datum/skill/magic/general
    antimagic_allowed = TRUE
    charge_max = 15 SECONDS
    devotion_cost = -30

/obj/effect/proc_holder/spell/invoked/blindness/cast(list/targets, mob/user = usr)
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		target.visible_message("<span class='warning'>[target] has summoned darkness!</span>","<span class='notice'>My eyes were covered in darkness!</span>")		
		if(target.anti_magic_check(TRUE, TRUE))
			return FALSE
		target.blind_eyes(2)
		user.visible_message("<font color='gray'>[user] points at [target]!</font>")
	return TRUE

*/
