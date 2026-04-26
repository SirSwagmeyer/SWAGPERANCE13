/*
	Combat Mode Music Track Datums
	---
	Currently only used for overriding the default combat music that comes with your job or antagonist.
	As of writing they are never directly applied to mobs themselves, only the name and musicpath are.
	Deleting these datums or renaming subtypes will not break preferences; invalid saves get redirected to /default.
	When adding new songs, add a shortname around ~12 characters for the game preferences menu.
	
	IMPORTANT! Be careful about adding songs to this list that aren't used anywhere else, lest you needlessly inflate the RSC.

	[ TEMPERANCE13 - Combat Music Override Port:
	hi hello. a bulk of this is just going to be shit i Personally decide would be good to pick from, including some role-specific cmode tracks. 
	HOWEVER, zera has made it clear they think role-specific cmode tracks should be Very Picky and not all current or new ones SHOULD be made
	available to pick from. so! these are subject to change.  ]
*/

// Admins: please don't molest my lists. You can't add new types at runtime anyways. Kisses! - Zoktiik
GLOBAL_LIST_EMPTY(cmode_tracks_by_type)
GLOBAL_LIST_EMPTY(cmode_tracks_by_name)

// People make mistakes. This should help catch when that happens.
/proc/cmode_track_to_namelist(var/datum/combat_music/track)
	if(!track)
		return
	if(!track.name)
		LAZYREMOVE(GLOB.cmode_tracks_by_type, track.type)
		CRASH("CMODE MUSIC: type [track.type] has no name!") 
	if(GLOB.cmode_tracks_by_name[track.name])
		LAZYREMOVE(GLOB.cmode_tracks_by_type, track.type)
		CRASH("CMODE MUSIC: type [track.type] has duplicate name \"[track.name]\"!")
	GLOB.cmode_tracks_by_name[track.name] = track
	return

/datum/combat_music
	var/name
	var/desc
	var/shortname
	var/credits
	var/musicpath = list()

// Shit WILL break if you change /default's typepath. Don't do it.
/datum/combat_music/default
	name = "Default"
	desc = "I let my current status sing for itself; its song will change dynamically."
	shortname = "Default"
	musicpath = list()

// Temperance13 tracks, picked because they're general-use enough to be deemed pickable

/datum/combat_music/armsman
	name = "Armsman"
	desc = "CANNON FODDER"
	shortname = "Armsman"
	musicpath = list('sound/music/combat_armsman.ogg')
	credits = "Marked For Limitation - Vellocet - ANEURISM IV OST"

/datum/combat_music/auxiliar
	name = "Auxiliar"
	desc = "SWEATY PALM, STEADY HAND"
	shortname = "Auxiliar"
	musicpath = list('sound/music/combat_auxiliar.ogg')

/datum/combat_music/backliner
	name = "Backliner"
	desc = "BLEEDING HEART"
	shortname = "Backliner"
	musicpath = list('sound/music/combat_backliner.ogg')
	credits = "ROMP.Fla (Fleetwire) - Neoify_"

/datum/combat_music/foreigner
	name = "Foreigner"
	desc = "SHEEP IN WOLF'S PEN"
	shortname = "Foreigner"
	musicpath = list('sound/music/cmode/adventurer/combat_foreigner.ogg')
	credits = "Filmmaker-Disputed Usage - Panos chr MrLsin"

/datum/combat_music/gangster
	name = "Gangster"
	desc = "CESSPIT CRAWLER"
	shortname = "Gangster"
	musicpath = list('sound/music/cmode/adventurer/combat_gangster.ogg')
	credits = "Lebedev's Airfield (Combat) - Ragitsu"

/datum/combat_music/gunman
	name = "Gunslinger (Old-Boy) / Renegade (Perpetrator/Desperado)"
	desc = "IMPUDENT VULTURE"
	shortname = "OldBoy/Perp/Desperado"
	musicpath = list('sound/music/cmode/adventurer/combat_gunman.ogg')

/datum/combat_music/machinegunner
	name = "Rook/Ammo Squire"
	desc = "FATAL RHYTHM"
	shortname = "Machinegunner"
	musicpath = list('sound/music/combat_machinegunner.ogg')
	credits = "A Question Of Trust - Nine Inch Nails & Boys Noize"

/datum/combat_music/metalface
	name = "Explorer/Provisioner"
	desc = "PARASITE VICTIM"
	shortname = "Explorer/Provisioner"
	musicpath = list('sound/music/combat_metalface.ogg')
	credits = "Mister Metalface - CRY.NN"

/datum/combat_music/poacher
	name = "Poacher"
	desc = "LOST PREDATOR"
	shortname = "Poacher"
	musicpath = list('sound/music/combat_poacher.ogg')
	credits = "Bank Robbery Theme - Woody Jackson - Red Dead Redemption 2 OST"

/datum/combat_music/soldato
	name = "Soldato"
	desc = "NAME ON A LIST"
	shortname = "Soldato"
	musicpath = list('sound/music/combat_soldato.ogg')

/datum/combat_music/veterano
	name = "Veterano"
	desc = "REVERED SINNER"
	shortname = "Veterano"
	musicpath = list('sound/music/combat_veterano.ogg')
	credits = "Rotten Corpse - Crypt Voice"

/datum/combat_music/voltigeur
	name = "Voltigeur"
	desc = "FLEETFOOT POWDERFOOD"
	shortname = "Voltigeur"
	musicpath = list('sound/music/combat_voltigeur.ogg')
	credits = "Captagon Limit - Flesh Simulator"

/datum/combat_music/analog
	name = "Sonic Analog"
	desc = "DEATH MACHINE"
	shortname = "Sonic Analog"
	musicpath = list('sound/music/combat_analog.ogg')
	credits = "Sonic Analog - Crypt Voice"

/datum/combat_music/fog
	name = "The Fog"
	desc = "PALPITATIONS"
	shortname = "The Fog"
	musicpath = list('sound/music/combat_fog.ogg')
	credits = "The Fog - Crypt Voice"

/datum/combat_music/bark
	name = "Wolf Bark"
	desc = "DEAD MUTT"
	shortname = "Wolf Bark"
	musicpath = list('sound/music/combat_bark.ogg')
	credits = "WOLF BARK - rj lake"

/datum/combat_music/zizlime
	name = "CHESHYRE_AAHQ (Zizlime Remix)"
	desc = "RATTLING IN THROAT"
	shortname = "CHESHYRE"
	musicpath = list('sound/music/combat_zizlime.ogg')
	credits = "CHESHYRE_AAHQ (Zizlime Remix) - Zizlime"

/datum/combat_music/linebreaker
	name = "LineBreaker"
	desc = "PROVE WORTHY"
	shortname = "LineBreaker"
	musicpath = list('sound/music/combat_linebreaker.ogg')
	credits = "LineBreaker - iamlocknar"
