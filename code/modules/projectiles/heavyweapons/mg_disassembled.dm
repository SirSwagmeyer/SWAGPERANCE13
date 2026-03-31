///////////////////////////////
////GUN FOR MACHINEGUNS////////
///////////////////////////////

/obj/item/mg_disassembled
	name = "disassembled stationary machinegun"
	icon = 'icons/obj/stationary_guns.dmi'
	icon_state = "basic-mg-disconnected"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	var/id_g = "bmg"

/obj/item/mg_disassembled/spandau
	name = "disassembled 'Spandau' HMG"
	desc = "The feared 'Spandau' heavy machine gun. The rare pieces of machine-produced production the Imperials can get their hands on go into weapons like this."
	icon_state = "spandau-disconnected"
	id_g = "spd"

/obj/item/mg_disassembled/mark1
	name = "disassembled 'Mark 1' HMG"
	desc = "A top of the line, universally feared machine-produced heavy machine gun. The national Risvon WAR machine very rarely produces these things."
	icon_state = "utes"
	icon_state = "mark1-disconnected"
	id_g = "mk1"

/obj/item/mg_disassembled/m2
	name = "disassembled M2"
	desc = "A slick, top of the line War Machine production. Fires .50D. Needs to be placed it's tripod."
	icon_state = "m2-disconnected"
	id_g = "mbr"
