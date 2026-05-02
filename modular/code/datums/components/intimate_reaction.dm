/**
 * Reusable component framework for intimate accessory reactions (chastity devices, piercings, insertable toys, etc.).
 *
 * HOW TO USE — QUICK PATHS:
 *
 * 1. Adding strings to an existing accessory:
 *    Just add entries to the relevant JSON bank under modular/code/game/objects/items/lewd/chastity/strings/.
 *    No DM changes needed.
 *
 * 2. New accessory with sex-action reactions only (no movement):
 *    - Make a new subtype of /datum/component/intimate_reaction.
 *    - Override try_handle_wearer_sex_action_received() with your logic.
 *    - Override is_valid_wearer_source() — call ..() first, then add any item-specific check (e.g., source.my_item == parent).
 *    - Call bind_to_wearer(H) when the item is equipped; call unbind_from_wearer(H) when it is removed or destroyed.
 *    - Use pick_string_bank(filename, key) to pull strings. Pass a strings_path argument if your JSONs live outside the chastity directory.
 *
 * 3. New accessory with movement reactions (bell piercing, vibrating plug, etc.):
 *    - Follow step 2, then also call register_movement_reaction(H) inside your bind_to_wearer override (after ..()).
 *    - Call unregister_movement_reaction(H) inside unbind_from_wearer (before ..()).
 *    - Override try_handle_wearer_moved() with your step-counter / message logic.
 *      last_movement_message_time and movement_message_cooldown are available on the base for cooldown gating.
 *
 * 4. New accessory that can stack with other instances (piercings, multiple toys simultaneously):
 *    - Override dupe_mode to COMPONENT_DUPE_ALLOW_ALL on your subtype — the base defaults to COMPONENT_DUPE_UNIQUE
 *      which will silently discard the second instance otherwise.
 *
 * 5. Coverage-aware flavor text (reaction differs based on armor over the body part):
 *    - Call get_cover_tier_for_zone(source, BODY_ZONE_PRECISE_GROIN) (or whichever zone applies) to get the
 *      covering armor tier (null = uncovered, ARMOR_CLASS_NONE through ARMOR_CLASS_HEAVY).
 *    - Route to the appropriate JSON bank based on the returned tier.
 *
 * 6. Blocking sex actions while an accessory is worn (plug blocking anal penetration, etc.):
 *    - Use /datum/component/intimate_action_guard instead — see the /chastity subtype below for the pattern.
 *
 * GENERAL GUIDELINES:
 *    - Keep reaction logic lightweight: prefer cooldowns, early returns, and external string banks over inline
 *      text or repeated visible_message spam. BYOND will thank you.
 *    - If this stops working yell at Yuckuza on Discord.
 */
/datum/component/intimate_reaction
	/// Override to COMPONENT_DUPE_ALLOW_ALL for accessories that can coexist in multiples on the same wearer
	/// (e.g., a nipple piercing and a tongue piercing are different items but the same component subtype).
	dupe_mode = COMPONENT_DUPE_UNIQUE
	var/mob/living/carbon/human/wearer = null
	/// Movement cooldown state shared across all subtypes. Subtypes set movement_message_cooldown in their
	/// vars block to tune the frequency; last_movement_message_time is updated inside try_handle_wearer_moved.
	var/last_movement_message_time = 0
	var/movement_message_cooldown = 10 SECONDS

/// Initializes the component.
/datum/component/intimate_reaction/Initialize()
	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE

/// Destroys the component.
/datum/component/intimate_reaction/Destroy(force, silent)
	if(wearer)
		unbind_from_wearer(wearer)
	return ..()

/// Binds the component to the wearer mob, registering the sex-action signal.
/// Returns TRUE on success. Subtypes call ..() and then register any additional signals they need.
/datum/component/intimate_reaction/proc/bind_to_wearer(mob/living/carbon/human/H)
	if(!H)
		return FALSE
	if(wearer == H)
		return TRUE
	if(wearer)
		unbind_from_wearer(wearer)
	wearer = H
	RegisterSignal(H, COMSIG_CARBON_SEX_ACTION_RECEIVED, PROC_REF(on_wearer_sex_action_received))
	return TRUE

