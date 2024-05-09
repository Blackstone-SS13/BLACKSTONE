
/mob/proc/show_triumphs_list()
	return SStriumphs.triumph_leaderboard(src.client)

/mob/proc/get_triumphs()
	if(!ckey)
		return
	return SStriumphs.get_triumphs(ckey)




/client/proc/adjusttriumph()
	set category = "GameMaster"
	set name = "Adjust Triumphs"
	var/input = input(src, "how much") as num
	if(mob && input)
		mob.adjust_triumphs(input)

/*
	Ye olde helpers below, to note you can put anything into the json_key
	Previously it was just client key for a pretty leaderboard now it is client ckey
*/

/datum/controller/subsystem/triumphs/proc/triumph_adjust_old(amt, json_key)
	var/curtriumphs = 0
	var/json_file = file(triumphs_json_path)
	if(!fexists(json_file))
		WRITE_FILE(json_file, "{}")
	var/list/json = json_decode(file2text(json_file))

	if(json[json_key])
		curtriumphs = json[json_key]
	curtriumphs += amt

	json[json_key] = curtriumphs

	fdel(json_file)
	WRITE_FILE(json_file, json_encode(json))

/datum/controller/subsystem/triumphs/proc/wipe_triumphs_old(json_key)
	var/json_file = file(triumphs_json_path)
	if(fexists(json_file))
		fdel(json_file)

	var/list/json = list()

	if(json_key)
		json[json_key] = 1

	WRITE_FILE(json_file, json_encode(json))

/datum/controller/subsystem/triumphs/proc/get_triumphs_old(json_key)
	var/json_file = file(triumphs_json_path)
	if(!fexists(json_file))
		return 0
	var/list/json = json_decode(file2text(json_file))

	if(json[json_key])
		return json[json_key]
	else
		triumph_adjust(0, json_key)
	return 0



