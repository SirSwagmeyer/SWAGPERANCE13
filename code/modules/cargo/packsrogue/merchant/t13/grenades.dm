/datum/supply_pack/rogue/grenades
	group = "GRENADES"
	crate_name = "merchant guild's crate"
	crate_type = /obj/structure/closet/crate/chest/merchant

/datum/supply_pack/rogue/grenades/smoke
	name = "Smoke Grenades (x3)"
	cost = 20
	contains = list(/obj/item/grenade/gas/smoke, 
	/obj/item/grenade/gas/smoke, 
	/obj/item/grenade/gas/smoke)

/datum/supply_pack/rogue/grenades/gas
	name = "Gas Grenades (x3)"
	cost = 60
	contains = list(/obj/item/grenade/gas/poison, 
	/obj/item/grenade/gas/poison,
	/obj/item/grenade/gas/poison)

/datum/supply_pack/rogue/grenades/highexplosive
	name = "High-Explosive Grenades (x3)"
	cost = 65
	contains = list(/obj/item/grenade, 
	/obj/item/grenade, 
	/obj/item/grenade)
