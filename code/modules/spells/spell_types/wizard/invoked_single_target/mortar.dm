/obj/effect/proc_holder/spell/invoked/mortar
	name = "Mortar"
	desc = "Summons a targetting rune, which then drops a mortal shell onto the target."
	cost = 6
	overlay_state = "mortar"
	xp_gain = TRUE
	releasedrain = 20
	chargedrain = 1
	chargetime = 50
	recharge_time = 20 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 2
	chargedloop = /datum/looping_sound/invokeascendant
	associated_skill = /datum/skill/magic/arcane
	spell_tier = 3
	invocation = "MORTUM!"
	invocation_type = "shout"
	glow_color = GLOW_COLOR_ARTILLERY
	glow_intensity = GLOW_INTENSITY_HIGH
	gesture_required = TRUE
	range = 7
	var/delay = 10
	var/area_of_effect = 0


/obj/effect/proc_holder/spell/invoked/mortar/cast(list/targets, mob/user)
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
		sleep (3 SECONDS)
		explosion(T, devastation_range = 2, heavy_impact_range = 3, light_impact_range = 4, smoke = TRUE, soundin = mortarexplosion)
		new /obj/effect/decal/crater(T)
	addtimer(CALLBACK(src, TYPE_PROC_REF(/obj/effect/proc_holder/spell/invoked/mortar, spawncrater), T), 1)
	return TRUE

/obj/effect/proc_holder/spell/invoked/mortar/proc/spawncrater(turf/T)
    if(T)
        new /obj/effect/decal/crater(T)


/obj/effect/temp_visual/mortarmark
	icon = 'icons/effects/effects.dmi'
	icon_state = "target"
	name = "mortar marker"
	desc = "Get out of the way!"
	randomdir = FALSE
	duration = 8 SECONDS
	layer = MASSIVE_OBJ_LAYER
	light_outer_range = 2
	light_color = COLOR_NAVY

/obj/effect/decal/crater
	icon = 'icons/turf/crater.dmi'
	icon_state = "dirt_shell_alt"
	name = "crater"
	desc = "A crater left by a mortar strike. Surely they don't strike the same place twice, right?"
