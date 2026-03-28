/* Funeral of a Dead Sanguine - ultimate AoE.
imagine furioso but like blood.

Requires 7+ momentum (overcharge zone).
Always FFs.*/

/obj/effect/proc_holder/spell/invoked/funeral
	name = "Funeral of a Dead Sanguine"
	desc = "Unleash all of your stored blood, attacking multiple targets. \
		Each attack has its own unique technique and weapon, and you jump from target to target. \
		Requires 7 momentum. Overcharged at 10 momentum. \
		To begin the Funeral, attack after activating this spell. \
		Cannot be blocked."
	clothes_req = FALSE
	range = 7
	overlay_state = "coagulated_blood"
	releasedrain = 30
	chargedrain = 1
	chargetime = 20
	recharge_time = 60 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 1
	chargedloop = /datum/looping_sound/invokegen
	invocation = "LET US END THIS JUVENILE DREAM!"
	invocation_type = "shout"
	gesture_required = TRUE
	xp_gain = FALSE
	var/delay = 10
	var/damage = 100
	var/bonus_damage = 80
	var/area_of_effect = 2
	var/min_momentum = 7
	var/empowered_momentum = 10
	var/vulnerable_duration = 6 SECONDS

/obj/effect/proc_holder/spell/invoked/funeral/can_cast(mob/user = usr)
	. = ..()
	if(!.)
		return FALSE
	if(!ishuman(user))
		return FALSE
	var/mob/living/carbon/human/H = user
	var/datum/status_effect/buff/arcyne_momentum/M = H.has_status_effect(/datum/status_effect/buff/arcyne_momentum)
	if(!M || M.stacks < min_momentum)
		return FALSE
	return TRUE

/obj/effect/proc_holder/spell/invoked/funeral/cast(list/targets, mob/user = usr)
	var/mob/living/carbon/human/H = user
	if(!istype(H))
		revert_cast()
		return

	var/obj/item/rogueweapon/sword/sabre/midsomber/held_weapon = arcyne_get_weapon(H)
	if(!istype(held_weapon))
		to_chat(H, span_warning("I need my bound weapon in hand!"))
		revert_cast()
	else
		held_weapon.furioso_start = TRUE

//look at /.../sabre/midsomber for everything that happens after this check succeeds