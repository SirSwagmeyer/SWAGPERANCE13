/obj/effect/proc_holder/spell/invoked/holding
	name = "Hold Ranks"
	desc = "Order those around to to bundle together, increasing durability for a while."
	cost = 3
	xp_gain = FALSE
	chargetime = 10
	recharge_time = 60 SECONDS
	movement_interrupt = FALSE
	charging_slowdown = 2
	chargedloop = /datum/looping_sound/invokeradio
	associated_skill = /datum/skill/magic/arcane
	req_items = list(/obj/item/clothing/head/roguetown/paddedcap/radio, /obj/item/storage/backpack/rogue/satchel/radiopack)
	overlay_state = "repulse"
	spell_tier = 2
	invocation = "FORM RANKS AROUND ME!"
	invocation_type = "shout"
	gesture_required = TRUE
	antimagic_allowed = TRUE
	var/order_range = 7

/obj/effect/proc_holder/spell/invoked/holding/cast(list/targets,mob/user = usr)
	. = ..()
	for(var/mob/living/carbon/human/orderedguy in (get_hearers_in_view(order_range, user) - user))
		if(isliving(orderedguy))
			if(orderedguy.job in GLOB.perserdun_positions)
				orderedguy.apply_status_effect(/datum/status_effect/buff/order/hold)
			else
				return
	return TRUE

/obj/effect/proc_holder/spell/invoked/aim
	name = "Take Aim"
	desc = "Order those around to focus on hitting their shots."
	cost = 3
	xp_gain = FALSE
	chargetime = 10
	recharge_time = 60 SECONDS
	movement_interrupt = FALSE
	charging_slowdown = 2
	chargedloop = /datum/looping_sound/invokeradio
	associated_skill = /datum/skill/magic/arcane
	req_items = list(/obj/item/clothing/head/roguetown/paddedcap/radio, /obj/item/storage/backpack/rogue/satchel/radiopack)
	overlay_state = "repulse"
	spell_tier = 2
	invocation = "TAKE AIM!"
	invocation_type = "shout"
	gesture_required = TRUE
	antimagic_allowed = TRUE
	var/order_range = 7

/obj/effect/proc_holder/spell/invoked/aim/cast(list/targets,mob/user = usr)
	. = ..()
	for(var/mob/living/carbon/human/orderedguy in (get_hearers_in_view(order_range, user) - user))
		if(isliving(orderedguy))
			if(orderedguy.job in GLOB.perserdun_positions)
				orderedguy.apply_status_effect(/datum/status_effect/buff/order/takeaim)
			else
				return
	return TRUE

/obj/effect/proc_holder/spell/invoked/charge
	name = "CHARGE!"
	desc = "ORDER THOSE AROUND TO CHARGE FORWARD!"
	cost = 3
	xp_gain = FALSE
	chargetime = 10
	recharge_time = 60 SECONDS
	movement_interrupt = FALSE
	charging_slowdown = 2
	chargedloop = /datum/looping_sound/invokeradio
	associated_skill = /datum/skill/magic/arcane
	req_items = list(/obj/item/clothing/head/roguetown/paddedcap/radio, /obj/item/storage/backpack/rogue/satchel/radiopack)
	overlay_state = "repulse"
	spell_tier = 2
	invocation = "OVER THE TOP, CHAAAAAAAAARGE!!"
	invocation_type = "shout"
	gesture_required = TRUE
	antimagic_allowed = TRUE
	var/order_range = 7

/obj/effect/proc_holder/spell/invoked/charge/cast(list/targets,mob/user = usr)
	. = ..()
	var/list/chargeline = list("RAAAAAGHHHHH!!", "AGHHHHHH!!", "CHAAAAAAAAARGE!!!")
	for(var/mob/living/carbon/human/orderedguy in (get_hearers_in_view(order_range, user) - user))
		if(isliving(orderedguy))
			if(orderedguy.job in GLOB.perserdun_positions)
				orderedguy.apply_status_effect(/datum/status_effect/buff/order/movemovemove)
				orderedguy.say(pick(chargeline))
				orderedguy.emote("warcry", forced = TRUE)
			else
				return
	return TRUE
