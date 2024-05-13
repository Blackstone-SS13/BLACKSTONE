/mob/verb/pray(msg as text)
	set category = "IC"
	set name = "Pray"
	set hidden = 1
	if(!usr.client.holder)
		return

	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, "<span class='danger'>Speech is currently admin-disabled.</span>")
		return

	msg = copytext(sanitize(msg), 1, MAX_MESSAGE_LEN)
	if(!msg)
		return
	log_prayer("[src.key]/([src.name]): [msg]")
//	if(usr.client)
//		if(usr.client.prefs.muted & MUTE_PRAY)
//			to_chat(usr, "<span class='danger'>I cannot pray (muted).</span>")
//			return
//		if(src.client.handle_spam_prevention(msg,MUTE_PRAY))
//			return

	var/mutable_appearance/cross = mutable_appearance('icons/obj/storage.dmi', "bible")
	var/font_color = "purple"
	var/prayer_type = "PRAYER"
	var/deity
	if(ishuman(src))
		var/mob/living/carbon/human/human_user = src
		deity = human_user.patron.name
	if(usr.job == "Chaplain")
		cross.icon_state = "kingyellow"
		font_color = "blue"
		prayer_type = "CHAPLAIN PRAYER"
		if(GLOB.deity)
			deity = GLOB.deity
	else if(iscultist(usr))
		cross.icon_state = "tome"
		font_color = "red"
		prayer_type = "CULTIST PRAYER"
		deity = "Nar'Sie"
	else if(isliving(usr))
		var/mob/living/L = usr
		if(HAS_TRAIT(L, TRAIT_SPIRITUAL))
			cross.icon_state = "holylight"
			font_color = "blue"
			prayer_type = "SPIRITUAL PRAYER"

	var/msg_tmp = msg
	msg = "<span class='adminnotice'>[icon2html(cross, GLOB.admins)]<b><font color=[font_color]>[prayer_type][deity ? " (to [deity])" : ""]: </font>[ADMIN_FULLMONTY(src)] [ADMIN_SC(src)]:</b> <span class='linkify'>[msg]</span></span>"
	for(var/client/C in GLOB.admins)
		if(C.prefs.chat_toggles & CHAT_PRAYER)
			to_chat(C, msg)
			if(C.prefs.toggles & SOUND_PRAYERS)
				if(usr.job == "Priest")
					SEND_SOUND(C, sound('sound/pray.ogg'))

	for(var/mob/M in GLOB.dead_mob_list)
		if(!M.client)
			continue
//		var/T = get_turf(src)
		if(M.stat == DEAD)
			var/client/J = M.client
			to_chat(J, msg)

	to_chat(usr, "<span class='info'>I pray to the gods: \"[msg_tmp]\"</span>")

	SSblackbox.record_feedback("tally", "admin_verb", 1, "Prayer") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	//log_admin("HELP: [key_name(src)]: [msg]")
	var/datum/antagonist/maniac/maniac = mind?.has_antag_datum(/datum/antagonist/maniac)
	if(maniac && (text2num(msg_tmp) == maniac.sum_keys))
		maniac.wake_up()

/proc/CentCom_announce(text , mob/Sender)
	var/msg = copytext(sanitize(text), 1, MAX_MESSAGE_LEN)
	msg = "<span class='adminnotice'><b><font color=orange>CENTCOM:</font>[ADMIN_FULLMONTY(Sender)] [ADMIN_CENTCOM_REPLY(Sender)]:</b> [msg]</span>"
	to_chat(GLOB.admins, msg)
	for(var/obj/machinery/computer/communications/C in GLOB.machines)
		C.overrideCooldown()

/proc/Syndicate_announce(text , mob/Sender)
	var/msg = copytext(sanitize(text), 1, MAX_MESSAGE_LEN)
	msg = "<span class='adminnotice'><b><font color=crimson>SYNDICATE:</font>[ADMIN_FULLMONTY(Sender)] [ADMIN_SYNDICATE_REPLY(Sender)]:</b> [msg]</span>"
	to_chat(GLOB.admins, msg)
	for(var/obj/machinery/computer/communications/C in GLOB.machines)
		C.overrideCooldown()

/proc/Nuke_request(text , mob/Sender)
	var/msg = copytext(sanitize(text), 1, MAX_MESSAGE_LEN)
	msg = "<span class='adminnotice'><b><font color=orange>NUKE CODE REQUEST:</font>[ADMIN_FULLMONTY(Sender)] [ADMIN_CENTCOM_REPLY(Sender)] [ADMIN_SET_SD_CODE]:</b> [msg]</span>"
	to_chat(GLOB.admins, msg)
	for(var/obj/machinery/computer/communications/C in GLOB.machines)
		C.overrideCooldown()

