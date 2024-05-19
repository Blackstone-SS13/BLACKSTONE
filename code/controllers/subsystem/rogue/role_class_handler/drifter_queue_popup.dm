/*
	I be fr, the preferences datum file is colossal so I might as well put the popup gen proc near its daddy
*/

/datum/preferences/proc/Drifter_queue_popup(mob/user)
	var/list/dat = list()


	dat += "<body>"
	dat += "<center><a href='?_src_=prefs;preference=antag;task=close'>Close window</a></center><br>"

	var/time_remaining = SSticker.GetTimeLeft()
	if(time_remaining > 0)
		dat += "Time To Start: [round(time_remaining/10)]s<br>"
	else if(time_remaining == -10)
		dat += "Time To Start: DELAYED<br>"
	else
		dat += "Time To Start: SOON<br>"
	
	dat += "Drifta queue nigga"
	//dat += "<b>[capitalize(i)]:</b> <a href='?_src_=prefs;preference=antag;task=be_special;be_special_type=[i]'>[(i in be_special) ? "Enabled" : "Disabled"]</a><br>"


	dat += "</body>"

	var/datum/browser/popup = new(user, "drifter_queue", "<div align='center'>Drifter Queue</div>", 250, 300) //no reason not to reuse the occupation window, as it's cleaner that way
	popup.set_window_options("can_close=0")
	popup.set_content(dat.Join())
	popup.open(FALSE)