/datum/component/intimate_reaction/proc/unbind_from_wearer(mob/living/carbon/human/H)
	if(!H)
		H = wearer
	if(!H)
		return FALSE
	UnregisterSignal(H, COMSIG_CARBON_SEX_ACTION_RECEIVED)
	if(H == wearer)
		wearer = null
	return TRUE

/// Raw signal handler for sex-action events. Validates wearer identity then defers to try_handle_wearer_sex_action_received.
/datum/component/intimate_reaction/proc/on_wearer_sex_action_received(datum/source, mob/living/carbon/human/acting_mob, datum/sex_controller/acting_sexcon, datum/sex_action/action, receiver_part, giving, arousal_amt, pain_amt, applied_force, applied_speed)
	SIGNAL_HANDLER
	if(source != wearer)
		return FALSE
	return try_handle_wearer_sex_action_received(source, acting_mob, acting_sexcon, action, receiver_part, giving, arousal_amt, pain_amt, applied_force, applied_speed)

/// Stub. Override in subtypes to implement sex-action reactions (arousal messages, pain strings, flavor text, etc.).
/datum/component/intimate_reaction/proc/try_handle_wearer_sex_action_received(mob/living/carbon/human/source, mob/living/carbon/human/acting_mob, datum/sex_controller/acting_sexcon, datum/sex_action/action, receiver_part, giving, arousal_amt, pain_amt, applied_force, applied_speed)
	return FALSE

/// Registers COMSIG_MOVABLE_MOVED on H, routing it through on_wearer_moved → try_handle_wearer_moved.
/// Call from bind_to_wearer in any subtype that needs movement-based reactions (jingle emotes, vibration triggers, etc.).
/datum/component/intimate_reaction/proc/register_movement_reaction(mob/living/carbon/human/H)
	RegisterSignal(H, COMSIG_MOVABLE_MOVED, PROC_REF(on_wearer_moved))

/// Unregisters COMSIG_MOVABLE_MOVED from H. Always pair this with register_movement_reaction in unbind_from_wearer.
/datum/component/intimate_reaction/proc/unregister_movement_reaction(mob/living/carbon/human/H)
	UnregisterSignal(H, COMSIG_MOVABLE_MOVED)

/// Raw signal handler for movement events. Validates wearer identity then defers to try_handle_wearer_moved.
/datum/component/intimate_reaction/proc/on_wearer_moved(datum/source)
	SIGNAL_HANDLER
	if(source != wearer)
		return FALSE
	return try_handle_wearer_moved(source)

/// Stub. Override in subtypes to implement movement-based reactions (step counters, jingle emotes, etc.).
/// last_movement_message_time and movement_message_cooldown on the base class are available for cooldown gating.
/datum/component/intimate_reaction/proc/try_handle_wearer_moved(mob/living/carbon/human/source)
	return FALSE

/// Returns TRUE if source is non-null, not QDELeted, and matches the currently bound wearer.
/// Subtypes override to add item-specific checks (e.g., source.chastity_device == parent for the chastity subtype).
/datum/component/intimate_reaction/proc/is_valid_wearer_source(mob/living/carbon/human/source)
	return source && !QDELETED(source) && source == wearer

/**
 * Picks a random string from an external JSON string bank.
 *
 * Arguments:
 *  - filename: JSON file name within strings_path (e.g., "chastity_movement_messages.json").
 *  - string_key: key to look up within the JSON object.
 *  - strings_path: directory containing the JSON file. Defaults to the chastity strings directory.
 *    Pass a different path when implementing non-chastity accessories that use their own JSON banks.
 *
 * Named pick_string_bank to avoid collision with the global pick_chastity_string() preprocessor macro.
 */
