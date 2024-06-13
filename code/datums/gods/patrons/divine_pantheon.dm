/datum/patron/pagan
	name = null
	associated_faith = /datum/faith/paganism
	t0 = /obj/effect/proc_holder/spell/invoked/lesser_heal

/datum/patron/pagan/psydon
	name = "Psydon"
	domain = "Supposed God of Ontological Reality"
	desc = "Pagans claim Psydon as the progenitor of the Nine. He is supposed to have created humen in his image to live in Psydonia."
	worshippers = "Heretics and the Enlightened"
	associated_faith = /datum/faith/paganism
	confess_lines = list(
		"PSYDON IS THE CREATOR!",
		"THE SAINTS ARE FALSE IDOLS!",
		"PSYDON IS MY SHEPHERD!",
	)

/datum/patron/pagan/astrata
	name = "Astrata"
	domain = "Goddess of the Sun, Day, and Order"
	desc = "The Firstborn of Psydon, twin of Noc, gifted man the Sun as her divine gift."
	worshippers = "The Noble Hearted, Zealots and Farmers"
	t1 = /obj/effect/proc_holder/spell/invoked/sacred_flame_rogue
	t2 = /obj/effect/proc_holder/spell/invoked/heal
	t3 = /obj/effect/proc_holder/spell/invoked/revive
	confess_lines = list(
		"THE DAUGHTER OF PSYDON RULES THE DAE!",
		"CEPHAS IS A DIM IMITATION OF HER GLORY!",
		"ASTRATA IS MY LIGHT!",
	)

/datum/patron/pagan/noc
	name = "Noc"
	domain = "God of the Moon, Night, and Knowledge"
	desc = "The Firstborn of Psydon, twin of Astrata, gifted man divine knowledge."
	worshippers = "Wizards and Scholars"
	t1 = /obj/effect/proc_holder/spell/invoked/blindness
	t2 = /obj/effect/proc_holder/spell/invoked/invisibility
	confess_lines = list(
		"THE MOON LIGHTS MY WAY!",
		"EOSTEN IS BUT A FOOL COMPARED TO MY LORD!",
		"NOC IS MY TUTOR!",
	)

/datum/patron/pagan/dendor
	name = "Dendor"
	domain = "God of the Earth and Nature"
	desc = "The Primordial Son of Psydon, patron of beasts and the wood. Gone mad with time."
	worshippers = "Druids, Beasts, Madmen"
	mob_traits = list(TRAIT_KNEESTINGER_IMMUNITY)
	t1 = /obj/effect/proc_holder/spell/targeted/blesscrop
	t2 = /obj/effect/proc_holder/spell/targeted/beasttame
	t3 = /obj/effect/proc_holder/spell/targeted/conjure_glowshroom
	confess_lines = list(
		"THE WILDERNESS IS MY HOME!",
		"YA'AKOV ROAMS AT THE PLEASURE OF THE LORD OF BEASTS!",
		"DENDOR PRESERVES ALL OF NATURE!",
	)

/datum/patron/pagan/abyssor
	name = "Abyssor"
	domain = "God of the Ocean, Storms and the Tide"
	desc = "The Beloved Son, gifted primordial men food and water."
	worshippers = "Men of the Sea, Primitive Aquatics"
	confess_lines = list(
		"THE SEAS ARE MY DOMAIN!",
		"CANA DROWNED 'NEATH THE WAVES!",
		"ABYSSOR IS THE WIND IN MY SAILS!",
	)

/datum/patron/pagan/ravox
	name = "Ravox"
	domain = "God of War, Justice and Strength"
	desc = "The strongest of Psydon's children, he watches man from afar."
	worshippers = "Warriors, Sellswords & those who seek Justice"
	confess_lines = list(
		"THE LORD OF JUSTICE RIGHTS ALL WRONGS!",
		"MATHUIN FELL TO A HAIL OF ARROWS!",
		"RAVOX GUIDES MY HAND!",
	)

/datum/patron/pagan/necra
	name = "Necra"
	domain = "Goddess of Death and the Afterlife"
	desc = "The Veiled Lady, a feared but respected God who leads the dead."
	worshippers = "The Dead, Mourners, Gravekeepers"
	mob_traits = list(TRAIT_SOUL_EXAMINE)
	t1 = /obj/effect/proc_holder/spell/targeted/burialrite
	t2 = /obj/effect/proc_holder/spell/targeted/churn
	t3 = /obj/effect/proc_holder/spell/targeted/soulspeak
	confess_lines = list(
		"THE UNDERMAIDEN GUIDES THE LOST!",
		"LABBEUS IS A TWO-FACED GRIFTER!",
		"NECRA GRANTS ME MY PEACE!",
	)

/datum/patron/pagan/xylix
	name = "Xylix"
	domain = "God of Trickery, Freedom and Inspiration"
	desc = "The Mad-God, gifted man wanderlust and a thousand tricks."
	worshippers = "Cheats, Frauds, Silver-Tongued devils and Roguish Types"
	confess_lines = list(
		"THE MAD-GOD ALWAYS COMES OUT ON TOP!",
		"JULIAS IS AN ARBITRARY TOOL!",
		"XYLIX IS MY ONLY MUSE!",
	)

/datum/patron/pagan/pestra
	name = "Pestra"
	domain = "Goddess of Decay, Disease and Medicine"
	desc = "The Loving Daughter of Psydon, gifted man medicine."
	worshippers = "The Sick, Phyicians, Apothecaries"
	mob_traits = list(TRAIT_EMPATH, TRAIT_ROT_EATER)
	t0 = /obj/effect/proc_holder/spell/invoked/diagnose
	t1 = /obj/effect/proc_holder/spell/invoked/lesser_heal
	t2 = /obj/effect/proc_holder/spell/invoked/heal
	t3 = /obj/effect/proc_holder/spell/invoked/attach_bodypart
	confess_lines = list(
		"THE LADY OF PESTILENCE HOLDS BACK THE ROT!",
		"MIKROS IS A PEDDLER OF SNAKE OIL!",
		"PESTRA SOOTHES MY PAINS!",
	)

/datum/patron/pagan/malum
	name = "Malum"
	domain = "God of Fire, Destruction and Rebirth"
	desc = "The Opinionless God, his children hold no malice in their actions."
	worshippers = "Smiths, Miners, Artists"
	t1 = /obj/effect/proc_holder/spell/invoked/sacred_flame_rogue
	confess_lines = list(
		"THE FORGE LORD IS THE GREATEST ARTISAN!",
		"TOMA COULD LEARN A LOT FROM MALUM!",
		"MALUM KEEPS THE WHEEL OF PROGRESS TURNING!",
	)
