/obj/item/clothing/suit/roguetown/shirt/robe
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT|ITEM_SLOT_CLOAK
	name = "robe"
	desc = ""
	body_parts_covered = CHEST|GROIN|ARMS|LEGS|VITALS
	icon_state = "white_robe"
	icon = 'icons/roguetown/clothing/armor.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/armor.dmi'
	sleeved = 'icons/roguetown/clothing/onmob/helpers/sleeves_armor.dmi'
	boobed = TRUE
	flags_inv = HIDEBOOB|HIDECROTCH
	color = "#7c6d5c"
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL
	experimental_inhand = FALSE

/obj/item/clothing/suit/roguetown/shirt/robe/equipped(mob/user, slot, initial = FALSE)
    . = ..()
    if(slot == SLOT_CLOAK)
        src.sleeved = null
    else
        src.sleeved = initial(src.sleeved) // just in case it bugs out somehow
    update_icon()

/obj/item/clothing/suit/roguetown/shirt/robe/dropped(mob/user)
    . = ..()
    src.sleeved = initial(src.sleeved)
    update_icon()

/obj/item/clothing/suit/roguetown/shirt/robe/astrata
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT|ITEM_SLOT_CLOAK
	name = "sun robe"
	desc = ""
	body_parts_covered = CHEST|GROIN|ARMS|LEGS|VITALS
	icon_state = "astratarobe"
	icon = 'icons/roguetown/clothing/armor.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/armor.dmi'
	sleeved = null
	boobed = TRUE
	color = null
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL

/obj/item/clothing/suit/roguetown/shirt/robe/abyssor //thanks to cre for abyssor clothing sprites
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT|ITEM_SLOT_CLOAK
	name = "depths robe"
	desc = ""
	body_parts_covered = CHEST|GROIN|ARMS|LEGS|VITALS
	icon_state = "abyssorrobe"
	icon = 'icons/roguetown/clothing/armor.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/armor.dmi'
	sleeved = 'icons/roguetown/clothing/onmob/helpers/sleeves_armor.dmi'
	boobed = TRUE
	color = null
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL

/obj/item/clothing/suit/roguetown/shirt/robe/noc
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT|ITEM_SLOT_CLOAK
	name = "moon robe"
	desc = ""
	body_parts_covered = CHEST|GROIN|ARMS|LEGS|VITALS
	icon_state = "nocrobe"
	icon = 'icons/roguetown/clothing/armor.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/armor.dmi'
	sleeved = null
	boobed = TRUE
	color = null
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL

/obj/item/clothing/suit/roguetown/shirt/robe/necromancer
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT|ITEM_SLOT_CLOAK
	name = "necromancer robes"
	desc = ""
	body_parts_covered = CHEST|GROIN|ARMS|LEGS|VITALS
	icon_state = "necromrobe"
	icon = 'icons/roguetown/clothing/armor.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/armor.dmi'
	sleeved = null
	boobed = TRUE
	color = null
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL

/obj/item/clothing/suit/roguetown/shirt/robe/dendor
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT|ITEM_SLOT_CLOAK
	name = "briar robe"
	desc = ""
	body_parts_covered = CHEST|GROIN|ARMS|LEGS|VITALS
	icon_state = "dendorrobe"
	icon = 'icons/roguetown/clothing/armor.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/armor.dmi'
	sleeved = null
	boobed = TRUE
	color = null
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL

/obj/item/clothing/suit/roguetown/shirt/robe/necra
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT|ITEM_SLOT_CLOAK
	name = "mourning robe"
	desc = ""
	body_parts_covered = CHEST|GROIN|ARMS|LEGS|VITALS
	icon_state = "necrarobe"
	icon = 'icons/roguetown/clothing/armor.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/armor.dmi'
	sleeved = 'icons/roguetown/clothing/onmob/helpers/sleeves_armor.dmi'
	boobed = TRUE
	color = null
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL

/obj/item/clothing/suit/roguetown/shirt/robe/black
	color = CLOTHING_BLACK

/obj/item/clothing/suit/roguetown/shirt/robe/white
	color = CLOTHING_WHITE

/obj/item/clothing/suit/roguetown/shirt/robe/warpriest
	name = "war priest vestments"
	desc = "Vestments sanctified by the War Priest themselves. Stains of blood line the fabric."
	icon_state = "priestrobe"
	color = "#3A3A71"
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT
	armor = ARMOR_PADDED	//Equal to gamby

