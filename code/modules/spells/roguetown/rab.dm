/obj/effect/proc_holder/spell/invoked/diagnose/blood
	name = "Internal Examination"
	desc = "Utilize your knowledge of the body's innerworkings to see 'through' another."
	overlay_state = "diagnose"
	range = 1
	associated_skill = /datum/skill/magic/blood
	miracle = FALSE
	sound = 'sound/magic/internal_examination.ogg'
	devotion_cost = 0 //Doctors are not clerics

/obj/effect/proc_holder/spell/invoked/blood_heal
	name = "Blood Congeal"
	desc = "The simplest of blood magicks. Tap into the coagulative properties of blood to seal deep wounds and staunch bleeding. Capable of healing fractures by rapidly congealing blood into a rigid substance.<br>Standing near puddles of blood will improve the flow."
	overlay_state = "lesserheal"
	releasedrain = 10
	chargedrain = 0
	chargetime = 0
	range = 4
	warnie = "sydwarning"
	movement_interrupt = FALSE
	sound = 'sound/magic/heal.ogg' // needs a custom one
	invocation_type = "none"
	associated_skill = /datum/skill/magic/blood
	antimagic_allowed = TRUE
	recharge_time = 10 SECONDS

/obj/effect/proc_holder/spell/invoked/blood_heal/cast(list/targets, mob/living/user)
	. = ..()
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(target.has_status_effect(/datum/status_effect/buff/healing))
			to_chat(user, span_warning("They are already under the effects of a healing magic!"))
			revert_cast()
			return FALSE
		var/conditional_buff = FALSE
		var/situational_bonus = 1
		var/message_out
		var/message_self
		message_out = span_info("Blood rises around [target]'s feet, before coagulating onto their wounds!")
		message_self = span_notice("Blood rises from my feet! It sticks to my wounds, sealing them taut!")
		situational_bonus = 0
		for(var/obj/effect/decal/cleanable/blood/B in oview(5, target))
			situational_bonus += (0.5)
		if (situational_bonus > 0)
			conditional_buff = TRUE
			situational_bonus = min(situational_bonus, 5)

		var/healing = 2.5
		if (conditional_buff)
			to_chat(user, "Manipulating blood is easier in these conditions!")
			healing += situational_bonus

		if(ishuman(target))
			var/mob/living/carbon/human/H = target
			var/no_embeds = TRUE
			var/list/embeds = H.get_embedded_objects()
			if(length(embeds))
				for(var/object in embeds)
					if(!istype(object, /obj/item/natural/worms/leech))	//Leeches and surgical cheeles are made an exception.
						no_embeds = FALSE
			else
				no_embeds = TRUE
			if(no_embeds)
				target.apply_status_effect(/datum/status_effect/buff/healing, healing)
			else
				message_out = span_warning("The wounds tear and rip around the embedded objects!")
				message_self = span_warning("Agonizing pain shoots through your body as blood tries to sew around the embedded objects!")
				H.adjustBruteLoss(20)
				playsound(target, 'sound/combat/dismemberment/dismem (2).ogg', 100)
				H.emote("agony")
		else
			target.apply_status_effect(/datum/status_effect/buff/healing, healing)
		target.visible_message(message_out, message_self)
		return TRUE
	revert_cast()
	return FALSE

/obj/effect/proc_holder/spell/invoked/blood_link
	name = "Blood Transfer"
	desc = "Transfers the blood of yourself to a target. Ratio of transfer scales with blood skill."
	overlay_state = "blood_link"
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	range = 7
	ignore_los = FALSE
	warnie = "sydwarning"
	movement_interrupt = TRUE
	sound = 'sound/magic/blood_link.ogg'
	invocation_type = "none"
	associated_skill = /datum/skill/magic/blood
	antimagic_allowed = FALSE
	recharge_time = 45 SECONDS
	var/blood_price = 5
	var/blood_vol_restore = 7.5 //30 every 2 seconds.
	var/vol_per_skill = 1	//54 with legendary
	var/delay = 0.5 SECONDS

