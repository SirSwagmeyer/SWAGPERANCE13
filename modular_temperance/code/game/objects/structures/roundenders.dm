// ! be careful when placing these - having them be interacted/destroyed WILL end the round

/obj/structure/round_ender
	name = "ANCHOR"
	desc = "A computer that allows for communication between the Rebels. Breaking this results in a Rebel Defeat."
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "roundender"
	break_sound = 'sound/foley/machinebreak.ogg'
	attacked_sound = list('sound/misc/drillhit.ogg')
	var/attacked = FALSE

/obj/structure/round_ender/attackby(obj/item/I, mob/living/user, params)
	if(!istype(I, /obj/item/rogueweapon))
		return	

	if(I.d_type != BCLASS_BLUNT)
		return

	..()

	user.changeNext_move(CLICK_CD_INTENTCAP)

	if(!attacked)
		for(var/mob/M in GLOB.player_list)
			to_chat(M, span_userdanger("SOMEONE IS ATTACKING THE REBELLION'S ANCHOR!!!"))
			M.playsound_local(M, 'sound/misc/alarm_outdoors.ogg', 120, TRUE)
		attacked = TRUE
	return ..()

/obj/structure/round_ender/Destroy()
	for(var/mob/M in GLOB.player_list)
		to_chat(M, span_userdanger("The Rebellion's ANCHOR has been crushed - the Protectorate triumphs once again!"))
		to_chat(M, span_info("The Round ends in 3 minutes."))
	sleep(3 MINUTES)
	SSticker.force_ending = 1
	..()
