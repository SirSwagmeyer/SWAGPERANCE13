/obj/item/reagent_containers/pill/patch
	name = "chemical patch"
	desc = ""
	icon = 'icons/obj/chemical.dmi'
	icon_state = "pill2"
	item_state = "pill2"
	possible_transfer_amounts = list()
	volume = 40
	apply_type = PATCH
	apply_method = "apply"
	self_delay = 30		// three seconds
	dissolvable = FALSE
	w_class = WEIGHT_CLASS_TINY
	var/used = FALSE


/obj/item/reagent_containers/pill/patch/used
	name = "used chemical patch"
	desc = "An adhesive patch that's been used and is now empty."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "pill1"
	item_state = "pill1"
	possible_transfer_amounts = list()
	volume = 0
	apply_type = 0
	apply_method = "apply"
	self_delay = 0
	dissolvable = FALSE
	list_reagents = list()

	

/obj/item/reagent_containers/pill/patch/attack(mob/living/L, mob/user)
	if(ishuman(L))
		var/obj/item/bodypart/affecting = L.get_bodypart(check_zone(user.zone_selected))
		if(!affecting)
			to_chat(user, "<span class='warning'>The limb is missing!</span>")
			return
		if(affecting.status != BODYPART_ORGANIC)
			to_chat(user, "<span class='notice'>Medicine won't work on a robotic limb!</span>")
			return

	// copy/paste of pill.attack but convert the same item instance into a used patch
	if(src.used)
		if(L == user)
			to_chat(L, "<span class='notice'>This patch is used and can't be applied.</span>")
		else
			L.visible_message("<span class='danger'>[user] attempts to apply a used patch to you, but it's empty.</span>", \
					"<span class='notice'>[user] attempts to apply a used patch to you, but it's empty.</span>")
		return FALSE

	if(!canconsume(L, user))
		return FALSE

	if(L == user)
		L.visible_message("<span class='notice'>[user] attempts to [apply_method] [src].</span>")
		if(self_delay)
			if(!do_mob(user, L, self_delay))
				return FALSE
		to_chat(L, "<span class='notice'>I [apply_method] [src].</span>")

	else
		L.visible_message("<span class='danger'>[user] attempts to force [L] to [apply_method] [src].</span>", \
					"<span class='danger'>[user] attempts to force you to [apply_method] [src].</span>")
		if(!do_mob(user, L))
			return FALSE
		L.visible_message("<span class='danger'>[user] forces [L] to [apply_method] [src].</span>", \
					"<span class='danger'>[user] forces you to [apply_method] [src].</span>")

	if(src.reagents.total_volume)
		src.reagents.trans_to(L, src.reagents.total_volume, transfered_by = user, method = src.apply_type)
		src.reagents.clear_reagents()

	// Convert the used patch in-place so it stays in the same inventory slot/hand
	src.icon_state = "pill1"
	src.item_state = "pill1"
	src.name = "used chemical patch"
	src.desc = "An adhesive patch that's been used and is now empty."
	src.volume = 0
	src.apply_type = 0
	src.self_delay = 0
	src.list_reagents = list()
	src.used = TRUE
	return TRUE

/obj/item/reagent_containers/pill/patch/canconsume(mob/eater, mob/user)
	if(used)
		return 0
	if(!iscarbon(eater))
		return 0
	return 1 // Masks were stopping people from "eating" patches. Thanks, inheritance.

/obj/item/reagent_containers/pill/patch/syringe
	name = "syringe"
	desc = "Report if you see this."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "syringe"
	item_state = "syringe"
	possible_transfer_amounts = list()
	volume = 27
	apply_type = INJECT
	slot_flags = ITEM_SLOT_MOUTH
	apply_method = "inject"
	self_delay = 0
	dissolvable = FALSE
	list_reagents = list()

/obj/item/reagent_containers/pill/patch/syringe/health
	name = "health injection"
	desc = "A standard-issue health syringe. Excels at sealing cuts and restoring wounds, at the exchange of speeding up your metabolism drastically. There's a tiny, imperceptible label that says, 'WARNING, DO NOT INJECT MORE THAN ONE AT A TIME'."
	icon_state = "syringered"
	list_reagents = list(/datum/reagent/medicine/stronghealth = 27)