/obj/effect/proc_holder/spell/invoked/blood_link/cast(list/targets, mob/user = usr)
	if(ishuman(targets[1]))
		var/mob/living/carbon/human/target = targets[1]
		var/mob/living/carbon/human/UH = user
		if(NOBLOOD in UH.dna?.species?.species_traits)
			to_chat(UH, span_warning("I have no blood to provide."))
			revert_cast()
			return FALSE

		if(target.blood_volume >= BLOOD_VOLUME_NORMAL)
			to_chat(UH, span_warning("Their blood is at capacity. There is no need."))
			revert_cast()
			return FALSE

		UH.visible_message(span_warning("Strands of blood link between [UH] and [target]!"))
		playsound(UH, 'sound/magic/blood_link_start.ogg', 100, TRUE)
		var/user_skill = UH.get_skill_level(associated_skill)
		var/user_informed = FALSE
		switch(user_skill)	//Bleeding happens every life(), which is every 2 seconds. Multiply these numbers by 4 to get the "bleedrate" equivalent values.
			if(SKILL_LEVEL_APPRENTICE)
				blood_price = 3.75
			if(SKILL_LEVEL_JOURNEYMAN)
				blood_price = 2.5
			if(SKILL_LEVEL_EXPERT)
				blood_price = 2
			if(SKILL_LEVEL_MASTER)
				blood_price = 1.625
			if(SKILL_LEVEL_LEGENDARY)
				blood_price = 1.25
		if(user_skill > SKILL_LEVEL_NOVICE)
			blood_vol_restore += vol_per_skill * user_skill
		var/max_loops = round(UH.blood_volume / blood_price, 1) * 2	// x2 just in case the user is trying to fill themselves up while using it.
		var/datum/beam/bloodbeam = user.Beam(target,icon_state="blood",time=(max_loops * 5))
		for(var/i in 1 to max_loops)
			if(UH.blood_volume > (BLOOD_VOLUME_SURVIVE / 2))
				if(do_after(UH, delay))
					target.blood_volume = min((target.blood_volume + blood_vol_restore), BLOOD_VOLUME_NORMAL)
					UH.blood_volume = max((UH.blood_volume - blood_price), 0)
					if(target.blood_volume >= BLOOD_VOLUME_NORMAL && !user_informed)
						to_chat(UH, span_info("They're at a healthy blood level, but I can keep going."))
						user_informed = TRUE
				else
					UH.visible_message(span_warning("Severs the bloodlink from [target]!"))
					qdel(bloodbeam)
					return TRUE
			else
				UH.visible_message(span_warning("Severs the bloodlink from [target]!"))
				qdel(bloodbeam)
				return TRUE
		qdel(bloodbeam)
		return TRUE
	revert_cast()
	return FALSE


// choso blood manipulation
/obj/effect/proc_holder/spell/invoked/projectile/piercing_blood
	name = "Piercing Blood"
	desc = "Condense your blood into a powerful, razor-thin beam and fire it with extremely high pressure."
	clothes_req = FALSE
	overlay_state = "bloodlightning"
	sound = 'sound/magic/piercing_blood.ogg'
	range = 8
	projectile_type = /obj/projectile/magic/bloodbeam
	releasedrain = 30
	chargedrain = 1
	chargetime = 5
	recharge_time = 5 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	spell_tier = 2 // Doesn't matter for the most part
	invocation = "PIERCING BLOOD!"
	invocation_type = "shout"
	glow_color = GLOW_COLOR_VAMPIRIC
	glow_intensity = GLOW_INTENSITY_MEDIUM
	charging_slowdown = 2
	chargedloop = /datum/looping_sound/invokeblood
	associated_skill = /datum/skill/magic/blood
	cost = 6

/obj/effect/proc_holder/spell/invoked/projectile/piercing_blood/cast(list/targets, mob/living/user)
	if(ishuman(user))
		if(user.blood_volume < 50)
			to_chat(user, span_warning("I don't have enough blood to cast this."))
			return FALSE
		user.blood_volume = max(user.blood_volume - 50, 0)
	else
		return FALSE
	. = ..()

