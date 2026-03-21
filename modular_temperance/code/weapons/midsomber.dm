/obj/item/rogueweapon/sword/sabre/midsomber
	name = "Lance of the Midsomber Night's Childe"
	desc = "A red lance made out of hardened blood."
	possible_item_intents = list(/datum/intent/spear/thrust/glaive, /datum/intent/spear/cut/glaive, /datum/intent/axe/chop/scythe, SPEAR_BASH)
	force = 30
	icon_state = "midsomber"
	item_state = "midsomber"
	experimental_inhand = FALSE
	icon = 'icons/roguetown/weapons/32.dmi'
	lefthand_file = 'icons/mob/inhands/64x64_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/64x64_righthand.dmi'
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	wdefense = 9
	slot_flags = ITEM_SLOT_BACK
	bigboy = FALSE
	wlength = WLENGTH_GREAT
	w_class = WEIGHT_CLASS_BULKY
	minstr = 9
	max_blade_int = 200
	anvilrepair = /datum/skill/craft/weaponsmithing
	smeltresult = /obj/item/ingot/steel
	associated_skill = /datum/skill/combat/swords
	blade_dulling = DULLING_SHAFT_WOOD
	var/furioso_start = FALSE
	var/furioso_active = FALSE

	var/def_zone = BODY_ZONE_PRECISE_NECK
	var/obj/item/held_weapon = /obj/item/rogueweapon/sword/sabre/midsomber

/obj/item/rogueweapon/sword/sabre/midsomber/Initialize()
	. = ..()
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	worn_x_dimension = 64
	worn_y_dimension = 64


// shamelessly stolen from lc13

/obj/item/rogueweapon/sword/sabre/midsomber/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	if(furioso_start)
		INVOKE_ASYNC(src, PROC_REF(try_furioso), user, target)
		return
	
	. = ..()


/obj/item/rogueweapon/sword/sabre/midsomber/proc/try_furioso(mob/living/user, atom/target)
	SIGNAL_HANDLER
	if(user.get_active_held_item() != src)
		return
	if(target == user)
		return
	if(furioso_active)
		return
	INVOKE_ASYNC(src, PROC_REF(furioso), user)

/obj/item/rogueweapon/sword/sabre/midsomber/proc/furioso(mob/living/user)
	furioso_active = TRUE
	// Collect targets in range
	var/list/targets = list()
	for(var/mob/living/L in range(8, user))
		if(L == user)
			continue
		if(L.status_flags & GODMODE)
			continue
		if(L.stat == DEAD)
			continue
		targets += L

	if(!LAZYLEN(targets))
		to_chat(user, span_warning("There are no enemies nearby!"))
		furioso_active = FALSE
		return

	// Weapon data for Furioso - each weapon has: name, icon, hits, damage, damtype, sound, move
	// Note: damtype uses literal strings ("red", "white", "black", "pale") to ensure proper retrieval from the nested list
	var/static/list/furioso_weapons = list(
		list("name" = "hatchet", "icon" = "index_vial_hatchet", "hits" = 5, "damage" = 30, "damtype" = "BRUTE", "bodypart" = "BODYZONE_CHEST", "sound" = 'modular_temperance/sounds/midsomber/sound_weapons_black_vial_index_vial_hatchet.ogg', "move" = "flurry"),
		list("name" = "stiletto", "icon" = "index_vial_stiletto", "hits" = 4, "damage" = 35, "damtype" = "BRUTE", "bodypart" = "BODY_ZONE_PRECISE_STOMACH", "sound" = 'modular_temperance/sounds/midsomber/sound_weapons_black_vial_index_vial_stiletto.ogg', "move" = "circle"),
		list("name" = "bastard sword", "icon" = "index_vial_bsword", "hits" = 2, "damage" = 75, "damtype" = "BRUTE", "bodypart" = "BODY_ZONE_HEAD", "sound" = 'modular_temperance/sounds/midsomber/sound_weapons_black_vial_index_vial_bsword.ogg', "move" = "dashthrough"),
		list("name" = "rapier", "icon" = "index_vial_rapier", "hits" = 3, "damage" = 50, "damtype" = "BRUTE", "bodypart" = "BODY_ZONE_R_ARM", "sound" = 'modular_temperance/sounds/midsomber/sound_weapons_black_vial_index_vial_rapier.ogg', "move" = "lunge"),
		list("name" = "hammer", "icon" = "index_vial_hammer", "hits" = 2, "damage" = 90, "damtype" = "BRUTE", "bodypart" = "BODY_ZONE_L_ARM", "sound" = 'modular_temperance/sounds/midsomber/sound_weapons_black_vial_index_vial_hammer.ogg', "move" = "leapsmash"),
		list("name" = "greatsword", "icon" = "index_vial_gsword", "hits" = 2, "damage" = 100, "damtype" = "BRUTE", "bodypart" = "BODY_ZONE_CHEST", "sound" = 'modular_temperance/sounds/midsomber/sound_weapons_black_vial_index_vial_gsword.ogg', "move" = "dashthrough_heavy"),
		list("name" = "lance", "icon" = "index_vial_lance", "hits" = 2, "damage" = 95, "damtype" = "BRUTE", "bodypart" = "BODY_ZONE_CHEST", "sound" = 'modular_temperance/sounds/midsomber/sound_weapons_black_vial_index_vial_lance.ogg', "move" = "charge"),
		list("name" = "whip", "icon" = "index_vial_whip", "hits" = 2, "damage" = 60, "damtype" = "BRUTE", "bodypart" = "BODY_ZONE_HEAD", "sound" = 'modular_temperance/sounds/midsomber/sound_weapons_black_vial_index_vial_whip.ogg', "move" = "ranged"),
		list("name" = "scythe", "icon" = "index_vial_scythe", "hits" = 1, "damage" = 500, "damtype" = "BRUTE", "bodypart" = "BODY_ZONE_PRECISE_NECK", "sound" = 'modular_temperance/sounds/midsomber/sound_weapons_black_vial_index_vial_scythe.ogg', "move" = "reap")
	)

	/// Beam trail colors by damage type
	var/static/list/beam_colors = list(
		"red" = "#9e1638",
		"bloodred" = "#5c0e0e",
		"coagulatedred" = "#530505",
		"kindared" = "#441414"
	)

	furioso_start(user, targets)

	// Save original target list so furioso_end can clean up all muted targets,
	// even ones removed from 'targets' during the attack loop due to death
	var/list/all_targets = targets.Copy()

	for(var/list/weapon_data in furioso_weapons)
		var/mob/living/target = furioso_pick_target(targets)
		if(!target)
			break
		furioso_attack(user, target, weapon_data, beam_colors)

	furioso_end(user, all_targets)

