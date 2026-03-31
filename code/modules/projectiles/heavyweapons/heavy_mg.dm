/datum/intent/shoot/heavy_mg
	chargedrain = 0
	no_early_release = TRUE

/////////////////////////////
////Basic heavy MG///////////
/////////////////////////////
//this thing is portable object which will fire.



/obj/item/gun/ballistic/heavy_mg //nonfunctional parent
	name = "staionary machinegun"
	desc = "basic heavy machinegun."
	icon = 'icons/obj/stationary_guns.dmi'
	icon_state = "basic-mg"
	item_state = ""
	layer = ABOVE_OBJ_LAYER + 0.11
	anchored = 1
	density = 1
	w_class = WEIGHT_CLASS_GIGANTIC
	dist_fire_sound = DISTANTHMG
	far_volume = 60 // 60 is max, loudest guns for fun
	spawnwithmagazine = FALSE
	semi_auto = TRUE
	burst = 3
	possible_item_intents = list(/datum/intent/shoot/heavy_mg)
	var/pump_sound = 'sound/combat/ranged/riflecock.ogg'

	var/user_old_x = 0
	var/user_old_y = 0
	var/mob/used_by_mob = null
	var/obj/item/mg_disassembled/disassembled = null
	var/obj/item/mg_tripod/tripod = null

/obj/item/gun/ballistic/heavy_mg/process_chamber(mob/living/user, empty_chamber = 0)
	return ..() //changed argument value

/obj/item/gun/ballistic/heavy_mg/process_chamber(empty_chamber = TRUE, from_firing = TRUE, chamber_next_round = TRUE)
	if(!semi_auto && from_firing)
		return
	if(semi_auto|automatic && chambered)
		chambered.forceMove(drop_location())//Eject casing
		chambered.bounce_away()
		chambered = null
		update_icon()
		if (chamber_next_round && (magazine?.max_ammo > 1))
			chamber_round()
			update_icon()

/obj/item/gun/ballistic/heavy_mg/proc/pump(mob/M, visible = TRUE)
	if(visible)
		M.visible_message("<span class='warning'>[M] racks [src].</span>", "<span class='warning'>You rack [src].</span>")
	playsound(M, pump_sound, 60, 1)
	pump_unload(M)
	pump_reload(M)
	update_icon()	//I.E. fix the desc
	return 1

/obj/item/gun/ballistic/heavy_mg/proc/pump_unload(mob/M)
	if(chambered)//We have a shell in the chamber
		chambered.forceMove(drop_location())//Eject casing
		chambered.bounce_away()
		chambered = null

/obj/item/gun/ballistic/heavy_mg/proc/pump_reload(mob/M)
	if(!magazine.ammo_count())
		return 0
	var/obj/item/ammo_casing/AC = magazine.get_round() //load next casing.
	chambered = AC

/obj/item/gun/ballistic/heavy_mg/New(loc, var/direction)
	..()
	if(direction)
		setDir(direction)
	if(!tripod)
		tripod = new/obj/item/mg_tripod
	if(!disassembled)
		disassembled = new/obj/item/mg_disassembled

	update_layer()

/obj/item/gun/ballistic/heavy_mg/Destroy()
	if(used_by_mob)
		stopped_using(used_by_mob, 0)

	var/turf/T = get_turf(src)

	if(isturf(T))
		if(disassembled)
			disassembled.forceMove(T)
			disassembled = null

		if(tripod)
			tripod.forceMove(T)
			tripod = null
	..()

/obj/item/gun/ballistic/heavy_mg/afterattack(atom/A, mob/user)
	if(check_direction(user, A))
		return ..() //fire gun
	else
		rotate_to(user, A)
		update_layer()
		return

/obj/item/gun/ballistic/heavy_mg/CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
	if(istype(mover, /obj/projectile))
		return 1
	return 0

/obj/item/gun/ballistic/heavy_mg/MouseDrop(over_object, src_location, over_location)
	..()
	if(src.magazine)
		if((over_object == usr && in_range(src, usr)) && !used_by_mob)
			eject_magazine(usr, 0)
			return
	if(over_object == usr)
		playsound(src, 'sound/items/hw_tripod.ogg', 50, 1)
		if(in_range(src.loc, usr) && do_after(usr, 20, src))
			detach_tripod(usr)
	return


/obj/item/gun/ballistic/heavy_mg/attack_hand(mob/user)
	var/grip_dir = reverse_direction(dir)
	var/turf/T = get_step(src.loc, grip_dir)
	if(user.loc == T)
		if(user.get_active_held_item() == null && user.get_inactive_held_item() == null)
			started_using(user)

		else
			to_chat(user, "\red Your hands are busy by holding things.")

	else
		to_chat(user, "\red You're too far from the handles.")

/obj/item/gun/ballistic/heavy_mg/attack_right(mob/user)
	if(user.get_active_held_item() == null)
		if(src.magazine)
			INVOKE_ASYNC(src, PROC_REF(pump), user)
		else return

/obj/item/gun/ballistic/heavy_mg/proc/update_layer()
	if(dir == NORTH)
		layer = initial(layer) + 0.1
		plane = initial(plane)
//	else if(dir == SOUTH)
//		layer = initial(layer) + 0.1
//		plane = initial(plane)
	else
		layer = ABOVE_MOB_LAYER + 0.1 //above sandbag

/*
	if(dir != SOUTH)
		layer = initial(layer) + 0.1
		plane = initial(plane)
	else
		layer = ABOVE_OBJ_LAYER + 0.1
		plane = ABOVE_HUMAN_PLANE
		*/

/obj/item/gun/ballistic/heavy_mg/proc/check_direction(mob/user, atom/A)
	if(get_turf(A) == src.loc)
		return 0

	var/shot_dir = get_cardinal_dir(src, A)
	if(shot_dir != dir)
		return 0

	return 1

