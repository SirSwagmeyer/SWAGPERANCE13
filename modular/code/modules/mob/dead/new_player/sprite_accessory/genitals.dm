/// Covers all penis morphologies — normal cock, sheaths (SHEATH_TYPE_NORMAL), and genital slits
/// (SHEATH_TYPE_SLIT) — all blocked by the same cage/full/penis-blocked traits since they are all
/// penis-type anatomy. Cursed modes 1 and 3 expose front access regardless.
/// Falls through to the upstream visibility check (underwear, HIDEJUMPSUIT, HIDECROTCH) if not blocked.
/datum/sprite_accessory/penis/is_visible(obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	if(owner.sexcon && owner.sexcon.bottom_exposed == TRUE)
		return TRUE
	if(owner.underwear)
		return FALSE
	return is_human_part_visible(owner, HIDEJUMPSUIT|HIDECROTCH)

/datum/sprite_accessory/testicles/is_visible(obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	var/obj/item/organ/penis/pp = owner.getorganslot(ORGAN_SLOT_PENIS)
	if(pp && pp.sheath_type == SHEATH_TYPE_SLIT)
		return FALSE
	if(owner.sexcon && owner.sexcon.bottom_exposed == TRUE)
		return TRUE
	if(owner.underwear)
		return FALSE
	return is_human_part_visible(owner, HIDEJUMPSUIT|HIDECROTCH)

/// Respects cursed mode: modes 2 and 3 expose the vagina regardless of the device being worn.
/// Falls through to the upstream visibility check (underwear, HIDECROTCH, HIDEJUMPSUIT) if not blocked.
/datum/sprite_accessory/vagina/is_visible(obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	if(owner.underwear)
		return FALSE
	return is_human_part_visible(owner, HIDECROTCH|HIDEJUMPSUIT)