/obj/item/rogueweapon/sword/sabre/midsomber/proc/furioso_start(mob/living/user, list/targets)
	ADD_TRAIT(src, TRAIT_NODROP, TRAIT_GENERIC)
	user.status_flags |= GODMODE
	user.Stun(60 SECONDS, ignore_canstun = TRUE)
	user.anchored = TRUE
	for(var/mob/living/L in targets)
		L.Stun(60 SECONDS, ignore_canstun = TRUE)
		walk(L, 0)
		if(isanimal(L))
			var/mob/living/simple_animal/S = L
			S.toggle_ai(AI_OFF)

/// Picks a valid living target from the list, removing dead/deleted ones. Returns null if none remain.
/obj/item/rogueweapon/sword/sabre/midsomber/proc/furioso_pick_target(list/targets)
	var/mob/living/target = pick(targets)
	if(QDELETED(target) || target.stat == DEAD)
		targets -= target
		if(!LAZYLEN(targets))
			return null
		target = pick(targets)
		if(QDELETED(target))
			return null
	return target

/// Dispatches each furioso weapon attack to its unique movement helper
/obj/item/rogueweapon/sword/sabre/midsomber/proc/furioso_attack(mob/living/user, mob/living/target, list/weapon_data, list/colors)
	if(QDELETED(user) || QDELETED(target))
		return
	// Update weapon visuals
	icon_state = weapon_data["icon"]
	item_state = weapon_data["icon"]
	user.update_inv_hands()

	var/move_type = weapon_data["move"]
	switch(move_type)
		if("flurry")
			furioso_flurry(user, target, weapon_data, colors)
		if("circle")
			furioso_circle(user, target, weapon_data, colors)
		if("dashthrough")
			furioso_dashthrough(user, target, weapon_data, colors, FALSE)
		if("dashthrough_heavy")
			furioso_dashthrough(user, target, weapon_data, colors, TRUE)
		if("lunge")
			furioso_lunge(user, target, weapon_data, colors)
		if("leapsmash")
			furioso_leapsmash(user, target, weapon_data, colors)
		if("charge")
			furioso_charge(user, target, weapon_data, colors)
		if("ranged")
			furioso_ranged(user, target, weapon_data, colors)
		if("reap")
			furioso_reap(user, target, weapon_data, colors)

