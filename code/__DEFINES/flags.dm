//for convenience
//#define variable |= flag) (variable |= (flag))
//#define variable &= ~flag (variable &= ~(flag))
//#define (variable & flag) (variable & (flag))
//#define TOGGLE_BITFIELD(variable, flag) (variable ^= (flag))


//check if all bitflags specified are present
#define CHECK_MULTIPLE_BITFIELDS(flagvar, flags) (((flagvar) & (flags)) == (flags))

// for /datum/var/datum_flags
#define DF_USE_TAG				(1<<0)
#define DF_VAR_EDITED			(1<<1)
#define PROCESSING_DEFAULT		(1<<2)
#define PROCESSING_FAST			(1<<3)
#define PROCESSING_WEATHER		(1<<4)
#define PROCESSING_PROJECTILE	(1<<5)
#define PROCESSING_TODCHANGE	(1<<6)
#define PROCESSING_INCONE		(1<<7)
#define PROCESSING_HUMANNPC		(1<<8)
#define PROCESSING_WATERLEVEL	(1<<9)
#define PROCESSING_LIGHTING		(1<<10)
#define PROCESSING_LOBBY	(1<<11)
#define PROCESSING_DAMOVERLAYS	(1<<12)

//FLAGS BITMASK

/// This flag is what recursive_hear_check() uses to determine wether to add an item to the hearer list or not.
#define HEAR_1						(1<<3)
/// Projectiels will check ricochet on things impacted that have this.
#define CHECK_RICOCHET_1			(1<<4)
/// conducts electricity (metal etc.)
#define CONDUCT_1					(1<<5)
/// For machines and structures that should not break into parts, eg, holodeck stuff
#define NODECONSTRUCT_1				(1<<7)
/// atom queued to SSoverlay
#define OVERLAY_QUEUED_1			(1<<8)
/// TESLA_IGNORE grants immunity from being targeted by tesla-style electricity
#define TESLA_IGNORE_1				(1<<13)

//turf-only flags
#define NOJAUNT_1					(1<<0)
#define UNUSED_RESERVATION_TURF_1	(1<<1)
/// If blood cultists can draw runes or build structures on this turf
#define CULT_PERMITTED_1			(1<<3)
/// Blocks lava rivers being generated on the turf
#define NO_LAVA_GEN_1				(1<<6)
/// Blocks ruins spawning on the turf
#define NO_RUINS_1					(1<<10)

/*
	These defines are used specifically with the atom/pass_flags bitmask
	the atom/checkpass() proc uses them (tables will call movable atom checkpass(PASSTABLE) for example)
*/
//flags for pass_flags
/// When moving, will Bump()/Cross()/Uncross() everything, but won't be stopped.
#define UNSTOPPABLE		(1<<4)


//tesla_zap
#define TESLA_MACHINE_EXPLOSIVE		(1<<0)
#define TESLA_ALLOW_DUPLICATES		(1<<1)
#define TESLA_OBJ_DAMAGE			(1<<2)
#define TESLA_MOB_DAMAGE			(1<<3)
#define TESLA_MOB_STUN				(1<<4)

#define TESLA_DEFAULT_FLAGS ALL
#define TESLA_FUSION_FLAGS TESLA_OBJ_DAMAGE | TESLA_MOB_DAMAGE | TESLA_MOB_STUN

// radiation
#define RAD_PROTECT_CONTENTS (1<<0)
#define RAD_NO_CONTAMINATE (1<<1)
