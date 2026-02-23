/datum/status_effect/heroin //If you want other opiate effects with longer duration to reagent unit ratio, I recommend making a subclass of this type and using that instead.
	id = "heroin"
	alert_type = null
	status_type = STATUS_EFFECT_REFRESH // This gets refreshed p often
	duration = 10 SECONDS // This status effect is meant to get continuously refreshed by having heroin in your system. It will last until 10 seconds after the last drops of heroin pass through your bloodstream.

/datum/status_effect/heroin/on_apply()
	. = ..()
	owner.playsound_local(owner, 'sound/misc/heroin_rush.ogg', 100, FALSE) //The beginning of the decline.
	ADD_TRAIT(owner, TRAIT_NOPAIN, TRAIT_GENERIC)
	ADD_TRAIT(owner, TRAIT_NOMOOD, TRAIT_GENERIC)
	to_chat(owner, span_subtle("Warm fondness envelops you."))
	if(owner?.client)
		if(owner.client.screen && owner.client.screen.len)
			var/datum/hud/H = owner.hud_used
			H.plane_masters_update()

/datum/status_effect/heroin/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_NOPAIN, TRAIT_GENERIC)
	REMOVE_TRAIT(owner, TRAIT_NOMOOD, TRAIT_GENERIC)
	to_chat(owner, span_subtle("Cold seeps into your bones."))
	if(owner?.client)
		if(owner.client.screen && owner.client.screen.len)
			var/datum/hud/H = owner.hud_used
			H.plane_masters_update()

/datum/status_effect/meth
	id = "meth"
	alert_type = null
	status_type = STATUS_EFFECT_REFRESH
	duration = 10 SECONDS

/datum/status_effect/meth/on_apply()
	. = ..()
	ADD_TRAIT(owner, TRAIT_INFINITE_STAMINA, TRAIT_GENERIC) // SPEED
	owner.add_stress(/datum/stressevent/meth)
	to_chat(owner, span_subtle("You feel tight. Tight like a tiger."))
	if(owner?.client) // Code repeititon makes me want to tear my nipples off.
		if(owner.client.screen && owner.client.screen.len)
			var/datum/hud/H = owner.hud_used
			H.plane_masters_update()

/datum/status_effect/meth/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_INFINITE_STAMINA, TRAIT_GENERIC)
	owner.remove_stress(/datum/stressevent/meth)
	to_chat(owner, span_subtle("You are slow again."))
	if(owner?.client)
		if(owner.client.screen && owner.client.screen.len)
			var/datum/hud/H = owner.hud_used
			H.plane_masters_update()

