/datum/reagent/meth
	name = "meth"
	color = "#edeff1" // This shit is WHITE.
	overdose_threshold = 8
	metabolization_rate = 0.0002083 //5 units needs to last 20 minutes at the LEAST

/obj/item/reagent_containers/powder/meth
	name = "meth"
	desc = ""
	icon = 'icons/roguetown/items/produce.dmi'
	icon_state = "spice"
	item_state = "spice"
	possible_transfer_amounts = list()
	volume = 15
	list_reagents = list(/datum/reagent/meth = 15)
	grind_results = list(/datum/reagent/meth = 15)

/obj/item/reagent_containers/glass/bottle/alchemical/meth
	name = "vial (stimulants)"
	desc = ""
	list_reagents = list(/datum/reagent/meth = 27)

/datum/reagent/meth/on_mob_life(mob/living/carbon/M)
	if(M.has_flaw(/datum/charflaw/addiction/meth))
		M.sate_addiction()
	M.apply_status_effect(/datum/status_effect/meth)
	..()

/datum/reagent/meth/overdose_start(mob/living/M)
	to_chat(M, span_subtle("It's too much..."))
	if(iscarbon(M))
		var/mob/living/carbon/C = M
		C.emote("breathgasp", forced = TRUE)
		spawn(3 SECONDS)
			C.vomit(stun = TRUE)
			C.heart_attack() // Teehee.

/datum/reagent/meth/on_mob_end_metabolize(mob/living/M)
	M.remove_status_effect(/datum/status_effect/meth)

