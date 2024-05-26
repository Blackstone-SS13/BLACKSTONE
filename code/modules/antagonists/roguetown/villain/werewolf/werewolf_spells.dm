/obj/effect/proc_holder/spell/self/howl
	name = "Howl"
	desc = "!"
	overlay_state = "howl"
	antimagic_allowed = TRUE
	charge_max = 600 //1 minute

/obj/effect/proc_holder/spell/self/howl/cast(mob/user = usr)
	..()
	var/message = input("Howl at the hidden moon", "WEREWOLF") as text|null
	if(!message) return

	var/datum/antagonist/werewolf/werewolf_player = user.mind.has_antag_datum(/datum/antagonist/werewolf)

	// sound played for owner
	playsound(src, pick('sound/vo/mobs/wwolf/howl (1).ogg','sound/vo/mobs/wwolf/howl (2).ogg'), 100, TRUE)
	
	for(var/mob/player in GLOB.player_list)

		if(!player.mind) continue
		if(player.stat == DEAD) continue
		if(isbrain(player)) continue

		// Announcement to other werewolves
		if(player.mind.has_antag_datum(/datum/antagonist/werewolf))
			to_chat(player, "<span class='boldannounce'>[werewolf_player.wolfname] howls: [message]</span>")

		//sound played for other players
		if(player == src) continue
		if(get_dist(player, src) > 7)
			player.playsound_local(get_turf(player), pick('sound/vo/mobs/wwolf/howldist (1).ogg','sound/vo/mobs/wwolf/howldist (2).ogg'), 100, FALSE, pressure_affected = FALSE)

/obj/effect/proc_holder/spell/self/claws
	name = "Extend claws"
	desc = "!"
	overlay_state = "claws"
	antimagic_allowed = TRUE
	charge_max = 20 //2 seconds
	var/extended = FALSE

/obj/effect/proc_holder/spell/self/claws/cast(mob/user = usr)
	..()
	var/obj/item/rogueweapon/werewolf_claw/claw1
	var/obj/item/rogueweapon/werewolf_claw/claw2

	claw1 = user.get_active_held_item()
	claw2 = user.get_inactive_held_item()
	if(extended)
		if(istype(user.get_active_held_item(), /obj/item/rogueweapon/werewolf_claw))
			user.dropItemToGround(claw1, TRUE)
			user.dropItemToGround(claw2, TRUE)
			qdel(claw1)
			qdel(claw2)
			user.visible_message("Your claws retract.", "Your claws retract.", "You hear a sound of claws retracting.")
			extended = FALSE
	else
		claw1 = new(user,1)
		claw2 = new(user,2)
		user.put_in_hands(claw1, TRUE, FALSE, TRUE)
		user.put_in_hands(claw2, TRUE, FALSE, TRUE)
		user.visible_message("Your claws extend.", "Your claws extend.", "You hear a sound of claws extending.")
		extended = TRUE
	