/obj/structure
	icon = 'icons/obj/structures.dmi'
	max_integrity = 300
	interaction_flags_atom = INTERACT_ATOM_ATTACK_HAND | INTERACT_ATOM_UI_INTERACT
	layer = BELOW_OBJ_LAYER
	anchored = TRUE
	plane = GAME_PLANE_LOWER
	var/climb_time = 20
	var/climb_stun = 0
	var/climb_sound = 'sound/foley/woodclimb.ogg'
	var/climbable = FALSE
	var/climb_offset = 0 //offset up when climbed
	var/mob/living/structureclimber
	var/hammer_repair
	keylock = FALSE
	lockhash = 0
//	move_resist = MOVE_FORCE_STRONG

/obj/structure/Initialize()
	if (!armor)
		armor = ARMOR_STRUCTURE
	. = ..()
	if(smooth)
		queue_smooth(src)
		queue_smooth_neighbors(src)
		icon_state = ""
	if(redstone_id)
		GLOB.redstone_objs += src
		. = INITIALIZE_HINT_LATELOAD

/obj/structure/Bumped(atom/movable/AM)
	..()
	if(density)
		if(ishuman(AM))
			var/mob/living/carbon/human/H = AM
			if(H.dir == get_dir(H,src) && H.m_intent == MOVE_INTENT_RUN && (H.mobility_flags & MOBILITY_STAND))
				var/is_bigguy = FALSE
				if(HAS_TRAIT(H,TRAIT_BIGGUY))
					if(istype(src,/obj/structure/mineral_door))
						var/obj/structure/mineral_door/S = src
						if(S.smashable)
							is_bigguy = TRUE
				if(is_bigguy && obj_integrity > max_integrity / 3)
					if(max_integrity > 1000) 	//Custom-set HP door, should be respected
						take_damage(max_integrity / 6 + 1)
					else
						if(H.STASTR >= 13)	//STR adding role w/ Giant or half-orc, seems fair
							take_damage((max_integrity / 3) * 2 + 1)
						else 
							take_damage(max_integrity / 3 + 1)
					H.Immobilize(20)
					//MESSES you up
					H.apply_damage(200, BRUTE, "chest", H.run_armor_check("chest", "blunt", damage = 200))
					audible_message(span_warning("\The [src] shakes under the force of a great impact!"))
					playsound(src, "meteor", 100, TRUE)
					addtimer(CALLBACK(H, TYPE_PROC_REF(/mob/living/carbon/human, Knockdown), 10), 10)
				else if(is_bigguy && obj_integrity <= max_integrity / 3)	//This charge will wreck it
					take_damage(max_integrity)
					H.Immobilize(5)
					H.apply_damage(80, BRUTE, "chest", H.run_armor_check("chest", "blunt", damage = 80))
				else	//Normal charge
					H.Immobilize(10)
					H.apply_damage(15, BRUTE, "head", H.run_armor_check("head", "blunt", damage = 15))
					playsound(src, "genblunt", 100, TRUE)
					addtimer(CALLBACK(H, TYPE_PROC_REF(/mob/living/carbon/human, Knockdown), 10), 10)
				H.toggle_rogmove_intent(MOVE_INTENT_WALK, TRUE)
				H.visible_message(span_warning("[H] runs into [src]!"), span_warning("I run into [src]!"))


/obj/structure/Destroy()
	if(isturf(loc))
		for(var/mob/living/user in loc)
			if(climb_offset)
				user.reset_offsets("structure_climb")
	if(redstone_id)
		for(var/obj/structure/O in redstone_attached)
			O.redstone_attached -= src
			redstone_attached -= O
		GLOB.redstone_objs -= src
//	if(smooth)
//		queue_smooth_neighbors(src)
	return ..()

/obj/structure/attack_hand(mob/user)
	. = ..()
	if(.)
		return
//	if(structureclimber && structureclimber != user)
//		user.changeNext_move(CLICK_CD_MELEE)
//		user.do_attack_animation(src)
//		structureclimber.Paralyze(40)
//		structureclimber.visible_message(span_warning("[structureclimber] has been knocked off [src].", "You're knocked off [src]!", "You see [structureclimber] get knocked off [src]."))

/obj/structure/Crossed(atom/movable/AM)
	. = ..()
	if(isliving(AM) && !AM.throwing)
		var/mob/living/user = AM
		if(climb_offset)
			user.set_mob_offsets("structure_climb", _x = 0, _y = climb_offset)

/obj/structure/Uncrossed(atom/movable/AM)
	. = ..()
	if(isliving(AM) && !AM.throwing)
		var/mob/living/user = AM
		if(climb_offset)
			user.reset_offsets("structure_climb")

/obj/structure/ui_act(action, params)
	..()
	add_fingerprint(usr)

/obj/structure/MouseDrop_T(atom/movable/O, mob/user)
	. = ..()
	if(!climbable)
		return
	if(user == O && isliving(O))
		var/mob/living/L = O
		if(isanimal(L))
			var/mob/living/simple_animal/A = L
			if (!A.dextrous)
				return
		if(L.mobility_flags & MOBILITY_MOVE)
			climb_structure(user)
			return
	if(!istype(O, /obj/item) || user.get_active_held_item() != O)
		return
	if(!user.dropItemToGround(O))
		return
	if (O.loc != src.loc)
		step(O, get_dir(O, src))