/obj/item/clothing/suit/roguetown/shirt/robe/warpriest/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_COMPONENT_CLEAN_ACT, PROC_REF(on_clean))

/obj/item/clothing/proc/update_bloodied()
	if(ishuman(loc))
		var/mob/living/carbon/human/H = loc
		if((H.wear_armor == src || H.wear_shirt == src) && HAS_TRAIT(H, TRAIT_RABCHOSEN))
			if(HAS_BLOOD_DNA(src) && !HAS_TRAIT(H, TRAIT_BLOODIED_ROBE))
				ADD_TRAIT(H, TRAIT_BLOODIED_ROBE, TRAIT_GENERIC)
				to_chat(H, span_notice("THE BLOOD OF WARRIORS SEEPS INTO MY VESTMENTS, EMPOWERING ME!"))
				H.playsound_local(H, 'sound/magic/bloodied_robes.ogg', 100)
			else if(!HAS_BLOOD_DNA(src) && HAS_TRAIT(H, TRAIT_BLOODIED_ROBE))
				REMOVE_TRAIT(H, TRAIT_BLOODIED_ROBE, TRAIT_GENERIC)
				to_chat(H, span_notice("The blood fades from my vestments..."))

/obj/item/clothing/suit/roguetown/shirt/robe/warpriest/equipped(mob/living/user, slot)
	..()
	if(slot != SLOT_ARMOR && slot != SLOT_SHIRT)
		return
	update_bloodied()

/obj/item/clothing/suit/roguetown/shirt/robe/warpriest/dropped(mob/living/user)
	..()
	if(HAS_TRAIT(user, TRAIT_BLOODIED_ROBE))
		REMOVE_TRAIT(user, TRAIT_BLOODIED_ROBE, TRAIT_GENERIC)
		to_chat(user, span_notice("I lose that sense of vigor as I lay down my vestments..."))

/obj/item/clothing/suit/roguetown/shirt/robe/warpriest/add_blood_DNA(list/dna)
	. = ..()
	update_bloodied()

/obj/item/clothing/suit/roguetown/shirt/robe/warpriest/proc/on_clean(datum/source, clean)
	addtimer(CALLBACK(src, PROC_REF(update_bloodied)), 1) // delay is required or it runs too early

/obj/item/clothing/suit/roguetown/shirt/robe/monk
	name = "monk vestments"
	desc = "Holy vestments worn by the most faithful."
	icon_state = "monkvestments"
	item_state = "monkvestments"
	armor = ARMOR_PADDED	//Equal to gamby
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT

// /obj/item/clothing/suit/roguetown/shirt/robe/monk/equipped(mob/living/user, slot)
// 	..()
// 	if(!HAS_TRAIT(user, TRAIT_CIVILIZEDBARBARIAN))	//Requires this cus it's a monk-only thing.
// 		return
// 	ADD_TRAIT(user, TRAIT_MONK_ROBE, TRAIT_GENERIC)
// 	to_chat(user, span_notice("With my vows to poverty and my vestments, I feel vigerous - empowered by the gods!"))

// /obj/item/clothing/suit/roguetown/shirt/robe/monk/dropped(mob/living/user)
// 	..()
// 	REMOVE_TRAIT(user, TRAIT_MONK_ROBE, TRAIT_GENERIC)
// 	to_chat(user, span_notice("I must lay down my robes and rest; even god's chosen must rest.."))

/obj/item/clothing/suit/roguetown/shirt/robe/courtmage
	color = "#6c6c6c"

/obj/item/clothing/suit/roguetown/shirt/robe/mage/Initialize()
	color = pick("#4756d8", "#759259", "#bf6f39", "#c1b144", "#b8252c")
	. = ..()

/obj/item/clothing/suit/roguetown/shirt/robe/mageblue
	color = "#4756d8"

/obj/item/clothing/suit/roguetown/shirt/robe/magegreen
	color = "#759259"

/obj/item/clothing/suit/roguetown/shirt/robe/mageorange
	color = "#bf6f39"

/obj/item/clothing/suit/roguetown/shirt/robe/magered
	color = "#b8252c"

/obj/item/clothing/suit/roguetown/shirt/robe/mageyellow
	color = "#c1b144"

/obj/item/clothing/suit/roguetown/shirt/robe/merchant
	name = "guilder jacket"
	icon_state = "merrobe"
	sellprice = 30
	color = null

/obj/item/clothing/suit/roguetown/shirt/robe/nun
	name = "nun's habit"
	color = null
	icon_state = "nun"
	item_state = "nun"
	allowed_sex = list(MALE, FEMALE)

