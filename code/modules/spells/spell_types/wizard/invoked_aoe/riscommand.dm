/obj/effect/proc_holder/spell/invoked/risholdingweak
	name = "Form Ranks!"
	desc = "Order those around to hold their ground, strengthing resolve."
	cost = 3
	xp_gain = FALSE
	chargetime = 10
	recharge_time = 60 SECONDS
	movement_interrupt = FALSE
	charging_slowdown = 2
	chargedloop = /datum/looping_sound/blank
	associated_skill = /datum/skill/magic/arcane
	overlay_state = "repulse"
	spell_tier = 2
	invocation = "RALLY TO ME AND HOLD!!"
	invocation_type = "shout"
	gesture_required = TRUE
	antimagic_allowed = TRUE
	var/order_range = 7

/obj/effect/proc_holder/spell/invoked/risholdingweak/cast(list/targets,mob/user = usr)
	. = ..()
	for(var/mob/living/carbon/human/orderedguy in (get_hearers_in_view(order_range, user) - user))
		if(isliving(orderedguy))
			if(orderedguy.job in GLOB.risvon_positions)
				orderedguy.apply_status_effect(/datum/status_effect/buff/order/holdweak)
			else
				return
	return TRUE

/obj/effect/proc_holder/spell/invoked/risaimweak
	name = "Focus Fire!"
	desc = "Order your men to focus their fire onto the enemy!"
	cost = 3
	xp_gain = FALSE
	chargetime = 10
	recharge_time = 60 SECONDS
	movement_interrupt = FALSE
	charging_slowdown = 2
	chargedloop = /datum/looping_sound/blank
	associated_skill = /datum/skill/magic/arcane
	overlay_state = "repulse"
	spell_tier = 2
	invocation = "FOCUS FIRE!!!"
	invocation_type = "shout"
	gesture_required = TRUE
	antimagic_allowed = TRUE
	var/order_range = 7

/obj/effect/proc_holder/spell/invoked/risaimweak/cast(list/targets,mob/user = usr)
	. = ..()
	for(var/mob/living/carbon/human/orderedguy in (get_hearers_in_view(order_range, user) - user))
		if(isliving(orderedguy))
			if(orderedguy.job in GLOB.risvon_positions)
				orderedguy.apply_status_effect(/datum/status_effect/buff/order/takeaimweak)
			else
				return
	return TRUE

/obj/effect/proc_holder/spell/invoked/rischargeweak
	name = "Advance!"
	desc = "Order your men into a forward march! CHARGE!"
	cost = 3
	xp_gain = FALSE
	chargetime = 10
	recharge_time = 60 SECONDS
	movement_interrupt = FALSE
	charging_slowdown = 2
	chargedloop = /datum/looping_sound/blank
	associated_skill = /datum/skill/magic/arcane
	overlay_state = "repulse"
	spell_tier = 2
	invocation = "FOR THE DIVEGAT - CHAAAARGEEEE!!!"
	invocation_type = "shout"
	gesture_required = TRUE
	antimagic_allowed = TRUE
	var/order_range = 7

/obj/effect/proc_holder/spell/invoked/rischargeweak/cast(list/targets,mob/user = usr)
	. = ..()
	var/list/chargeline = list("RAAAAAGHHHHH!!", "AGHHHHHH!!", "CHAAAAAAAAARGE!!!")
	for(var/mob/living/carbon/human/orderedguy in (get_hearers_in_view(order_range, user) - user))
		if(isliving(orderedguy))
			if(orderedguy.job in GLOB.risvon_positions)
				orderedguy.apply_status_effect(/datum/status_effect/buff/order/movemovemoveweak)
				orderedguy.say(pick(chargeline))
				orderedguy.emote("warcry", forced = TRUE)
			else
				return
	return TRUE
