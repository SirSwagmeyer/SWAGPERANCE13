/datum/supply_pack/rogue/fortifications
	group = "FORTIFICATIONS"
	crate_name = "merchant guild's crate"
	crate_type = /obj/structure/closet/crate/chest/merchant

/datum/supply_pack/rogue/fortifications/sandbags
	name = "Sandbags (x3)"
	cost = 5
	contains = list(/obj/item/sandbag, 
	/obj/item/sandbag, 
	/obj/item/sandbag)

/datum/supply_pack/rogue/fortifications/barbedwire
	name = "Barbed Wire (x3)"
	cost = 20
	contains = list(/obj/item/barbedwire, 
	/obj/item/barbedwire,
	/obj/item/barbedwire)

/datum/supply_pack/rogue/fortifications/landmine
	name = "Landmines (x2)"
	cost = 30
	contains = list(/obj/item/landmine,
	/obj/item/landmine)

/datum/supply_pack/rogue/fortifications/frogmine
	name = "Frogmines (x3)"
	cost = 30 //A little cheaper since you can survive these by putting stuff on them
	contains = list(/obj/item/frogmine,
	/obj/item/frogmine,
	/obj/item/frogmine)