/// Shared dash helper: afterimage at origin, forceMove, colored beam trail, face target
/obj/item/rogueweapon/sword/sabre/midsomber/proc/furioso_dash_to(mob/living/user, turf/destination, mob/living/target, beam_color)
	var/turf/origin = get_turf(user)
	new /obj/effect/temp_visual/decoy/fading/halfsecond(origin, user)
	user.forceMove(destination)
	user.dir = get_dir(user, target)
	var/datum/beam/trail = origin.Beam(user, "1-full", time = 2)
	if(trail && beam_color)
		trail.visuals.color = beam_color

/// Shared hit helper: sound, visual effect, damage
/obj/item/rogueweapon/sword/sabre/midsomber/proc/furioso_hit(mob/living/user, mob/living/target, list/weapon_data, effect_type)
	if(QDELETED(user) || QDELETED(target))
		return
	playsound(user, weapon_data["sound"], 40, TRUE)
	user.do_attack_animation(target)
	if(effect_type)
		new effect_type(get_turf(target))
	target.apply_damage(weapon_data["damage"], weapon_data["damtype"], weapon_data["bodypart"])

/// Hatchet: rapid repositioning around target between each hit
/obj/item/rogueweapon/sword/sabre/midsomber/proc/furioso_flurry(mob/living/user, mob/living/target, list/weapon_data)
	var/color = "#5c0e0e"
	var/beam_color = color
	var/victim = target
	var/damage = 40
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	inhand_x_dimension = 32
	inhand_y_dimension = 32
	for(var/i in 1 to weapon_data["hits"])
		if(QDELETED(src) || QDELETED(user) || QDELETED(target))
			return
		var/turf/dest = get_step(target.loc, pick(GLOB.cardinals))
		if(!dest)
			dest = get_turf(target)
		furioso_dash_to(user, dest, target, beam_color)
		furioso_hit(user, target, weapon_data, /obj/effect/temp_visual/smash_effect/red)
		arcyne_strike(user, victim, held_weapon, damage, def_zone, BCLASS_CHOP)
		sleep(0.15 SECONDS)
	sleep(0.2 SECONDS)

/// Stiletto: orbit target, hitting from each cardinal direction
/obj/item/rogueweapon/sword/sabre/midsomber/proc/furioso_circle(mob/living/user, mob/living/target, list/weapon_data)
	var/color = "#9e1616"
	var/beam_color = color
	var/victim = target
	var/damage = 35
	lefthand_file = 'icons/mob/inhands/48x48_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/48x48_righthand.dmi'
	inhand_x_dimension = 48
	inhand_y_dimension = 48
	var/list/cardinals = list(NORTH, EAST, SOUTH, WEST)
	for(var/i in 1 to weapon_data["hits"])
		if(QDELETED(src) || QDELETED(user) || QDELETED(target))
			return
		var/dir = cardinals[((i - 1) % 4) + 1]
		var/turf/dest = get_step(target.loc, dir)
		if(!dest)
			dest = get_turf(target)
		furioso_dash_to(user, dest, target, beam_color)
		furioso_hit(user, target, weapon_data, /obj/effect/temp_visual/slice/red)
		arcyne_strike(user, victim, held_weapon, damage, def_zone, BCLASS_PIERCE)
		sleep(0.2 SECONDS)
	sleep(0.2 SECONDS)

/// Bastard Sword / Greatsword: dash through target and back. heavy = camera shake + red smash
/obj/item/rogueweapon/sword/sabre/midsomber/proc/furioso_dashthrough(mob/living/user, mob/living/target, list/weapon_data, heavy)
	var/color = "#530505"
	var/beam_color = color
	var/victim = target
	var/damage = 100
	lefthand_file = 'icons/mob/inhands/48x48_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/48x48_righthand.dmi'
	inhand_x_dimension = 48
	inhand_y_dimension = 48
	var/effect_type = heavy ? /obj/effect/temp_visual/smash_effect/red : /obj/effect/temp_visual/dir_setting/slash/red
	for(var/i in 1 to weapon_data["hits"])
		if(QDELETED(src) || QDELETED(user) || QDELETED(target))
			return
		// Dash through target to the other side
		var/turf/dest = get_ranged_target_turf_direct(user, target, get_dist(user, target) + 2)
		if(!dest)
			dest = get_turf(target)
		furioso_dash_to(user, dest, target, beam_color)
		arcyne_strike(user, victim, held_weapon, damage, def_zone, BCLASS_CUT)
		furioso_hit(user, target, weapon_data, effect_type)
		if(heavy)
			shake_camera(target, 1, 2)
		sleep(0.3 SECONDS)
	sleep(0.2 SECONDS)

