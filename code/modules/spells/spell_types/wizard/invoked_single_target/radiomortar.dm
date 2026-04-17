/obj/effect/proc_holder/spell/invoked/radiomortar
	name = "Mortar"
	desc = "Contacts AS-Y14, who dumps a mortar shell onto the selected target."
	cost = 6
	overlay_state = "mortar"
	xp_gain = FALSE
	releasedrain = 20
	chargedrain = 1
	chargetime = 25
	recharge_time = 5 SECONDS
	warnie = "spellwarning"
	req_items = list(/obj/item/clothing/head/roguetown/paddedcap/radio, /obj/item/storage/backpack/rogue/satchel/radiopack)
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 2
	chargedloop = /datum/looping_sound/invokeradio
	associated_skill = /datum/skill/magic/arcane
	spell_tier = 3
	gesture_required = TRUE
	range = 7
	var/delay = 10
	var/area_of_effect = 0


/obj/effect/proc_holder/spell/invoked/radiomortar/cast(list/targets, mob/user)
	var/mortarfall = pick('sound/magic/mortar1.ogg','sound/magic/mortar2.ogg','sound/magic/mortar3.ogg')
	var/mortarexplosion = pick('sound/misc/explode/mortarexplo1.ogg','sound/misc/explode/mortarexplo2.ogg','sound/misc/explode/mortarexplo3.ogg')
	var/turf/T = get_turf(targets[1])

	for(var/turf/affected_turf in view(area_of_effect, T))
		if(affected_turf.density)
			continue
			

	for(var/turf/affected_turf in view(area_of_effect, T))
	
		new /obj/effect/temp_visual/mortarmark(affected_turf)
	
		playsound(T, 'sound/magic/artilleryload.ogg', 80, TRUE, soundping = FALSE)

		sleep(delay)
		new /obj/effect/temp_visual/mortarmark(affected_turf)
		for(var/mob/living/L in affected_turf.contents) 
			if(L.anti_magic_check())
				visible_message(span_warning("The marker fades away! [L] "))  //antimagic needs some testing
				playsound(get_turf(L),'sound/magic/magic_nulled.ogg', 100)
				return TRUE

		playsound(T, mortarfall, 100, FALSE)
		sleep (2.7 SECONDS)
		explosion(T, devastation_range = 2, heavy_impact_range = 3, light_impact_range = 4, smoke = TRUE, soundin = mortarexplosion)
	addtimer(CALLBACK(src, TYPE_PROC_REF(/obj/effect/proc_holder/spell/invoked/mortar, spawncrater), T), 1) //there's probably a better way of doing this
	return TRUE

/obj/effect/proc_holder/spell/invoked/radiomortar/proc/spawncrater(turf/T)
    if(T)
        new /obj/structure/crater(T)
