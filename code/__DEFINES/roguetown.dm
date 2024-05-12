//used in various places
#define ALL_RACES_LIST		list("humen", "dwarfm", "elfw", "elfd", "helf", "tiefling", "argonian", "aasimar", "halforc")

#define ALL_RACES_LIST_NAMES		list("Humen", "Elf", "Dark Elf", "Half-Elf", "Dwarf", "Tiefling", "Aasimar")

#define ALL_PATRON_NAMES_LIST		list("Astrata", "Noc", "Xylix", "Eora", "Malum", "Dendor", "Abyssor", "Necra", "Pestra", "Malum", "Ravox")

#define PLATEHIT "plate"
#define CHAINHIT "chain"
#define SOFTHIT "soft"

/proc/get_armor_sound(blocksound, blade_dulling)
	switch(blocksound)
		if(PLATEHIT)
			if(blade_dulling == BCLASS_CUT||blade_dulling == BCLASS_CHOP)
				return pick('sound/combat/hits/armor/plate_slashed (1).ogg','sound/combat/hits/armor/plate_slashed (2).ogg','sound/combat/hits/armor/plate_slashed (3).ogg','sound/combat/hits/armor/plate_slashed (4).ogg')
			if(blade_dulling == BCLASS_STAB||blade_dulling == BCLASS_PICK||blade_dulling == BCLASS_BITE)
				return pick('sound/combat/hits/armor/plate_stabbed (1).ogg','sound/combat/hits/armor/plate_stabbed (2).ogg','sound/combat/hits/armor/plate_stabbed (3).ogg')
			else
				return pick('sound/combat/hits/armor/plate_blunt (1).ogg','sound/combat/hits/armor/plate_blunt (2).ogg','sound/combat/hits/armor/plate_blunt (3).ogg')
		if(CHAINHIT)
			if(blade_dulling == BCLASS_BITE||blade_dulling == BCLASS_STAB||blade_dulling == BCLASS_PICK||blade_dulling == BCLASS_CUT||blade_dulling == BCLASS_CHOP)
				return pick('sound/combat/hits/armor/chain_slashed (1).ogg','sound/combat/hits/armor/chain_slashed (2).ogg','sound/combat/hits/armor/chain_slashed (3).ogg','sound/combat/hits/armor/chain_slashed (4).ogg')
			else
				return pick('sound/combat/hits/armor/chain_blunt (1).ogg','sound/combat/hits/armor/chain_blunt (2).ogg','sound/combat/hits/armor/chain_blunt (3).ogg')
		if(SOFTHIT)
			if(blade_dulling == BCLASS_BITE||blade_dulling == BCLASS_STAB||blade_dulling == BCLASS_PICK||blade_dulling == BCLASS_CUT||blade_dulling == BCLASS_CHOP)
				return pick('sound/combat/hits/armor/light_stabbed (1).ogg','sound/combat/hits/armor/light_stabbed (2).ogg','sound/combat/hits/armor/light_stabbed (3).ogg')
			else
				return pick('sound/combat/hits/armor/light_blunt (1).ogg','sound/combat/hits/armor/light_blunt (2).ogg','sound/combat/hits/armor/light_blunt (3).ogg')

GLOBAL_LIST_INIT(lockhashes, list())
GLOBAL_LIST_INIT(lockids, list())
GLOBAL_LIST_EMPTY(credits_icons)
GLOBAL_LIST_EMPTY(confessors)

GLOBAL_LIST_INIT(wolf_prefixes, list("Red", "Moon", "Bloody", "Hairy", "Eager", "Sharp"))
GLOBAL_LIST_INIT(wolf_suffixes, list("Fang", "Claw", "Stalker", "Prowler", "Roar", "Ripper"))

//preference stuff
#define FAMILY_NONE 1
#define FAMILY_PARTIAL 2
#define FAMILY_FULL 3

#define FAITH_NONE 0
#define FAITH_PSYDON 1
#define FAITH_ELF 2
#define FAITH_DWARF 3
#define FAITH_SPIDER 4
#define FAITH_ZIZO 5

/proc/get_faith_name(faith)
	switch(faith)
		if(FAITH_PSYDON)
			return "Father-Son"
		if(FAITH_ELF)
			return "Elfish Pantheon"
		if(FAITH_DWARF)
			return "Dwarfish Paganism"
		if(FAITH_SPIDER)
			return "Spider Queen"
		if(FAITH_ZIZO)
			return "Zizo"

/proc/get_faith_desc(faith)
	switch(faith)
		if(FAITH_PSYDON)
			return "You believe in the Father-Son. Only through His sun SAVIOR PSYDON may you join His golden kingdom in death."
		if(FAITH_ELF)
			return "You believe in the FAERIE PANTHEON, may Brother Courage and Sister Pride protect you from the wrath of the Trickster."
		if(FAITH_DWARF)
			return "By rock, you believe in DWARFISH PAGANISM! Only by respecting the gods of soil and water may you survive this week."
		if(FAITH_SPIDER)
			return "You pledged your faith in the SPIDER QUEEN, a godlike creature who ruled the Under-World before her untimely death."
		if(FAITH_ZIZO)
			return "You are a disgusting slave of ZIZO! Let the scum of creation die in obscene ways as your beautiful evil turns the world dark and miserable."


GLOBAL_LIST_EMPTY(sunlights)

/*
	ha ha ha bitflags!
	For the shitty subjob (class) categories
*/
#define RT_TYPE_DISABLED_CLASS 1 // Disabled, aka don't make it fuckin APPEAR
#define RT_TYPE_FREE_CLASS 2 // Free class - Formerly pilgrims, no specific orientation
#define RT_TYPE_COMBAT_CLASS 4 // Combat class - oriented towards combat
#define RT_TYPE_VILLAGER_CLASS 8 // Villager class - Villagers can use it
#define RT_TYPE_ANTAG_CLASS 16 // Antag class - results in an antag
#define RT_TYPE_CHALLENGE_CLASS 32 // Challenge class - Meant to be free for everyone


/*
	Defines for the triumph buy datum categories
*/
#define TRIUMPH_CAT_ROUND_EFX "ROUND-EFX"
#define TRIUMPH_CAT_CHARACTER "CHARACTER"
#define TRIUMPH_CAT_MISC "MISC!"
#define TRIUMPH_CAT_ACTIVE_DATUMS "ACTIVE"
