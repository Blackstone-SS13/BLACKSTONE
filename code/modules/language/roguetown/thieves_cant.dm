/datum/language/thieves_cant
	name = "thieves cant"
	desc = "A secretive language that mimics regular speech"
	speech_verb = "says"
	ask_verb = "asks"
	exclaim_verb = "yells"
	key = "t"
	flags = LANGUAGE_HIDE_ICON_IF_UNDERSTOOD | LANGUAGE_HIDE_ICON_IF_NOT_UNDERSTOOD
	default_priority = 100
	icon_state = "galcom"
	spans = list(SPAN_THIEF)
	syllables = list()

	var/list/word_replacements = list(
			"kill" = "hug"
			"guard" = "mapper"


	)
/datum/language/thieves_cant/translate_word(var/word)
	return word_replacements[word] ? word_replacements[word] : word

/datum/language/thieves_cant/handle_speech(datum/source, list/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]
	var/list/words = splittext(message, " ")
	var/list/translated_words = list()
	
	for (var/word in words)
		var/lowered_word = lowertext(word)
		var/translated_word = translate_word(lowered_word)
		translated_words += translated_word
	speech_args[SPEECH_MESSAGE] = jointext(translated_words, "")
	return ..()