/obj/item/reagent_containers/pill/patch/syringe/healthexpired
	name = "expired health injection"
	desc = "An expired standard-issue health syringe. Although it isn't as effective, it still provides some healing with reduced potency, including the side-effects. Any suggestion of a label is illegible, and scratched off."
	icon_state = "syringered"
	list_reagents = list(/datum/reagent/medicine/healthpot = 27)

/obj/item/reagent_containers/pill/patch/syringe/painkiller
	name = "morphine injection"
	desc = "An injector syringe that's supposed to kill the pain. There's a tiny, imperceptible label that says, 'WARNING, DO NOT INJECT MORE THAN ONE AT A TIME'."
	icon_state = "syringegreen"
	list_reagents = list(/datum/reagent/herozium = 15)

/obj/item/reagent_containers/pill/patch/syringe/used
	name = "used syringe"
	desc = "A syringe that's been used and is now empty."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "syringeused"
	item_state = "syringeused"
	possible_transfer_amounts = list()
	volume = 0
	apply_type = 0
	apply_method = "inject"
	self_delay = 0
	dissolvable = FALSE
	list_reagents = list()


/obj/item/reagent_containers/pill/patch/used/canconsume(mob/eater, mob/user)
	return 0


/obj/item/reagent_containers/pill/patch/used/attack(mob/M, mob/user, def_zone)
	if(M == user)
		to_chat(M, "<span class='notice'>This patch is used and can't be applied.</span>")
	else
		M.visible_message("<span class='danger'>[user] attempts to apply a used patch to you, but it's empty.</span>", \
				  "<span class='notice'>[user] attempts to apply a used patch to you, but it's empty.</span>")
	return FALSE


/obj/item/reagent_containers/pill/patch/syringe/used/canconsume(mob/eater, mob/user)
	return 0


/obj/item/reagent_containers/pill/patch/syringe/used/attack(mob/M, mob/user, def_zone)
	if(M == user)
		to_chat(M, "<span class='notice'>This syringe is used and can't be injected.</span>")
	else
		M.visible_message("<span class='danger'>[user] attempts to inject a used syringe into you, but it's empty.</span>", \
				  "<span class='notice'>[user] attempts to inject a used syringe into you, but it's empty.</span>")
	return FALSE

/obj/item/reagent_containers/pill/patch/syringe/attack(mob/living/L, mob/user)
	if(ishuman(L))
		var/obj/item/bodypart/affecting = L.get_bodypart(check_zone(user.zone_selected))
		if(!affecting)
			to_chat(user, "<span class='warning'>The limb is missing!</span>")
			return
		if(affecting.status != BODYPART_ORGANIC)
			to_chat(user, "<span class='notice'>Medicine won't work on a robotic limb!</span>")
			return

	// convert the same item instance into a used syringe instead of changing its type
	if(src.used)
		if(L == user)
			to_chat(L, "<span class='notice'>This syringe is used and can't be injected.</span>")
		else
			L.visible_message("<span class='danger'>[user] attempts to inject a used syringe into you, but it's empty.</span>", \
					"<span class='notice'>[user] attempts to inject a used syringe into you, but it's empty.</span>")
		return FALSE

	if(!canconsume(L, user))
		return FALSE

	if(L == user)
		L.visible_message("<span class='notice'>[user] attempts to [apply_method] [src].</span>")
		if(self_delay)
			if(!do_mob(user, L, self_delay))
				return FALSE
		to_chat(L, "<span class='notice'>I [apply_method] [src].</span>")

	else
		L.visible_message("<span class='danger'>[user] attempts to force [L] to [apply_method] [src].</span>", \
					"<span class='danger'>[user] attempts to force you to [apply_method] [src].</span>")
		if(!do_mob(user, L))
			return FALSE
		L.visible_message("<span class='danger'>[user] forces [L] to [apply_method] [src].</span>", \
					"<span class='danger'>[user] forces you to [apply_method] [src].</span>")

	if(src.reagents.total_volume)
		src.reagents.trans_to(L, src.reagents.total_volume, transfered_by = user, method = src.apply_type)
		src.reagents.clear_reagents()

	// Convert the used syringe in-place so it stays in the same inventory slot/hand
	src.icon_state = "syringeused"
	src.item_state = "syringeused"
	src.name = "used syringe"
	src.desc = "A syringe that's been used and is now empty."
	src.volume = 0
	src.apply_type = 0
	src.self_delay = 0
	src.list_reagents = list()
	src.used = TRUE
	return TRUE
