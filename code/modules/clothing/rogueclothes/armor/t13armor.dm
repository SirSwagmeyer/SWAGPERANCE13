
//this shit is mad broken and slated to be deleted. oops!


/obj/item/clothing/suit/roguetown/armor/plate/full/ebarmor
	name = "manufactured armor plate"
	desc = "A standard, manufactured armor plate produced by the WAR MACHINE."
	icon = 'icons/roguetown/clothing/armor.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/armor.dmi'
	icon_state = "EB_armor"
	item_state = "EB_armor"
	armor = ARMOR_GRUDGEBEARER
	allowed_race = ALL_RACES_TYPES
	prevent_crits = list(BCLASS_TWIST)
	body_parts_covered = CHEST|GROIN|VITALS
	equip_delay_self = 5 SECONDS
	unequip_delay_self = 5 SECONDS
	equip_delay_other = 1 SECONDS
	strip_delay = 2 SECONDS
	smelt_bar_num = 4
	max_integrity = 1000
	sleeved = null

/obj/item/clothing/suit/roguetown/armor/plate/full/ebarmor/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/layeredarmor/ebarmor)

/datum/component/layeredarmor/ebarmor/
	hits_to_shred = list(
		"blunt" = 10,
		"slash" = 10,
		"stab" = 10,
		"piercing" = 10,
	)

	layer_max = list(
		"blunt" = 40,
		"slash" = 100,
		"stab" = 100,
		"piercing" = 90,
	)

	hits_per_layer = list(
		"100"	= 10,
		"70" 	= 10,
		"40" 	= 10,
		"10" 	= 10,
	)

	damtype_shred_ratio = list(
		"blunt" = 5,
		"slash" = 1,
		"stab" = 1,
		"piercing" = 5,
	)

	shred_amt = 30
	layer_repair = 3
	shred_sound = 'sound/combat/armorblock.ogg'

/obj/item/clothing/suit/roguetown/armor/plate/full/ebarmor/pauldrons
	name = "pauldroned armor plate"
	desc = "A humen-modified, manufactured armor plate. MACHINE-made, with pauldrons slapped on."
	icon = 'icons/roguetown/clothing/armor.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/armor.dmi'
	icon_state = "EB_armor_pauldrons"
	item_state = "EB_armor_pauldrons"
	body_parts_covered = CHEST|GROIN|VITALS|ARMS
	sleeved = null

/obj/item/clothing/suit/roguetown/armor/plate/full/ebarmor/pauldrons/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/layeredarmor/ebarmor)


/obj/item/clothing/suit/roguetown/armor/plate/full/iron //moved from plate.dm
	name = "iron plate armor"
	icon_state = "iplate"
	desc = "Full iron plate armor. Slow to don and doff without the aid of an Armsman."
	smeltresult = /obj/item/ingot/iron
	armor = ARMOR_PLATE_GOOD
	allowed_race = ALL_RACES_TYPES
	prevent_crits = list(BCLASS_TWIST)
	equip_delay_self = 5 SECONDS
	unequip_delay_self = 5 SECONDS
	equip_delay_other = 1 SECONDS
	strip_delay = 2 SECONDS
	smelt_bar_num = 4
	max_integrity = ARMOR_INT_CHEST_PLATE_PSYDON

//light armor

/obj/item/clothing/suit/roguetown/armor/leather/grandmaster
	name = "master's cloak"
	desc = "A full-body suit, stolen from a WAR MACHINE. Rather expensive. Comes with a decorative tin shoulder."
	icon_state = "grandmaster"
	item_state = "grandmaster"
	body_parts_covered = COVERAGE_FULL
	sleeved = 'icons/roguetown/clothing/onmob/helpers/sleeves_armor.dmi'
	sleevetype = "grandmaster"

/obj/item/clothing/suit/roguetown/armor/leather/consulo
	name = "consulo's coat"
	desc = "One of the few trench coats you'll actually see. Very, very expensive."
	icon_state = "consulo"
	item_state = "consulo"
	body_parts_covered = COVERAGE_FULL
	sellprice = 800 //kill the enemy's diplomat for insane amounts of money

/obj/item/clothing/suit/roguetown/armor/leather/envoy
	name = "envoy's coat"
	desc = "A stylish piece, meant to showcase Perserdun's strong economy."
	icon_state = "envoy"
	item_state = "envoy"
	body_parts_covered = COVERAGE_FULL
	sellprice = 400

/obj/item/clothing/suit/roguetown/armor/leather/mortician
	name = "mortici's robes"
	desc = "A set of clothing that's meant to protect from scalpel nicks."
	icon_state = "mortician"
	item_state = "mortician"
	body_parts_covered = COVERAGE_FULL

/obj/item/clothing/suit/roguetown/armor/leather/heavy/bulwark
	name = "heavy coat"
	desc = "It feels weird to walk around in. There's plates sewn into the inside of this piece, so it's suseptible to being cut."
	icon_state = "northprotector"
	item_state = "northprotector"
	body_parts_covered = COVERAGE_FULL
	max_integrity = ARMOR_INT_CHEST_LIGHT_MEDIUM
	equip_delay_self = 40
	armor = list("blunt" = 100, "slash" = 50, "stab" = 80, "piercing" = 80, "fire" = 0, "acid" = 0)

/obj/item/clothing/suit/roguetown/armor/leather/heavy/hierarch
	name = "leader's guard"
	desc = "Silks and cloth, with some padded leather."
	icon_state = "officerguard"
	item_state = "officerguard"
	body_parts_covered = COVERAGE_FULL
	max_integrity = ARMOR_INT_CHEST_LIGHT_MEDIUM
	equip_delay_self = 40

/obj/item/clothing/suit/roguetown/armor/gambeson/heavy/bulwark
	name = "YKT-34 'Heart'"
	desc = "It's a padded uniform."
	icon = 'icons/roguetown/clothing/shirts.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/shirts.dmi' // sorry for this shit code, i just cant be fucked
	sleeved = 'icons/roguetown/clothing/onmob/helpers/sleeves_shirts.dmi'
	icon_state = "bulwark"
	item_state = "bulwark"
