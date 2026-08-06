/obj/item/reagent_containers/glass/foodcan
	name = "empty can"
	desc = "An empty food can."
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "can_trash"
	amount_per_transfer_from_this = 5
	possible_transfer_amounts = list(5,10,15,20)
	volume = 50
	drop_sound = 'sound/foley/dropsound/can_drop.ogg'
	place_sound = 'sound/foley/dropsound/can_drop.ogg'

/obj/item/reagent_containers/food/snacks/canned
	name = "food can"
	desc = "A sealed can with some kind of food inside."
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "can_gen"
	var/base_state = "can_gen"
	trash = /obj/item/reagent_containers/glass/foodcan
	w_class = WEIGHT_CLASS_SMALL
	var/opened = FALSE
	var/open_chance = 0 // Base chance for opening with a knife
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	drop_sound = 'sound/foley/dropsound/can_drop.ogg'
	place_sound = 'sound/foley/dropsound/can_drop.ogg'

/obj/item/reagent_containers/food/snacks/canned/generate_trash(atom/location)
	if(trash)
		if(ispath(trash, /obj/item))
			var/obj/item/C = new trash(location)
			trash = null
			C.icon_state = "[base_state]_empty"
			return C

/obj/item/reagent_containers/food/snacks/canned/Initialize()
	. = ..()

/obj/item/reagent_containers/food/snacks/canned/attack(mob/living/M, mob/living/user, def_zone)
	if(!opened)
		to_chat(user, "<span class='warning'>Needs to be opened.</span>")
		return
	return ..()

/obj/item/reagent_containers/food/snacks/canned/attackby(obj/item/W, mob/user, params)
	if(!opened)
		user.changeNext_move(CLICK_CD_MELEE)
		if(W.wlength == WLENGTH_SHORT && W.sharpness == IS_SHARP)
			playsound(src, 'sound/items/canopen.ogg', 100, TRUE)
			if(prob(open_chance))
				open_can(user, FALSE)
			else
				open_chance += 20
				to_chat(user, "<span class='warning'>I try to open the can.</span>")
			return
	return ..()

/obj/item/reagent_containers/food/snacks/canned/proc/open_can(mob/user, clean_open = TRUE)
	opened = TRUE
	icon_state = "[base_state]_open"
	if(clean_open)
		to_chat(user, "<span class='notice'>I open the can.</span>")
	else
		to_chat(user, "<span class='notice'>I manage to pry the can open.</span>")
