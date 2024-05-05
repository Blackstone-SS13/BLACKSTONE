/mob/proc/adjust_triumphs(amt, counted = TRUE)
	if(!key)
		return
	else
		SStriumphs.triumph_adjust(amt, key)
	if(amt > 0)
		if(counted)
			SSticker.tri_gained += amt
		to_chat(src, "\n<font color='purple'>[amt] TRIUMPH(S) awarded.</font>")
	else if(amt < 0)
		if(counted)
			SSticker.tri_lost += amt
		to_chat(src, "\n<font color='purple'>[amt*-1] TRIUMPH(S) lost.</font>")

/client/proc/adjust_triumphs(amt, counted = TRUE)
	if(!key)
		return
	else
		SStriumphs.triumph_adjust(amt, key)

	if(amt > 0)
		if(counted)
			SSticker.tri_gained += amt
		to_chat(src, "\n<font color='purple'>[amt] TRIUMPH(S) awarded.</font>")
	else if(amt < 0)
		if(counted)
			SSticker.tri_lost += amt
		to_chat(src, "\n<font color='purple'>[amt*-1] TRIUMPH(S) lost.</font>")



/datum/mind/proc/adjust_triumphs(amt, counted = TRUE)
	if(!key)
		return
	else
		SStriumphs.triumph_adjust(amt, key)
	if(amt > 0)
		if(counted)
			SSticker.tri_gained += amt
		if(current)
			to_chat(current, "\n<font color='purple'>[amt] TRIUMPH(S) awarded.</font>")
	else if(amt < 0)
		if(counted)
			SSticker.tri_lost += amt
		if(current)
			to_chat(current, "\n<font color='purple'>[amt*-1] TRIUMPH(S) lost.</font>")

/mob/proc/show_triumphs_list()
	return SStriumphs.triumph_leaderboard(src)

/mob/proc/get_triumphs()
	if(!key)
		return
	return SStriumphs.get_triumphs(key)


/client/proc/adjusttriumph()
	set category = "GameMaster"
	set name = "Adjust Triumphs"
	var/input = input(src, "how much") as num
	if(mob && input)
		mob.adjust_triumphs(input)
