/datum/sex_action/miscellaneous/tonguebath
	name = "Bathe with tongue"

/datum/sex_action/miscellaneous/tonguebath/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!check_location_accessible(user, user, BODY_ZONE_PRECISE_MOUTH))
		return FALSE
	return TRUE

/datum/sex_action/miscellaneous/tonguebath/can_perform(mob/living/user, mob/living/target)
	. = ..()
	if(!.)
		return FALSE
	if(user == target)
		return FALSE
	if(!check_location_accessible(user, user, BODY_ZONE_PRECISE_MOUTH))
		return FALSE
	return TRUE

/datum/sex_action/miscellaneous/tonguebath/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	user.visible_message(span_warning("[user] sticks [user.p_their()] tongue out, getting close to [target]..."))

/datum/sex_action/miscellaneous/tonguebath/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	user.visible_message(span_warning("[user] stops bathing [target]'s body ..."))

/datum/sex_action/miscellaneous/tonguebath/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/arousal_amt = 0.1
	var/body_desc = "body"

	if(check_location_accessible(user, target, BODY_ZONE_PRECISE_EARS))
		arousal_amt += 0.08
	if(check_location_accessible(user, target, BODY_ZONE_PRECISE_NECK))
		arousal_amt += 0.08
	if(check_location_accessible(user, target, BODY_ZONE_CHEST, TRUE))
		body_desc = "exposed body"
		if(target.getorganslot(ORGAN_SLOT_BREASTS))
			arousal_amt += 0.1
	if(check_location_accessible(user, target, BODY_ZONE_PRECISE_STOMACH))
		arousal_amt += 0.08
		body_desc = "exposed body"
	if(check_location_accessible(user, target, BODY_ZONE_PRECISE_GROIN))
		arousal_amt += 0.16
		body_desc = "exposed body"
	
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] bathes [target]'s [body_desc] with [user.p_their()] tongue..."))
	user.sexcon.make_sucking_noise()

	user.sexcon.perform_sex_action(target, arousal_amt, 0, TRUE)
	target.sexcon.handle_passive_ejaculation(target)
