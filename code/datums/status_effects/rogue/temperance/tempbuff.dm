/atom/movable/screen/alert/status_effect/buff/bloodhealing
	name = "Sewing Blood"
	desc = "Strands of blood weave themselves across my wounds, knitting them shut."
	icon_state = "buff"

#define BLOOD_HEALING_FILTER "blood_heal_glow"

/datum/status_effect/buff/bloodhealing
	id = "bloodhealing"
	alert_type = /atom/movable/screen/alert/status_effect/buff/bloodhealing
	duration = 30 SECONDS
	examine_text = "SUBJECTPRONOUN is surrounded by strands of blood!"
	var/healing_on_tick = 2
	var/outline_colour = "#681010"

/datum/status_effect/buff/bloodhealing/on_creation(mob/living/new_owner, new_healing_on_tick)
	healing_on_tick = new_healing_on_tick
	return ..()

/datum/status_effect/buff/bloodhealing/on_apply()
	SEND_SIGNAL(owner, COMSIG_LIVING_MIRACLE_HEAL_APPLY, healing_on_tick, src)
	var/filter = owner.get_filter(BLOOD_HEALING_FILTER)
	if (!filter)
		owner.add_filter(BLOOD_HEALING_FILTER, 2, list("type" = "outline", "color" = outline_colour, "alpha" = 60, "size" = 1))
	return TRUE

/datum/status_effect/buff/bloodhealing/tick()
	var/obj/effect/temp_visual/heal/H = new /obj/effect/temp_visual/heal_rogue(get_turf(owner))
	H.color = "#681010"
	var/list/wCount = owner.get_wounds()
	if(!owner.construct)
		if(wCount.len > 0)
			owner.heal_wounds(healing_on_tick, list(
			/datum/wound/artery,
			/datum/wound/bite,
			/datum/wound/dismemberment,
			/datum/wound/facial,
			/datum/wound/lashing,
			/datum/wound/puncture,
			/datum/wound/scarring,
			/datum/wound/slash,
			))
			owner.update_damage_overlays()

/datum/status_effect/buff/bloodhealing/on_remove()
	owner.remove_filter(BLOOD_HEALING_FILTER)
	owner.update_damage_hud()