/obj/item/clothing/suit/roguetown/shirt/robe/wizard
	name = "wizard's robe"
	desc = "Billowy, oversized robes with golden star designs. Perfect for the practicing magos."
	icon_state = "wizardrobes"
	icon = 'icons/roguetown/clothing/shirts.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/shirts.dmi'
	sleeved = 'icons/roguetown/clothing/onmob/shirts.dmi'
	boobed = TRUE
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL
	allowed_sex = list(MALE, FEMALE)
	allowed_race = NON_DWARVEN_RACE_TYPES
	color = null
	sellprice = 100

/obj/item/clothing/suit/roguetown/shirt/robe/physician
	name = "plague coat"
	desc = "Medicum morbo adhibere."
	icon = 'icons/roguetown/clothing/armor.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/armor.dmi'
	icon_state = "physcoat"
	slot_flags = ITEM_SLOT_ARMOR
	sleeved = 'icons/roguetown/clothing/onmob/helpers/sleeves_armor.dmi'
	boobed = TRUE
	color = null
	flags_inv = HIDEBOOB|HIDETAIL
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL
	resistance_flags = FIRE_PROOF

//Eora content from Stonekeep

/obj/item/clothing/suit/roguetown/shirt/robe/eora
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT|ITEM_SLOT_CLOAK
	name = "eoran robe"
	desc = "Holy robes, intended for use by followers of Eora"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS|VITALS
	icon_state = "eorarobes"
	icon = 'icons/roguetown/clothing/armor.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/armor.dmi'
	sleeved = 'icons/roguetown/clothing/onmob/helpers/sleeves_armor.dmi'
	boobed = TRUE
	color = null
	flags_inv = HIDEBOOB|HIDECROTCH
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL
	var/fanatic_wear = FALSE

/obj/item/clothing/suit/roguetown/shirt/robe/eora/alt
	name = "open eoran robe"
	desc = "Used by more radical followers of the Eoran Church"
	body_parts_covered = null
	icon_state = "eorastraps"
	flags_inv = HIDEBOOB
	fanatic_wear = TRUE

/obj/item/clothing/suit/roguetown/shirt/robe/eora/attack_right(mob/user)
	switch(fanatic_wear)
		if(FALSE)
			name = "open eoran robe"
			desc = "Used by more radical followers of the Eoran Church"
			body_parts_covered = null
			icon_state = "eorastraps"
			fanatic_wear = TRUE
			flags_inv = HIDEBOOB
			to_chat(usr, span_warning("Now wearing radically!"))
		if(TRUE)
			name = "eoran robe"
			desc = "Holy robes, intended for use by followers of Eora"
			body_parts_covered = CHEST|GROIN|ARMS|LEGS|VITALS
			icon_state = "eorarobes"
			fanatic_wear = FALSE
			flags_inv = HIDEBOOB|HIDECROTCH
			to_chat(usr, span_warning("Now wearing normally!"))
	update_icon()
	if(ismob(loc))
		var/mob/L = loc
		L.update_inv_armor()

/obj/item/clothing/suit/roguetown/shirt/robe/hierophant
	name = "hierophant's kandys"
	desc = "A thin piece of fabric worn under a robe to stop chafing and keep ones dignity if a harsh blow of wind comes through. Despite the light fabric, it offers decent protection."
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT, BCLASS_CHOP)
	armor = ARMOR_PADDED_GOOD
	icon_state = "desertgown"
	item_state = "desertgown"
	color = null

/obj/item/clothing/suit/roguetown/shirt/robe/pointfex
	name = "pointfex's qaba"
	desc = "A slimmed down, tighter fitting robe made of fine silks and fabrics. Somehow you feel more mobile in it than in the nude. Despite the light fabric, it offers decent protection."
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT, BCLASS_CHOP)
	armor = ARMOR_PADDED_GOOD
	icon_state = "monkcloth"
	item_state = "monkcloth"
	color = null
	r_sleeve_status = SLEEVE_NOMOD
	l_sleeve_status = SLEEVE_NOMOD

/obj/item/clothing/suit/roguetown/shirt/robe/feld
	name = "feldsher's robe"
	desc = "Red to hide the blood."
	icon_state = "feldrobe"
	item_state = "feldrobe"

/obj/item/clothing/suit/roguetown/shirt/robe/phys
	name = "physicker's robe"
	desc = "Part robe, part butcher's apron."
	icon_state = "surgrobe"
	item_state = "surgrobe"
