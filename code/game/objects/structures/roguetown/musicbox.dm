#define MUSIC_TAVCAT_OTHERWORLDLY list(\
	"PEACE" = 'sound/music/jukeboxes/otherworld/song1.ogg',\
	"FOR ME" = 'sound/music/jukeboxes/otherworld/song2.ogg',\
	"SPIT" = 'sound/music/jukeboxes/otherworld/song3.ogg',\
	"RESPIRATOR" = 'sound/music/jukeboxes/otherworld/song4.ogg',\
	"DAMAGED" = 'sound/music/jukeboxes/otherworld/song5.ogg',\
)
#define MUSIC_TAVCAT_RADIO list(\
	"Risvonian Talkshow" = 'sound/music/jukeboxes/gen/talkshow.ogg',\
	"Ziggurate's Simplified Anthem" = 'sound/music/jukeboxes/gen/countdown.ogg',\
)

/datum/looping_sound/musloop
	mid_sounds = list()
	mid_length = 2400 // Whoever wrote this is giving me an aneurism
	volume = 70
	extra_range = 8
	falloff = 0
	persistent_loop = TRUE
	var/stress2give = /datum/stressevent/music
	channel = CHANNEL_JUKEBOX

/datum/looping_sound/musloop/on_hear_sound(mob/M)
	. = ..()
	if(stress2give)
		if(isliving(M))
			var/mob/living/carbon/L = M
			L.add_stress(stress2give)

/obj/structure/roguemachine/musicbox
	name = "metal radio"
	desc = "Discovered within one of LOVE's catacombs, this funny little piece allows for telecommunications. It can even play some pre-recorded music."
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "music0"
	density = TRUE
	anchored = TRUE
	max_integrity = 0
	var/datum/looping_sound/musloop/soundloop
	var/list/init_curfile = list('sound/music/jukeboxes/gen/talkshow.ogg') // A list of songs that curfile is set to on init. MUST BE IN ONE OF THE MUSIC_TAVCAT_'s.
	var/curfile // The current track that is playing right now
	var/playing = FALSE // If music is playing or not. playmusic() deals with this don't mess with it.
	var/curvol = 50 // The current volume at which audio is played. MAPPERS MAY TOUCH THIS.
	var/playuponspawn = FALSE // Does the music box start playing music when it first spawns in? MAPPERS MAY TOUCH THIS.

/obj/structure/roguemachine/musicbox/Initialize()
	. = ..()
	curfile = pick(init_curfile)
	soundloop = new(src, FALSE)
	if(playuponspawn)
		start_playing()

/obj/structure/roguemachine/musicbox/Destroy()
	. = ..()
	qdel(soundloop) //jesus fuck who is using hard dels in this day and age

/obj/structure/roguemachine/musicbox/update_icon()
	icon_state = "music[playing]"

/obj/structure/roguemachine/musicbox/proc/toggle_music()
	if(!playing)
		start_playing()
	else
		stop_playing()

/obj/structure/roguemachine/musicbox/proc/start_playing()
	playing = TRUE
	soundloop.mid_sounds = list(curfile)
	soundloop.cursound = null
	soundloop.volume = curvol
	soundloop.start()
	testing("Music: V[soundloop.volume] C[soundloop.cursound] T[soundloop.thingshearing]")
	update_icon()

/obj/structure/roguemachine/musicbox/proc/stop_playing()
	playing = FALSE
	soundloop.stop()
	update_icon()

/obj/structure/roguemachine/musicbox/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return

	user.changeNext_move(CLICK_CD_INTENTCAP)

	var/button_selection = input(user, "What button do I press?", "\The [src]") as null | anything in list("Stop/Start","Change Song","Change Volume")
	if(!Adjacent(user))
		return
	if(!button_selection)
		to_chat(user, span_info("I change my mind..."))
		return
	user.visible_message(span_info("[user] presses a button on \the [src]."),span_info("I press a button on \the [src]."))
	playsound(loc, pick('sound/misc/keyboard_select (1).ogg','sound/misc/keyboard_select (2).ogg','sound/misc/keyboard_select (3).ogg','sound/misc/keyboard_select (4).ogg'), 100, FALSE, -1)

	if(button_selection=="Stop/Start")
		toggle_music()

	if(button_selection=="Change Song")
		var/songlists_selection = input(user, "Which song list?", "\The [src]") as null | anything in list("RECORDED MUSIC"=MUSIC_TAVCAT_OTHERWORLDLY, "RADIO STATION"=MUSIC_TAVCAT_RADIO)
		playsound(loc, pick('sound/misc/keyboard_select (1).ogg','sound/misc/keyboard_select (2).ogg','sound/misc/keyboard_select (3).ogg','sound/misc/keyboard_select (4).ogg'), 100, FALSE, -1)
		user.visible_message(span_info("[user] presses a button on \the [src]."),span_info("I press a button on \the [src]."))
		var/chosen_songlists_selection = null
		if(songlists_selection=="RECORDED MUSIC")
			chosen_songlists_selection = MUSIC_TAVCAT_OTHERWORLDLY
		if(songlists_selection=="RADIO STATION")
			chosen_songlists_selection = MUSIC_TAVCAT_RADIO
		var/song_selection = input(user, "Which song do I play?", "\The [src]") as null | anything in chosen_songlists_selection
		if(!Adjacent(user))
			return
		if(!song_selection)
			to_chat(user, span_info("I change my mind..."))
			return
		playsound(loc, pick('sound/misc/keyboard_select (1).ogg','sound/misc/keyboard_select (2).ogg','sound/misc/keyboard_select (3).ogg','sound/misc/keyboard_select (4).ogg'), 100, FALSE, -1)
		user.visible_message(span_info("[user] presses a button on \the [src]."),span_info("I press a button on \the [src]."))
		curfile = chosen_songlists_selection[song_selection]
		stop_playing()
		start_playing()

	if(button_selection=="Change Volume")
		var/volume_selection = input(user, "How loud do you wish me to be?", "\The [src] (Volume Currently : [curvol]/[100])") as num|null
		if(!Adjacent(user))
			return
		if(!volume_selection)
			to_chat(user, span_info("I change my mind..."))
			return
		if(volume_selection == curvol)
			to_chat(user, span_info("The dial is already set to that volume!"))
			return
		playsound(loc, pick('sound/misc/keyboard_select (1).ogg','sound/misc/keyboard_select (2).ogg','sound/misc/keyboard_select (3).ogg','sound/misc/keyboard_select (4).ogg'), 100, FALSE, -1)
		user.visible_message(span_info("[user] presses a button on \the [src]."),span_info("I press a button on \the [src]."))
		volume_selection = clamp(volume_selection, 1, 100)
		if(curvol<volume_selection)
			to_chat(user, span_info("I make \the [src] get louder."))
		else
			to_chat(user, span_info("I make \the [src] get quieter."))
		curvol = volume_selection
		stop_playing()
		start_playing()

/obj/structure/roguemachine/musicbox/tavern
	init_curfile = list(\
		'sound/music/jukeboxes/gen/talkshow.ogg',\
		'sound/music/jukeboxes/gen/countdown.ogg',\
		'sound/music/jukeboxes/otherworld/song1.ogg',
		'sound/music/jukeboxes/otherworld/song2.ogg',\
		'sound/music/jukeboxes/otherworld/song3.ogg',\
	)
	curvol = 65
	playuponspawn = TRUE
/* The fuck is this
/obj/structure/roguemachine/musicbox/Initialize()
	. = ..()
	soundloop.extra_range = 12
	soundloop.falloff = 6
*/