/obj/structure/proc/do_climb(atom/movable/A)
	// this is done so that climbing onto something doesn't ignore other dense objects on the same turf
	if(climbable)
		density = FALSE
		. = step(A,get_dir(A,src.loc))
		density = TRUE

/obj/structure/proc/climb_structure(mob/living/user)
	src.add_fingerprint(user)
	var/adjusted_climb_time = climb_time
	if(user.restrained()) //climbing takes twice as long when restrained.
		adjusted_climb_time *= 2
	if(!ishuman(user))
		adjusted_climb_time = 0 //simple mobs instantly climb
	if(HAS_TRAIT(user, TRAIT_FREERUNNING)) //do you have any idea how fast I am???
		adjusted_climb_time *= 0.8
	adjusted_climb_time -= user.STASPD * 2
	adjusted_climb_time = max(adjusted_climb_time, 0)
//	if(adjusted_climb_time)
//		user.visible_message(span_warning("[user] starts climbing onto [src]."), span_warning("I start climbing onto [src]..."))
	structureclimber = user
	if(do_mob(user, user, adjusted_climb_time))
		if(src.loc) //Checking if structure has been destroyed
			if(do_climb(user))
				user.visible_message(span_warning("[user] climbs onto [src]."), \
									span_notice("I climb onto [src]."))
				log_combat(user, src, "climbed onto")
//				if(climb_offset)
//					user.set_mob_offsets("structure_climb", _x = 0, _y = climb_offset)
				if(climb_stun)
					user.Stun(climb_stun)
				if(climb_sound)
					playsound(src, climb_sound, 100)
				. = 1
			else
				to_chat(user, span_warning("I fail to climb onto [src]."))
	structureclimber = null

// You can path over a dense structure if it's climbable.
/obj/structure/CanAStarPass(ID, to_dir, caller)
	. = climbable || ..()

/obj/structure/examine(mob/user)
	. = ..()
	if(!(resistance_flags & INDESTRUCTIBLE))
		if(obj_broken)
			. += span_notice("It appears to be broken.")
		var/examine_status = examine_status(user)
		if(examine_status)
			. += examine_status

/obj/structure/proc/examine_status(mob/user) //An overridable proc, mostly for falsewalls.
	if(max_integrity)
		var/healthpercent = (obj_integrity/max_integrity) * 100
		switch(healthpercent)
			if(50 to 99)
				return  "It barely looks damaged."
			if(25 to 50)
				return  "It looks pretty damaged."
			if(1 to 25)
				return  span_warning("It's about to break.")


/// Helper proc to find a matching key or keyring in certain equipment slots on a mob.
/obj/structure/proc/find_key_for_door(mob/user)
	if(!user || !keylock)
		return null

	// Try the inactive hand first
	var/obj/item/O = user.get_inactive_held_item()
	if(O && (istype(O, /obj/item/roguekey) || istype(O, /obj/item/storage/keyring)))
		if(istype(O, /obj/item/roguekey))
			var/obj/item/roguekey/K = O
			if(K.lockhash == lockhash || istype(K, /obj/item/roguekey/lord))
				return O
		if(istype(O, /obj/item/storage/keyring))
			if(keyring_has_matching_key(O))
				return O

	// Check possible key slots if human
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		var/list/key_slots = list(
			H.get_item_by_slot(SLOT_RING),
			H.get_item_by_slot(SLOT_NECK),
			H.get_item_by_slot(SLOT_WRISTS),
			H.get_item_by_slot(SLOT_BELT),
			H.get_item_by_slot(SLOT_BELT_L),
			H.get_item_by_slot(SLOT_BELT_R)
		)

		for(var/obj/item/I in key_slots)
			if(!I) continue

			// Check if the belt item itself is a key or keyring
			if(istype(I, /obj/item/roguekey))
				var/obj/item/roguekey/K = I
				if(K.lockhash == lockhash || istype(K, /obj/item/roguekey/lord))
					return I
			if(istype(I, /obj/item/storage/keyring))
				if(keyring_has_matching_key(I))
					return I

			// Check inside the belt item if it has contents (storage belts, etc.)
			if(I.contents && I.contents.len)
				for(var/obj/item/contained_item in I.contents)
					if(istype(contained_item, /obj/item/roguekey))
						var/obj/item/roguekey/K = contained_item
						if(K.lockhash == lockhash || istype(K, /obj/item/roguekey/lord))
							return I // Return the belt item that contains the key
					if(istype(contained_item, /obj/item/storage/keyring))
						if(keyring_has_matching_key(contained_item))
							return I // Return the belt item that contains the keyring

	return null

/// Helper proc to check if a keyring on a mob contains a match for this structure's lockhash.
/obj/structure/proc/keyring_has_matching_key(obj/item/storage/keyring/keyring)
	if(!istype(keyring))
		return FALSE

	for(var/obj/item/I in keyring.contents)
		if(istype(I, /obj/item/roguekey))
			var/obj/item/roguekey/K = I
			if(K.lockhash == lockhash)
				return TRUE

	return FALSE