/datum/component/intimate_reaction/proc/pick_string_bank(filename, string_key, strings_path = "modular/code/game/objects/items/lewd/chastity/strings")
	if(!string_key)
		return null
	var/list/string_bank = strings(filename, string_key, strings_path)
	if(!islist(string_bank) || !string_bank.len)
		return null
	return pick(string_bank)

/**
 * Returns the highest armor_class of equipped items covering the given body zone that have surgery_cover = TRUE.
 *
 * Mirrors get_location_accessible() logic: only real clothing layers count; tattoos and paint
 * (surgery_cover = FALSE) are ignored. Use this to gate or grade flavor reactions based on whether
 * a body part is exposed or hidden under armor — e.g., BODY_ZONE_PRECISE_GROIN for chastity devices,
 * BODY_ZONE_PRECISE_CHEST for nipple piercings.
 *
 * Returns:
 *  - null               → zone is uncovered; the body part and any device on it are fully visible.
 *  - ARMOR_CLASS_NONE   → covered by plain clothing with no declared armor tier.
 *  - ARMOR_CLASS_LIGHT  → covered by light armor (leather, gambeson, padded cloth, etc.).
 *  - ARMOR_CLASS_MEDIUM → covered by medium armor (chainmail, cuirass, etc.).
 *  - ARMOR_CLASS_HEAVY  → covered by full plate.
 */
/datum/component/intimate_reaction/proc/get_cover_tier_for_zone(mob/living/carbon/human/source, body_zone)
	var/highest_tier = -1 // -1 = nothing covering yet; null return means uncovered
	for(var/obj/item/equipped_item in source.get_equipped_items(include_pockets = FALSE, include_beltslots = FALSE))
		if(!zone2covered(body_zone, equipped_item.body_parts_covered_dynamic))
			continue
		if(!equipped_item.surgery_cover)
			continue // tattoos and similar soft overlays don't count as real cover
		if(!isclothing(equipped_item))
			continue
		var/obj/item/clothing/C = equipped_item
		highest_tier = max(highest_tier, C.armor_class)
	return highest_tier >= 0 ? highest_tier : null

/// Component for blocking or hiding sex actions based on worn intimate accessories.
/datum/component/intimate_action_guard
	dupe_mode = COMPONENT_DUPE_UNIQUE
	var/mob/living/carbon/human/wearer = null

/// Initializes the component.
/datum/component/intimate_action_guard/Initialize()
	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE

/// Destroys the component.
/datum/component/intimate_action_guard/Destroy(force, silent)
	if(wearer)
		unbind_from_wearer(wearer)
	return ..()

/// Binds the action blocker, hides sex action based on context
/datum/component/intimate_action_guard/proc/bind_to_wearer(mob/living/carbon/human/H)
	if(!H)
		return FALSE
	if(wearer == H)
		return TRUE
	if(wearer)
		unbind_from_wearer(wearer)
	wearer = H
	RegisterSignal(H, COMSIG_CARBON_SEX_ACTION_VALIDATE, PROC_REF(on_wearer_validate_sex_action))
	return TRUE

/datum/component/intimate_action_guard/proc/unbind_from_wearer(mob/living/carbon/human/H)
	if(!H)
		H = wearer
	if(!H)
		return FALSE
	UnregisterSignal(H, COMSIG_CARBON_SEX_ACTION_VALIDATE)
	if(H == wearer)
		wearer = null
	return TRUE
/datum/component/intimate_action_guard/proc/on_wearer_validate_sex_action(datum/source, datum/sex_action/action, mob/living/carbon/human/other, checked_part, is_user_role, menu_check)
	SIGNAL_HANDLER
	if(source != wearer)
		return FALSE
	return try_validate_wearer_sex_action(source, action, other, checked_part, is_user_role, menu_check)

/// Validates the sex action for the wearer of the chastity device.
/datum/component/intimate_action_guard/proc/try_validate_wearer_sex_action(mob/living/carbon/human/source, datum/sex_action/action, mob/living/carbon/human/other, checked_part, is_user_role, menu_check)
	return FALSE
