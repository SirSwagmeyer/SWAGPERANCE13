/obj/structure/barbedwire
	name = "barbed wire"
	desc = "Don't touch this. Cut with a knife."
	icon_state = "barbwire"
	can_buckle = TRUE
	icon = 'icons/roguetown/misc/structure.dmi'
	density = FALSE
	anchored = TRUE
	can_buckle = FALSE
	max_integrity = 150
	buckle_lying = 90
	layer = 2.8

/obj/structure/barbedwire/Crossed(atom/movable/AM)
	var/hitsound = pick('sound/combat/hits/bladed/genstab (1).ogg', 'sound/combat/hits/bladed/genstab (2).ogg', 'sound/combat/hits/bladed/genstab (3).ogg')
	// TO DO: figure out how to either make jumping its own special proc
	// Or read throw_at to understand how to parse it here to allow jumping

	if(isliving(AM))
		var/mob/living/L = AM
		if(L.movement_type & (FLYING|FLOATING)) //don't close the trap if they're flying/floating over it.
			return ..()

	if(ishuman(AM))
		var/mob/living/carbon/human/H = AM
		var/area = BODY_ZONE_L_LEG
		if(prob(50))
			area = BODY_ZONE_R_LEG
		var/obj/item/bodypart/affecting = H.get_bodypart(check_zone(area))
		if(!affecting) //if somehow no legs
			affecting =  H.get_bodypart(check_zone(BODY_ZONE_CHEST))

		//Wounds bleed pretty slow alone so this is more to be annoying than dangerous.
		var/damage = 30
		affecting.receive_damage(damage)
		var/datum/wound/choice = /datum/wound/puncture
		if(prob(25))
			choice = /datum/wound/puncture/large
		affecting.add_wound(choice)
		H.forceMove(drop_location())

		H.emote("painscream")
		var/delay = 20 - H.STACON // Might be too long, if you figure out a better answer let me know.
		delay = delay * 10
		//H.Paralyze(delay)
		buckle_mob(H, TRUE)
		H.clear_alert("buckled") //easiest way to hide this option. Have to click the pit with a free hand to get loose.
		playsound(src.loc, hitsound, 100)
		return

	if(istype(AM, /mob/living/simple_animal))
		var/mob/living/simple_animal/L = AM
		L.adjustHealth(40)
		L.Paralyze(40)
		buckle_mob(L, TRUE)
		L.get_sound("pain")
		playsound(src.loc, hitsound, 100)
		return

	. = ..()

/obj/structure/barbedwire/attack_hand(mob/user)
	if(has_buckled_mobs())
		var/person = buckled_mobs[1].name
		if(user == buckled_mobs[1])
			person = "themself"
		user.visible_message(span_warning("[user.name] starts to pull [person] off \the [name]..."))
		if(do_after(user, 3 SECONDS))
			unbuckle_mob(buckled_mobs[1], TRUE)
			user.visible_message(span_warning("[user.name] pulls [person] out of the spikes."))
	. = ..()



//mouths
/obj/structure/mouths
	name = "mouths"
	desc = ""
	can_buckle = TRUE
	density = FALSE
	anchored = TRUE
	can_buckle = FALSE
	max_integrity = 150
	buckle_lying = 90
	layer = 2.8
	alpha = 0

/obj/structure/mouths/Crossed(atom/movable/AM)
	var/hitsound = pick('sound/foley/scream.ogg', 'sound/foley/splatty.ogg', 'sound/foley/mosb_bite.ogg')
	// TO DO: figure out how to either make jumping its own special proc
	// Or read throw_at to understand how to parse it here to allow jumping

	if(isliving(AM))
		var/mob/living/L = AM
		if(L.movement_type & (FLYING|FLOATING)) //don't close the trap if they're flying/floating over it.
			return ..()

	if(ishuman(AM))
		var/mob/living/carbon/human/H = AM
		var/area = BODY_ZONE_L_LEG
		if(prob(50))
			area = BODY_ZONE_R_LEG
		var/obj/item/bodypart/affecting = H.get_bodypart(check_zone(area))
		if(!affecting) //if somehow no legs
			affecting =  H.get_bodypart(check_zone(BODY_ZONE_CHEST))

		//Wounds bleed pretty slow alone so this is more to be annoying than dangerous.
		var/damage = 30
		affecting.receive_damage(damage)
		var/datum/wound/choice = /datum/wound/puncture
		if(prob(25))
			choice = /datum/wound/puncture/large
		affecting.add_wound(choice)
		H.forceMove(drop_location())

		H.emote("painscream")
		var/delay = 20 - H.STACON // Might be too long, if you figure out a better answer let me know.
		delay = delay * 10
		H.Paralyze(delay) //get fucked
		buckle_mob(H, TRUE)
		playsound(src.loc, hitsound, 100)
		return

	if(istype(AM, /mob/living/simple_animal))
		var/mob/living/simple_animal/L = AM
		L.adjustHealth(40)
		L.Paralyze(40)
		buckle_mob(L, TRUE)
		L.get_sound("pain")
		playsound(src.loc, hitsound, 100)
		return

	. = ..()

/obj/structure/mouths/attack_hand(mob/user)
	if(has_buckled_mobs())
		var/person = buckled_mobs[1].name
		if(user == buckled_mobs[1])
			person = "themself"
		user.visible_message(span_warning("[user.name] starts to pull [person] off \the [name]..."))
		if(do_after(user, 3 SECONDS))
			unbuckle_mob(buckled_mobs[1], TRUE)
			user.visible_message(span_warning("[user.name] pulls [person] out of the spikes."))
	. = ..()
