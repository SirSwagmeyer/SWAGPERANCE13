/*
LOREDUMP TILES.

There are the actual tiles that dispense lore unto thee. 
Very handy, eh?
*/

/obj/effect/loretile
	name = "Lore Tile"
	icon = 'icons/effects/landmarks_static.dmi'
	icon_state = "x2"
	anchored = TRUE
	layer = HIGH_LANDMARK_LAYER
	invisibility = INVISIBILITY_ABSTRACT
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

	//This is what actually contains the loreblurb it'll dispense upon a man...
	var/datum/loreblurb/lore = null


/obj/effect/loretile/Crossed(AM as mob|obj)
	if(ishuman(AM))
		var/mob/living/carbon/human/H = AM
		if(lore)
			var/datum/loreblurb/lore_instance = new lore
			lore_instance.onEncounter(H)


//Just an example cuz
/obj/effect/loretile/ruinedcity
	name = "Ruined City Lore Tile"
	lore = /datum/loreblurb/ruined_city

/obj/effect/loretile/butchersblock
	name = "Butcher's Block Lore Tile"
	lore = /datum/loreblurb/butchersblock

/obj/effect/loretile/outpostjulius
	name = "Outpost Julius Lore Tile"
	lore = /datum/loreblurb/outpostjulius

/obj/effect/loretile/artillerysector
	name = "Artillery Sector Lore Tile"
	lore = /datum/loreblurb/artillerysector

/obj/effect/loretile/rostrumlemuria
	name = "Rostrum Lemuria Lore Tile"
	lore = /datum/loreblurb/rostrumlemuria

/obj/effect/loretile/bastillexiphos
	name = "Bastille Xiphos Lore Tile"
	lore = /datum/loreblurb/bastillexiphos

/obj/effect/loretile/funnyoutlet
	name = "Funny Outlet Lore Tile"
	lore = /datum/loreblurb/funnyoutlet

/obj/effect/loretile/code1
	name = "Code 1 Lore Tile"
	lore = /datum/loreblurb/code1

/obj/effect/loretile/apartments
	name = "Apartments Lore Tile"
	lore = /datum/loreblurb/apartments

/obj/effect/loretile/code2
	name = "Code 2 Lore Tile"
	lore = /datum/loreblurb/code2

/obj/effect/loretile/hospital
	name = "Hospital Lore Tile"
	lore = /datum/loreblurb/hospital

/obj/effect/loretile/code3
	name = "Code 3 Lore Tile"
	lore = /datum/loreblurb/code3

/obj/effect/loretile/factory
	name = "Factory Lore Tile"
	lore = /datum/loreblurb/factory

/obj/effect/loretile/umamusume
	name = "Umamusume Lore Tile"
	lore = /datum/loreblurb/umamusume

/obj/effect/loretile/code4
	name = "Code 4 Lore Tile"
	lore = /datum/loreblurb/code4

/obj/effect/loretile/code5
	name = "Code 5 Lore Tile"
	lore = /datum/loreblurb/code5

/obj/effect/loretile/code6
	name = "Code 6 Lore Tile"
	lore = /datum/loreblurb/code6

/obj/effect/loretile/kingsrow
	name = "King's Row Lore Tile"
	lore = /datum/loreblurb/kingsrow
