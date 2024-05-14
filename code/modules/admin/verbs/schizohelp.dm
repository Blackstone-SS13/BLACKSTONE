GLOBAL_LIST_EMPTY(schizohelps)

/mob
	COOLDOWN_DECLARE(schizohelp_cooldown)

/mob/proc/schizohelp(msg as text)
	if(!msg)
		return
	msg = copytext(sanitize(msg), 1, MAX_MESSAGE_LEN)
	if(!msg)
		return

	to_chat(src, "<span class='info'>You meditate...\n<i>[msg]</i></span>")
	var/datum/schizohelp/ticket = new(src)
	var/display_name = get_schizo_name()
	var/message = "<span class='info'>[display_name] meditates...\n<i>[msg]</i></span>"
	var/message_admins = "<span class='info'>[display_name] ([real_name || src.name]) [ADMIN_FLW(src)] [ADMIN_SM(src)] meditates...\n<i>[msg]</i></span>"
	for(var/client/voice in (GLOB.clients - client))
		if(!(client.prefs.toggles & SCHIZO_VOICE) || check_rights_for(voice, R_ADMIN))
			continue
		var/answer_button = "<span class='info'>(<a href='?src=[voice];schizohelp=[REF(ticket)];'>ANSWER</a>)</span>"
		to_chat(voice, "[message] [answer_button]")

	for(var/client/admin in GLOB.admins)
		if(!(admin.prefs.chat_toggles & CHAT_PRAYER))
			continue
		var/answer_button = "<span class='info'>(<a href='?src=[admin];schizohelp=[REF(ticket)];'>ANSWER</a>)</span>"
		to_chat(admin, "[message_admins] [answer_button]")
	COOLDOWN_START(src, schizohelp_cooldown, 1 MINUTES)

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

/client/proc/answer_schizohelp(datum/schizohelp/schizo)
	if(QDELETED(schizo))
		to_chat(src, "<span class='warning'>This meditation can no longer be answered...</span>")
		return
	var/answer = input("Answer their meditations...", "VOICE")
	if(!answer || QDELETED(schizo))
		return
	schizo.answer_schizo(answer, src.mob)

/datum/schizohelp
	/// Guy who made this schizohelp "ticket"
	var/mob/owner
	/// How many answers we got so far
	var/answers = 0
	/// How many answers we can get at maximum
	var/max_answers = 3

/datum/schizohelp/New(mob/owner)
	. = ..()
	if(owner)
		src.owner = owner
		RegisterSignal(owner, COMSIG_PARENT_QDELETING, PROC_REF(owner_qdeleted))
	GLOB.schizohelps += src

/datum/schizohelp/Destroy(force)
	. = ..()
	owner = null
	GLOB.schizohelps -= src

/datum/schizohelp/proc/answer_schizo(answer, mob/voice)
	if(QDELETED(src))
		return
	to_chat(owner, "<i>I hear a voice in my head... <b>[answer]</i></b>")
	for(var/client/admin in GLOB.admins)
		if(!(admin.prefs.chat_toggles & CHAT_PRAYER))
			continue
		to_chat(admin, "<span class='info'>[voice] ([voice.key || "NO KEY"]) [ADMIN_FLW(owner)] [ADMIN_SM(owner)] answered [owner] ([owner.key || "NO KEY"])'s [ADMIN_FLW(owner)] [ADMIN_SM(owner)] meditation: [answer]</span>")
	answers++
	if(answers >= max_answers)
		qdel(src)

/datum/schizohelp/proc/owner_qdeleted(mob/source)
	if(QDELETED(src))
		return
	qdel(src)
