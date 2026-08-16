/obj/effect/proc_holder/spell/invoked/tail_stab
	name = "Tail Stab"
	desc = "Strike a target with your tail."
	overlay_state = "stab"
	releasedrain = 10
	chargetime = 0
	recharge_time = 10 SECONDS
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = TRUE
	chargedloop = null
	cost = 0
	spell_tier = 1
	miracle = FALSE
	invocation_type = "none"
	range = 2

/obj/effect/proc_holder/spell/invoked/tail_stab/cast(list/targets, mob/living/user)
	var/mob/living/target = targets[1]
	if(!istype(target) || target == user || get_dist(user, target) > 2)
		revert_cast()
		return FALSE
	if(!user.getorganslot(ORGAN_SLOT_TAIL))
		revert_cast()
		return FALSE
	user.do_attack_animation(target, ATTACK_EFFECT_DISARM)
	return TRUE

/obj/effect/proc_holder/spell/invoked/tail_stab/drain
	name = "Tail Drain"
	desc = "Strike a target with your tail and drain their blood."

/obj/effect/proc_holder/spell/invoked/tail_stab/drain/cast(list/targets, mob/living/user)
	if(!..())
		return FALSE

	var/mob/living/target = targets[1]
	if(!ishuman(target))
		to_chat(user, span_warning("There is no blood for your tail to drink!"))
		return TRUE

	var/mob/living/carbon/human/H = target
	if(H.blood_volume <= 0)
		to_chat(user, span_warning("[target] has no blood left to drain!"))
		return TRUE

	var/blood_amount = H.blood_volume * 0.10
	H.blood_volume = max(H.blood_volume - blood_amount, 0)
	H.handle_blood()

	user.visible_message(
		span_danger("[user]'s tail quickly pierces [target], drawing their blood!"),
		span_notice("My tail pierces [target], drawing their blood into me."),
		span_userdanger("Something quickly pierces you and drains your blood!")
	)

	user.apply_status_effect(/datum/status_effect/tail_drain, blood_amount)
	return TRUE

/obj/effect/proc_holder/spell/invoked/tail_stab/tox
	name = "Tail Stab"
	desc = "Strike a target with your poisonous tail, injecting them with venom."

/obj/effect/proc_holder/spell/invoked/tail_stab/tox/cast(list/targets, mob/living/user)
	if(!..())
		return FALSE

	var/mob/living/target = targets[1]
	var/blood_cost = user.blood_volume * 0.10
	var/toxin_amount = blood_cost * 0.10

	if(blood_cost <= 0)
		to_chat(user, span_warning("I have no blood to convert into venom!"))
		return TRUE

	user.blood_volume = max(user.blood_volume - blood_cost, 0)
	target.reagents?.add_reagent(/datum/reagent/organpoison, toxin_amount)
	target.apply_status_effect(/datum/status_effect/wyverntouched_venom)

	user.visible_message(
		span_danger("[user]'s tail quickly pierces [target], pumping venom into their veins!"),
		span_warning("My tail pierces [target], pumping venom into their veins."),
		span_userdanger("Something quickly pierces you and pumps venom into your veins!")
	)

	return TRUE

/datum/status_effect/tail_drain
	id = "tail_drain"
	duration = 10 SECONDS
	tick_interval = 1 SECONDS
	examine_text = "<span class='artery'>SUBJECTPRONOUN seems sluggish and vulnerable.</span>"
	effectedstats = list("speed" = -2)
	var/blood_amount

/datum/status_effect/tail_drain/on_apply(blood)
	. = ..()
	blood_amount = blood
	to_chat(owner, span_notice("The stolen blood begins restoring your body, slowing you down."))

/datum/status_effect/tail_drain/tick()
	if(!owner)
		return

	var/mob/living/carbon/C = owner
	var/restore = blood_amount * 0.1

	C.blood_volume = min(C.blood_volume + restore, BLOOD_VOLUME_NORMAL)
	C.adjust_vitae(restore * 0.2)
	C.adjust_nutrition(restore * 0.2)
	C.adjust_hydration(restore * 0.2)

/datum/status_effect/wyverntouched_venom
	id = "wyverntouched_venom"
	duration = 10 SECONDS
	examine_text = "<span class='necrosis'>SUBJECTPRONOUN seems sluggish and vulnerable.</span>"
	tick_interval = 1 SECONDS
	effectedstats = list("speed" = -2)

/datum/status_effect/wyverntouched_venom/on_apply()
	. = ..()
	to_chat(owner, span_danger("Venom spreads through your veins!"))

/datum/status_effect/wyverntouched_venom/tick()
	if(!owner)
		return

	var/mob/living/carbon/C = owner
	C.adjustToxLoss(3)
	C.Jitter(5)

	if(prob(10))
		C.emote("vomit")