/// Rapier: retreat then lunge from distance for each hit
/obj/item/rogueweapon/sword/sabre/midsomber/proc/furioso_lunge(mob/living/user, mob/living/target, list/weapon_data)
	var/color = "#530505"
	var/beam_color = color
	var/victim = target
	var/damage = 50
	lefthand_file = 'icons/mob/inhands/48x48_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/48x48_righthand.dmi'
	inhand_x_dimension = 48
	inhand_y_dimension = 48
	for(var/i in 1 to weapon_data["hits"])
		if(QDELETED(src) || QDELETED(user) || QDELETED(target))
			return
		// Retreat to 3 tiles away
		var/turf/retreat = get_ranged_target_turf_direct(target, user, 3)
		if(retreat)
			user.forceMove(retreat)
			user.dir = get_dir(user, target)
		sleep(0.1 SECONDS)
		// Lunge in
		var/turf/dest = get_step(target.loc, get_dir(user, target))
		if(!dest)
			dest = get_turf(target)
		furioso_dash_to(user, dest, target, beam_color)
		furioso_hit(user, target, weapon_data, /obj/effect/temp_visual/slice/red)
		arcyne_strike(user, victim, held_weapon, damage, def_zone, BCLASS_PIERCE)
		sleep(0.2 SECONDS)
	sleep(0.2 SECONDS)

/// Hammer: leap from above with pixel animation and camera shake
/obj/item/rogueweapon/sword/sabre/midsomber/proc/furioso_leapsmash(mob/living/user, mob/living/target, list/weapon_data, list/colors)
	lefthand_file = 'icons/mob/inhands/48x48_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/48x48_righthand.dmi'
	inhand_x_dimension = 48
	inhand_y_dimension = 48
	var/damage = 40
	var/victim = target
	for(var/i in 1 to weapon_data["hits"])
		if(QDELETED(src) || QDELETED(user) || QDELETED(target))
			return
		// Afterimage + animate upward and fade out
		new /obj/effect/temp_visual/decoy/fading/halfsecond(get_turf(user), user)
		animate(user, 0.3 SECONDS, easing = QUAD_EASING, pixel_y = user.base_pixel_y + 16, alpha = 0)
		sleep(0.3 SECONDS)
		if(QDELETED(src) || QDELETED(user) || QDELETED(target))
			return
		// Land next to target
		var/turf/dest = get_step(target.loc, pick(GLOB.cardinals))
		if(!dest)
			dest = get_turf(target)
		user.forceMove(dest)
		user.dir = get_dir(user, target)
		// Slam down from above
		user.pixel_y = user.base_pixel_y + 16
		animate(user, 0.15 SECONDS, easing = QUAD_EASING, pixel_y = user.base_pixel_y, alpha = 255)
		sleep(0.15 SECONDS)
		furioso_hit(user, target, weapon_data, /obj/effect/temp_visual/smash_effect/red)
		arcyne_strike(user, victim, held_weapon, round(damage / 2), def_zone, BCLASS_BLUNT)
		shake_camera(target, 1.5, 3)
		sleep(0.3 SECONDS)
	sleep(0.2 SECONDS)

/// Lance: charge from distance through target
/obj/item/rogueweapon/sword/sabre/midsomber/proc/furioso_charge(mob/living/user, mob/living/target, list/weapon_data)
	var/color = "#551515"
	var/beam_color = color
	var/victim = target
	var/damage = 95
	lefthand_file = 'icons/mob/inhands/64x64_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/64x64_righthand.dmi'
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	for(var/i in 1 to weapon_data["hits"])
		if(QDELETED(src) || QDELETED(user) || QDELETED(target))
			return
		// Position 4 tiles away
		var/turf/retreat = get_ranged_target_turf_direct(target, user, 4)
		if(retreat)
			user.forceMove(retreat)
			user.dir = get_dir(user, target)
		new /obj/effect/temp_visual/decoy/fading/halfsecond(get_turf(user), user)
		sleep(0.15 SECONDS)
		if(QDELETED(src) || QDELETED(user) || QDELETED(target))
			return
		// Charge through target
		var/turf/dest = get_ranged_target_turf_direct(user, target, get_dist(user, target) + 2)
		if(!dest)
			dest = get_turf(target)
		furioso_dash_to(user, dest, target, beam_color)
		furioso_hit(user, target, weapon_data, /obj/effect/temp_visual/smash_effect/red)
		arcyne_strike(user, victim, held_weapon, damage, def_zone, BCLASS_PIERCE)
		sleep(0.3 SECONDS)
	sleep(0.2 SECONDS)