/obj/projectile/magic/bloodbeam
	name = "blood beam"
	tracer_type = /obj/effect/projectile/tracer/bloodbeam
	muzzle_type = null
	impact_type = null
	movement_type = UNSTOPPABLE
	hitscan = TRUE
	damage = 70
	armor_penetration = 50
	damage_type = BRUTE
	woundclass = BCLASS_PIERCE
	nodamage = FALSE
	speed = 0.3
	flag = "magic"
	light_color = "#802121"
	light_outer_range = 7

/obj/projectile/magic/bloodbeam/on_hit(target)
	. = ..()
	if(ismob(target))
		var/mob/M = target
		if(M.anti_magic_check())
			visible_message(span_warning("[src] fizzles on contact with [target]!"))
			playsound(get_turf(target), 'sound/magic/magic_nulled.ogg', 100)
			qdel(src)
			return BULLET_ACT_BLOCK
		if(isliving(target))
			var/mob/living/L = target
			L.visible_message(span_danger("[target] is struck by a beam of blood!"), \
					span_userdanger("I'M STRUCK BY A BEAM OF BLOOD!"), \
					span_hear("I hear something that sounds like splashes of liquid..."))
			qdel(src)

/obj/effect/proc_holder/spell/invoked/projectile/bloodsiphon
	name = "Blood Siphon"
	desc = "Siphon blood from another and transfer it to yourself."
	clothes_req = FALSE
	overlay_state = "bloodsteal"
	sound = 'sound/magic/blood_siphon.ogg'
	range = 8
	projectile_type = /obj/projectile/magic/bloodsiphon
	releasedrain = 30
	chargedrain = 1
	chargetime = 10
	recharge_time = 30 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	spell_tier = 2
	invocation_type = "none"
	glow_color = GLOW_COLOR_VAMPIRIC
	glow_intensity = GLOW_INTENSITY_MEDIUM
	charging_slowdown = 1
	chargedloop = /datum/looping_sound/invokeblood
	associated_skill = /datum/skill/magic/blood
	cost = 3

/obj/projectile/magic/bloodsiphon
	name = "blood siphon"
	tracer_type = /obj/effect/projectile/tracer/bloodsiphon
	muzzle_type = null
	impact_type = null
	hitscan = TRUE
	damage = 20
	armor_penetration = 10
	damage_type = BRUTE
	woundclass = BCLASS_PIERCE
	nodamage = FALSE
	speed = 0.3
	flag = "magic"
	light_color = "#e74141"
	light_outer_range = 7

/obj/projectile/magic/bloodsiphon/on_hit(target)
	. = ..()
	if(ismob(target))
		var/mob/M = target
		if(M.anti_magic_check())
			visible_message(span_warning("[src] fizzles on contact with [target]!"))
			playsound(get_turf(target), 'sound/magic/magic_nulled.ogg', 100)
			qdel(src)
			return BULLET_ACT_BLOCK
		if(ishuman(target))
			var/mob/living/carbon/human/H = target
			if(NOBLOOD in H.dna?.species?.species_traits)
				if(ishuman(firer))
					to_chat(firer, span_warning("[H] has no blood to siphon!"))
				qdel(src)
				return BULLET_ACT_BLOCK
			if(H.blood_volume < 60)
				if(ishuman(firer))
					to_chat(firer, span_warning("[H] doesn't have enough blood to siphon!"))
				qdel(src)
				return BULLET_ACT_BLOCK
			var/amount = min(60, H.blood_volume)
			H.blood_volume -= amount
			H.handle_blood()
			H.visible_message(span_danger("[target] has blood ripped from their body!"), \
					span_userdanger("MY BLOOD ERUPTS FROM MY BODY!"), \
					span_hear("I hear something that sounds like splashes of liquid..."), COMBAT_MESSAGE_RANGE, target)
			new /obj/effect/decal/cleanable/blood/puddle(H.loc)
			if(ishuman(firer))
				var/mob/living/carbon/human/user = firer
				user.blood_volume = min(user.blood_volume + amount, BLOOD_VOLUME_NORMAL)
				user.handle_blood()
				to_chat(user, span_notice("I drain blood from [H]!"))
			qdel(src)
