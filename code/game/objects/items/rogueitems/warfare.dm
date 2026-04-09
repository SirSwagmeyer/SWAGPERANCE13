/obj/item/sandbag
	name = "sandbags"
	icon_state = "sandbag_pile"
	icon = 'icons/roguetown/items/misc.dmi'
	desc = "A pile of sandbags. Wire included."
	lefthand_file = null
	righthand_file = null
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_MOUTH

/obj/item/barbedwire
	name = "barbed wire"
	icon_state = "barbwire_item"
	icon = 'icons/roguetown/items/misc.dmi'
	desc = "A stack of barbed wire! Be careful."
	lefthand_file = null
	righthand_file = null
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_MOUTH

/obj/item/landmine
	name = "landmine"
	icon_state = "mine_disarmed"
	icon = 'icons/roguetown/items/misc.dmi'
	desc = "A disarmed landmine. Handle with care."
	lefthand_file = null
	righthand_file = null
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_MOUTH

/obj/item/frogmine
	name = "frogmine"
	icon_state = "frogmine_disarmed"
	icon = 'icons/roguetown/items/misc.dmi'
	desc = "A disarmed frogmine. While once exclusively found in the WAR MACHINE - Imperial & Dictate production facilities have since managed to replicate & mass produce the design."
	lefthand_file = null
	righthand_file = null
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_MOUTH
	grid_width = 32
	grid_height = 64

/obj/item/frogmine/afterattack(var/atom/A, var/mob/user, proximity)
	..()
	if(proximity == 1)
		if(isturf(A) && ismob(user))
			var/turf/T = A
			var/mob/M = user
			if(istype(T, /turf/open/floor/rogue/dirt/) || istype(T, /turf/open/floor/rogue/grass/))
				for(var/obj/effect/frogmine/S in A)
					if(istype(S))
						to_chat(usr, span_warning("There's already a frogmine here!"))
						return
				playsound(loc,'sound/items/dig_shovel.ogg', 100, TRUE)
				M.visible_message(span_notice("[user] begins to plant [src]..."), span_notice("You begin to plant [src]..."))
				if(do_after(user, 3 SECONDS, target = T))
					M.visible_message(span_notice("[user] plants [src] in the ground."), span_notice("You finish planting [src]."))
					playsound(loc,'sound/items/empty_shovel.ogg', 100, TRUE)
					new /obj/effect/frogmine(A)
					qdel(src)
			else
				to_chat(usr, span_warning("This can only be planted in the dirt!"))