/mob/proc/roguepray(msg as text)
//	set category = "IC"
//	set name = "Pray"
//	set hidden = 1
//	if(!usr.client.holder)
//		return
//
	msg = copytext(sanitize(msg), 1, MAX_MESSAGE_LEN)
	if(!msg)
		return
	log_prayer("[src.key]/([src.name]): [msg]")

	var/deity = ""
	if(isliving(src))
		var/mob/living/living_user = src
		if(istype(living_user.patron))
			deity = " to [living_user.patron.name]"

	var/datum/antagonist/maniac/maniac = mind?.has_antag_datum(/datum/antagonist/maniac)
	if(maniac)
		if(text2num(msg) == maniac.sum_keys)
			deity = " to THE GODHEAD"
			INVOKE_ASYNC(maniac, TYPE_PROC_REF(/datum/antagonist/maniac, wake_up))
		else
			var/datum/patron/zizo = GLOB.patronlist[/datum/patron/inhumen/zizo]
			deity = " to [zizo.name]"
	
	var/display_name = "[real_name || src.name]"

	msg = "<span class='info'>[display_name] prays[deity] [ADMIN_FLW(src)][ADMIN_SM(src)]: [msg]</span>"
	
	for(var/client/janny in GLOB.admins)
		if(janny.prefs.chat_toggles & CHAT_PRAYER)
			to_chat(janny, msg)
			if(janny.prefs.toggles & SOUND_PRAYERS)
				SEND_SOUND(janny, sound('sound/pray.ogg'))

/mob/proc/schizohelp(msg as text)
	if(!msg)
		return
	msg = copytext(sanitize(msg), 1, MAX_MESSAGE_LEN)
	if(!msg)
		return

	var/display_name = get_schizo_name()
	var/message = "<span class='info'>[display_name] meditates...\n[msg]</span>"
	var/message_admins = "<span class='info'>[display_name] ([real_name || src.name]) [ADMIN_FLW(src)] [ADMIN_SM(src)] meditates...\n[msg]</span>"
	for(var/client/voice in GLOB.clients)
		if(!(client.prefs.toggles & SCHIZO_VOICE) || check_rights_for(voice, R_ADMIN))
			continue
		var/answer_button = "<span class='info'>(<a href='?src=[voice];schizohelp=[REF(src)];'>ANSWER</a>)</span>"
		to_chat(voice, "[message] [answer_button]")

	for(var/client/admin in GLOB.admins)
		if(!(admin.prefs.chat_toggles & CHAT_PRAYER))
			continue
		var/answer_button = "<span class='info'>(<a href='?src=[admin];schizohelp=[REF(src)];'>ANSWER</a>)</span>"
		to_chat(admin, "[message_admins] [answer_button]")

/mob/proc/get_schizo_name()
	var/static/list/possible_adjectives = list(
		"Indecisive",
		"Doubtful",
		"Confused",
		"Hysteric",
	)
	var/static/list/possible_nouns = list(
		"Fool",
		"Madman",
		"Nimrod",
		"Lunatic",
		"Imbecile",
	)
	/// generate a consistent but anonymous name
	var/static/fumbling_seed = text2num(GLOB.rogue_round_id)
	var/md5_num = text2num(md5(real_name || src.name))
	var/adjective = possible_adjectives[(md5_num % length(possible_adjectives)) + 1]
	var/noun = possible_nouns[(round(md5_num * noise_hash(md5_num, fumbling_seed)) % length(possible_nouns)) + 1]
	return "[adjective] [noun]"

/client/proc/answer_schizo(mob/schizo)
	if(!schizo)
		return
	var/answer = input("Answer their meditations...", "VOICE")
	if(!answer)
		return
	to_chat(schizo, "<i>I hear a voice in my head... <b>[answer]</i></b>")
	var/mob_name = mob.real_name || mob.name
	for(var/client/admin in GLOB.admins)
		if(!(admin.prefs.chat_toggles & CHAT_PRAYER))
			continue
		to_chat(admin, "<span class='info'>[mob_name] [ADMIN_FLW(mob)] [ADMIN_SM(mob)] answered [schizo]'s [ADMIN_FLW(schizo)] [ADMIN_SM(schizo)] meditation: [answer]</span>")