/// Whip: stay at range and lash with beam visuals
/obj/item/rogueweapon/sword/sabre/midsomber/proc/furioso_ranged(mob/living/user, mob/living/target, list/weapon_data)
	var/color = "#5c0e0e"
	var/beam_color = color
	var/victim = target
	var/damage = 60
	lefthand_file = 'icons/mob/inhands/48x48_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/48x48_righthand.dmi'
	inhand_x_dimension = 48
	inhand_y_dimension = 48
	// Position at 3 tiles away
	var/turf/range_pos = get_ranged_target_turf_direct(target, user, 3)
	if(range_pos && get_dist(user, target) != 3)
		furioso_dash_to(user, range_pos, target, beam_color)
	for(var/i in 1 to weapon_data["hits"])
		if(QDELETED(src) || QDELETED(user) || QDELETED(target))
			return
		// Beam lash from user to target represents the whip
		var/turf/user_turf = get_turf(user)
		var/datum/beam/lash = user_turf.Beam(target, "1-full", time = 3)
		if(lash && beam_color)
			lash.visuals.color = beam_color
		furioso_hit(user, target, weapon_data, /obj/effect/temp_visual/slice/red)
		arcyne_strike(user, victim, held_weapon, damage, def_zone, BCLASS_CUT)
		sleep(0.4 SECONDS)
	sleep(0.2 SECONDS)

/// Scythe: dramatic finisher leap (thumb-style fade out, teleport, slam in)
/obj/item/rogueweapon/sword/sabre/midsomber/proc/furioso_reap(mob/living/user, mob/living/target, list/weapon_data, list/colors)
	if(QDELETED(src) || QDELETED(user) || QDELETED(target))
		return
	lefthand_file = 'icons/mob/inhands/64x64_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/64x64_righthand.dmi'
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	var/victim = target
	var/damage = 500 //lol
	// Afterimage at origin
	new /obj/effect/temp_visual/decoy/fading/halfsecond(get_turf(user), user)

	// Fade out with upward arc toward target
	var/horizontal_difference = target.x - user.x
	var/x_offset = 0
	if(horizontal_difference > 0)
		x_offset = 32
	else if(horizontal_difference < 0)
		x_offset = -32
	animate(user, 0.4 SECONDS, easing = QUAD_EASING, pixel_y = user.base_pixel_y + 16, pixel_x = user.base_pixel_x + x_offset, alpha = 0)
	sleep(0.4 SECONDS)
	if(QDELETED(src) || QDELETED(user) || QDELETED(target))
		return

	// Teleport to target
	var/turf/dest = get_step(target.loc, pick(GLOB.cardinals))
	if(!dest)
		dest = get_turf(target)
	user.forceMove(dest)
	user.dir = get_dir(user, target)

	// Slam in from opposite direction (appear to come from where we started)
	user.pixel_x = user.base_pixel_x + (x_offset * -2)
	user.pixel_y = user.base_pixel_y + 16
	animate(user, 0.2 SECONDS, easing = QUAD_EASING, pixel_y = user.base_pixel_y, pixel_x = user.base_pixel_x, alpha = 255)
	sleep(0.2 SECONDS)

	// Final strike
	furioso_hit(user, target, weapon_data, /obj/effect/temp_visual/smash_effect/red)
	arcyne_strike(user, victim, held_weapon, damage, def_zone, BCLASS_CUT)
	shake_camera(target, 2, 4)
	sleep(0.3 SECONDS)

/obj/item/rogueweapon/sword/sabre/midsomber/proc/furioso_end(mob/living/user, list/targets)
	user.status_flags &= ~GODMODE
	user.AdjustStun(-60 SECONDS, ignore_canstun = TRUE)
	user.anchored = FALSE
	REMOVE_TRAIT(src, TRAIT_NODROP, TRAIT_GENERIC)

	// Ensure pixel position and alpha are reset (leapsmash/reap use animate())
	user.pixel_x = user.base_pixel_x
	user.pixel_y = user.base_pixel_y
	user.alpha = 255

	for(var/mob/living/L in targets)
		L.AdjustStun(-60 SECONDS, ignore_canstun = TRUE)
		REMOVE_TRAIT(L, TRAIT_MUTE, TIMESTOP_TRAIT)
		if(isanimal(L))
			var/mob/living/simple_animal/S = L
			S.toggle_ai(initial(S.AIStatus))

	// Replace with a fresh base lance to fully reset force/damtype/w_class/etc.
	var/obj/item/rogueweapon/sword/sabre/midsomber/new_lance = new /obj/item/rogueweapon/sword/sabre/midsomber(user.drop_location())
	to_chat(user, span_notice("Funeral complete. The lance returns to its inactive state."))
	qdel(src)
	user.put_in_hands(new_lance)
