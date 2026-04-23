/obj/item/needle/touch_attack
	name = "\improper outstretched hand"
	desc = ""
	var/catchphrase = "High Five!"
	var/on_use_sound = null
	var/obj/effect/proc_holder/spell/targeted/touch/attached_spell
	icon = 'icons/obj/balloons.dmi'
	lefthand_file = 'icons/mob/inhands/misc/touchspell_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/touchspell_righthand.dmi'
	icon_state = "syndballoon"
	item_state = null
	item_flags = NEEDS_PERMIT | ABSTRACT | DROPDEL
	w_class = WEIGHT_CLASS_HUGE
	force = 0
	throwforce = 0
	throw_range = 0
	throw_speed = 0
	var/charges = 1

/obj/item/needle/touch_attack/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, ABSTRACT_ITEM_TRAIT)

/obj/item/needle/touch_attack/attack(mob/target, mob/living/carbon/user)
	if(!iscarbon(user)) //Look ma, no hands
		return
	if(!(user.mobility_flags & MOBILITY_USE))
		to_chat(user, "<span class='warning'>I can't reach out!</span>")
		return
	..()

/obj/item/needle/touch_attack/afterattack(atom/target, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	user.say(catchphrase, forced = "spell")
	charges--
	if(charges <= 0)
		qdel(src)

/obj/item/needle/touch_attack/Destroy()
	if(attached_spell)
		playsound(get_turf(src), on_use_sound,50,TRUE)
		attached_spell.on_hand_destroy(src)
	return ..()


/obj/effect/proc_holder/spell/targeted/touch/bloodneedle
	name = "Blood Needle"
	desc = "A simple spell used to harden blood into an instrument for sewing."
	clothes_req = FALSE
	drawmessage = "I pool blood from under my nails and shape it into a needle."
	dropmessage = "The needle liquidizes into blood once more, falling to the ground."
	school = "transmutation"
	overlay_state = "blood_needle"
	chargedrain = 0
	chargetime = 0
	releasedrain = 5
	chargedloop = /datum/looping_sound/invokeblood
	associated_skill = /datum/skill/magic/blood
	hand_path = /obj/item/needle/touch_attack/bloodneedle
	invocation_type = "none"
	hide_charge_effect = TRUE

/obj/item/needle/touch_attack/bloodneedle
	name = "blood needle"
	desc = "A needle made of hardened blood, extending from my fingertips. The 'thread' is just fine strands of thick, firm blood."
	icon = 'icons/roguetown/items/misc.dmi'
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'	
	icon_state = "needle"
	catchphrase = null
	charges = 3
	on_use_sound = 'sound/magic/blood_needle_use.ogg'
	w_class = WEIGHT_CLASS_TINY
	infinite = TRUE
	can_repair = TRUE
	color = "#9b2020"
	anvilrepair = null

/obj/effect/proc_holder/spell/targeted/touch/bloodneedle/cast(list/targets, mob/user)
	if(!QDELETED(attached_hand))
		remove_hand(TRUE)
		to_chat(user, span_notice("[dropmessage]"))
		return

	for(var/mob/living/carbon/C in targets)
		if(!attached_hand)
			if(ChargeHand(C))
				playsound(get_turf(user), 'sound/magic/blood_needle.ogg', 50, TRUE)
				return