/obj/item/gun/ballistic/heavy_mg/proc/rotate_to(mob/user, atom/A)
	if(!A || !user.x || !user.y || !A.x || !A.y)
		return  
	var/dx = A.x - user.x
	var/dy = A.y - user.y
	if(!dx && !dy)
		to_chat (user, "<span class='warning'>Can't turn.</span>")
		return

	var/direction
	if(abs(dx) < abs(dy))
		if(dy > 0)
			direction = NORTH
		else
			direction = SOUTH
	else
		if(dx > 0)
			direction = EAST
		else
			direction = WEST

	if(/obj/structure/fluff/railing/sandbag in src.loc.contents)
		var/obj/structure/fluff/railing/sandbag/S = locate(src.loc.contents)
		if(direction == reverse_direction(S.dir))
			to_chat(user, "<span class='notice'>You can't rotate it in that way!</span>")
			return 0

	src.setDir(direction)
	user.setDir(direction)
	update_pixels(user)

	return 0

/obj/item/gun/ballistic/heavy_mg/proc/update_pixels(mob/user as mob)
	var/diff_x = 0
	var/diff_y = 0
	if(dir == EAST)
		diff_x = -16 + user_old_x
	if(dir == WEST)
		diff_x = 16 + user_old_x
	if(dir == NORTH)
		diff_y = -16 + user_old_y
	if(dir == SOUTH)
		diff_y = 16 + user_old_y
	animate(user, pixel_x=diff_x, pixel_y=diff_y, 4, 1)

/obj/item/gun/ballistic/heavy_mg/proc/started_using(mob/user as mob, var/need_message = 1)
	var/mob/living/M = user
	if(!(M.mobility_flags & MOBILITY_STAND))	
		return
	if(need_message)
		user.visible_message("<span class='notice'>[user.name] handeled \the [src].</span>", \
							 "<span class='notice'>You handeled \the [src].</span>")
	used_by_mob = user
	user.using_object = src
	user.forceMove(src.loc)
	user.setDir(src.dir)
	M.mobility_flags &= ~MOBILITY_MOVE
	M.mobility_flags &= ~MOBILITY_PICKUP
	user.update_a_intents()
	user_old_x = user.pixel_x
	user_old_y = user.pixel_y
	update_pixels(user)

/obj/item/gun/ballistic/heavy_mg/proc/stopped_using(mob/user as mob, var/need_message = 1)
	if(need_message)
		user.visible_message("<span class='notice'>[user.name] released \the [src].</span>", \
							 "<span class='notice'>You released \the [src].</span>")
	var/mob/living/M = user
	used_by_mob = null
	user.using_object = null
	M.mobility_flags |= MOBILITY_MOVE
	M.mobility_flags |= MOBILITY_PICKUP
	var/grip_dir = reverse_direction(dir)
	var/old_dir = dir
	step(user, grip_dir)
	animate(user, pixel_x=user_old_x, pixel_y=user_old_y, 4, 1)
	user_old_x = 0
	user_old_y = 0
	user.dir = old_dir // visual better
	user.update_vision_cone()
	user.update_a_intents()

/obj/item/gun/ballistic/heavy_mg/proc/detach_tripod(var/mob/user)
	if(!disassembled || !tripod || !ismob(user))
		return

	var/turf/T = get_turf(src.loc)
	tripod.forceMove(T)
	tripod.detach_from_turf(T, user, 0)
	disassembled.forceMove(T)
	playsound(src, 'sound/items/hw_weapon.ogg', 50, 1)
	user.put_in_hands(disassembled)
	tripod = null
	disassembled = null
	qdel(src)




/*
/obj/item/gun/ballistic/heavy_mg/verb/detach_from_tripod()
	set name = "Detach from tripod"
	set category = "Object"
	set src in view(1)

	if(magazine)
		to_chat(usr, "You need to unload [name] first!")
		return

	detach_tripod(usr)
*/
//////////////////////
///UTES///////////////
//////////////////////
/obj/item/gun/ballistic/heavy_mg/mark1
	name = "'Mark 1' HMG"
	desc = "A top of the line, universally feared machine-produced heavy machine gun. The national Risvon WAR machine very rarely produces these things."
	icon_state = "utes"
	mag_type = /obj/item/ammo_box/magazine/hmg/a303
	fire_sound = HMGGENERICSHOT

/obj/item/gun/ballistic/heavy_mg/mark1/update_icon()
	..()
	if(magazine)
		icon_state = "mark1"
	else
		icon_state = "mark1-empty"

/obj/item/gun/ballistic/heavy_mg/spandau
	name = "'Spandau' HMG"
	desc = "The feared 'Spandau' heavy machine gun. The rare pieces of machine-produced production the Imperials can get their hands on go into weapons like this."
	icon_state = "spandau"
	mag_type = /obj/item/ammo_box/magazine/hmg/a762x59
	fire_sound = HMGGENERICSHOT

/obj/item/gun/ballistic/heavy_mg/spandau/update_icon()
	..()
	if(magazine)
		icon_state = "spandau"
	else
		icon_state = "spandau-empty"

//////////////////////////////
////////////M2BROWNING/////////
//////////////////////////////

/obj/item/gun/ballistic/heavy_mg/m2
	name = "M2"
	desc = "A slick, top of the line War Machine production. Fires .50D. This, this is power."
	icon_state = "m2"
	mag_type = /obj/item/ammo_box/magazine/hmg/a50d
	fire_sound = HMGM2SHOT
	burst = 2

/obj/item/gun/ballistic/heavy_mg/m2/update_icon()
	..()
	if(magazine)
		icon_state = "m2"
	else
		icon_state = "m2-empty"
