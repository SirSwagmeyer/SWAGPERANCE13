

//heavy helmets

/obj/item/clothing/head/roguetown/helmet/heavy/ebhelmet
	name = "manufactured kettle helmet"
	desc = "A helmet made by a foreign WAR MACHINE. Exposes the face."
	body_parts_covered = HEAD|HAIR|EARS
	armor = ARMOR_GRUDGEBEARER
	prevent_crits = list(BCLASS_TWIST)
	allowed_race = ALL_RACES_TYPES
	icon = 'icons/roguetown/clothing/head.dmi'
	icon_state = "EB_helm"
	item_state = "EB_helm"
	block2add = FOV_DEFAULT
	bloody_icon = 'icons/effects/blood64.dmi'
	smeltresult = /obj/item/ingot/steel
	max_integrity = 1000
	experimental_inhand = TRUE
	experimental_onhip = TRUE

/obj/item/clothing/head/roguetown/helmet/heavy/ebhelmet/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/layeredarmor/ebarmor) //defined in t13armor.dm

/obj/item/clothing/head/roguetown/helmet/heavy/ebhelmet/visored
	name = "armored kettle helmet"
	desc = "A helmet made by a foreign WAR MACHINE. This one's been modified to have a visor."
	icon_state = "EB_helm_armored"
	item_state = "EB_helm_armored"
	body_parts_covered = FULL_HEAD
	flags_inv = HIDEFACE

/obj/item/clothing/suit/roguetown/helmet/heavy/ebhelmet/visored/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/layeredarmor/ebarmor)


// medium helmets
/obj/item/clothing/head/roguetown/helmet/kettle/iron/visored
	name = "decorated kettle helmet"
	desc = "A kettle helmet. It has the visor of a stolen Knight Commander's helmet welded onto it."
	icon_state = "ikettlevisor"
	item_state = "ikettlevisor"

/obj/item/clothing/head/roguetown/helmet/kettle/iron/oficiro
	name = "iron ziggurate helmet"
	desc = "A metal helmet. It kinda looks like a sallet."
	icon_state = "oficiro"
	item_state = "oficiro"

/obj/item/clothing/head/roguetown/helmet/kettle/iron/commandant
	name = "iron ziggurate helmet"
	desc = "A metal helmet. Custom made. For the Ziggurate!"
	icon_state = "commandant"
	item_state = "commandant"


// light helmets

/obj/item/clothing/head/roguetown/helmet/leather/grandmaster
	name = "master's cap"
	desc = "A handcrafted cap, following the fashion style produced by the LOVE MACHINE. Has a metal plate on the front."
	icon_state = "grandhat"
	item_state = "grandhat"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/32x48/greatcap.dmi'
	bloody_icon = 'icons/effects/blood64.dmi'
	worn_x_dimension = 32
	worn_y_dimension = 44
	experimental_inhand = FALSE
	experimental_onhip = FALSE
	flags_inv = HIDE_HEADTOP

/obj/item/clothing/head/roguetown/helmet/leather/envoy
	name = "envoy's cap"
	desc = "A handcrafted cap, in line with Perserdunian diplomatic standards. Padded."
	icon_state = "envoy"
	item_state = "envoy"
	experimental_inhand = FALSE
	experimental_onhip = FALSE
	sellprice = 200
	flags_inv = HIDE_HEADTOP
