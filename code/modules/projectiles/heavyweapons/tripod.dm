///////////////////////////////
////TRIPODS FOR MACHINEGUNS////
///////////////////////////////

/obj/item/mg_tripod
	name = "stationary machinegun tripod"
	icon = 'icons/obj/stationary_guns.dmi'
	icon_state = "basic-mg-tripod"
	w_class = WEIGHT_CLASS_NORMAL
	anchored = 0
	density = 0
	var/id_g = "bmg"
	var/need_type = /obj/item/gun/ballistic/heavy_mg

/obj/item/mg_tripod/attackby(var/obj/item/A, var/mob/user)
	..()
	if(istype(A, /obj/item/mg_disassembled))
		var/obj/item/mg_disassembled/MG = A
		make_machinegun(MG, user)

/obj/item/mg_tripod/afterattack(var/atom/A, var/mob/user, proximity)
	..()
	if(isturf(A) && ismob(user))
		var/turf/T = A
		var/mob/M = user
		if(in_range(T, user) && do_after(user, 20, src))
			playsound(src, 'sound/items/hw_tripod.ogg', 50, 1)
			attach_to_turf(T, M, 1)

/obj/item/mg_tripod/MouseDrop(over_object, src_location, over_location)
	..()

	if(over_object == usr)
		playsound(src, 'sound/items/hw_tripod.ogg', 50, 1)
		if(in_range(src.loc, usr) && do_after(usr, 20, src))
			detach_from_turf(usr, 1)

		return

/obj/item/mg_tripod/attack_hand(mob/user)
	if(anchored)
		return

	return ..()

/obj/item/mg_tripod/proc/attach_to_turf(var/turf/T, var/mob/M, var/show_message = 0)
	if(!isturf(T) || !ismob(M))
		return

	M.transferItemToLoc(src)
	forceMove(T)
	setDir(M.dir)
	anchored = 1
	density = 1
	icon_state = "[initial(icon_state)]-turf"
	if(show_message)
		M.visible_message("<span class='notice'>[M.name] attached to ground \the tripod.</span>")


/obj/item/mg_tripod/proc/detach_from_turf(var/mob/M, var/show_message = 0)
	if(!ismob(M))
		return

	anchored = 0
	density = 0
	icon_state = initial(icon_state)
	if(show_message)
		M.visible_message("<span class='notice'>[M.name] detached from ground \the tripod.</span>")

/obj/item/mg_tripod/proc/make_machinegun(var/obj/item/mg_disassembled/MG, var/mob/user)
	if(!MG || !istype(MG) || !ismob(user))
		return

	if(src.id_g != MG.id_g)
		to_chat(user, "You can't attach [MG.name] to [src.name].")
		return

	if(!anchored)
		return

	var/obj/item/gun/ballistic/heavy_mg/machinegun = new need_type(src.loc, src.dir)
	machinegun.disassembled = MG
	playsound(src, 'sound/items/hw_weapon.ogg', 50, 1)
	machinegun.tripod = src
	user.transferItemToLoc(MG)
	MG.forceMove(machinegun)
	src.forceMove(machinegun)


/obj/item/mg_tripod/spandau
	name = "'Spandau' tripod"
	icon_state = "spandau-tripod"
	id_g = "spd"
	need_type = /obj/item/gun/ballistic/heavy_mg/spandau

/obj/item/mg_tripod/mark1
	name = "'Mark 1' tripod"
	icon_state = "mark1-tripod"
	id_g = "mk1"
	need_type = /obj/item/gun/ballistic/heavy_mg/mark1

/obj/item/mg_tripod/m2
	name = "M2 tripod"
	icon_state = "nato-tripod" //  fix //FIX! ~JTB
	id_g = "mbr"
	need_type = /obj/item/gun/ballistic/heavy_mg/m2
