/*
This is where the magic happens, baby.

These are meant to be used when you walk onto a thingy that flashes you with one of these.
Naturally it also contains the part that contains the loreblurbs you've actually seen already in your human mob.
Just because it'd get a LITTLE annoying if you kept seeing this over and over. Haha.
*/


//This stores blurbs you've seen - this is really useful isn't it?
/mob/living/carbon/human
	var/list/seen_loreblurbs = list()



/datum/loreblurb
	//Obviously the title - it shows up first and it's real big
	var/title = "AN AGONIZING GLEAM"

	//This is the actual lore fluff bit
	var/description = "You thought that death would be the end of your suffering. \n Suffice to say, you were wrong."

	//You might want to give these blurbs a special sound when you see them. That is what this is for.
	var/sound = 'sound/loredump/lore_sting1.ogg'

/datum/loreblurb/proc/onEncounter(mob/living/carbon/human/H)
	if(!H)
		return
	
	if(!H.seen_loreblurbs)
		H.seen_loreblurbs = list()
	

	if(!(src.type in H.seen_loreblurbs))
	//We're good, run the rest of the proc!
		H.seen_loreblurbs += src.type
		if(sound)
			H.playsound_local(H, sound, 100, vary = FALSE)
		toMob(H)


/datum/loreblurb/proc/toMob(mob/living/carbon/human/H)
	if(!H)
		return

	if(src.title == null || src.description == null)
		return
	
	var/lorestring = "<div class=loreblurb>\
	<div class=loreblurb-title>" + title + "</div>\
	<div class=loreblurb-desc>" + description + "</div>\
	</div>"

	to_chat(H, lorestring)


/datum/loreblurb/ruined_city
	title = "Urban Ruins"
	description = "All around you are the crumbled remains of a place once inhabited by people. \n\
	A child's skull lingers half-buried in soil stain'd more than thrice with blood.\n\
	Flies buzz around you, as if mocking your presence here.\n\
	It seems not even the vultures dare come here any longer. It makes your organs want to shrivel inwards and die."

/datum/loreblurb/butchersblock
	title = "The Butcher's Block"
	description = "You wade through gore that reeks of rot. Decay assaults your nose. A wave of nausea washes over you.\n\
	There is no doubt in you that disease will follow you not long after this. Even the open air above you offers no relief from the bloated, rotting carcasses that surround you.\n\
	Dead masses float around in the fetid blood in various states of decay. Even the skull of a hound or some other small mammal occasionally surfaces to greet your sight."

/datum/loreblurb/outpostxiphos
	title = "Outpost Xiphos"
	description = "Cold and oppressive. This outpost was built ontop of conquered land. \n\
	Without a gas mask, the faint smell of copper coats the concrete walls mixed with the soft crackling of blue candles. \n\
	The Perserdunians etched out this outpost a few months ago, after an intense offensive campaign shattered both the land and the bandits that once terrorized this region. \n\
	Peace follows our Venerable Master."
	sound = 'sound/loredump/lore_sting2.ogg'
