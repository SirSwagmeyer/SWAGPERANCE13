/obj/item/clothing/gloves/roguetown/leather/ebgloves
	name = "manufactured gloves"
	desc = "Shooting gloves made out of an irreplicable substance known as 'rubber'."
	icon_state = "EB_gloves"

/obj/item/clothing/gloves/roguetown/leather/latex
	name = "latex gloves"
	desc = "Gloves produced by the LIFE MACHINE. Typically used by field medics and workmen."
	icon_state = "sterile_gloves"

/obj/item/clothing/gloves/roguetown/leather/midsomber/Initialize(mapload)
	. = ..()
	name = "hardblood gloves"
	desc = "A product of blood magic. Even though it feels and looks like black leather - the smell of blood tells you otherwise."
	icon_state = "midsomber"
	body_parts_covered = HANDS
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)
	blocksound = PLATEHIT
	max_integrity = ARMOR_INT_SIDE_BLACKSTEEL
	armor = ARMOR_PLATE_BSTEEL
	resistance_flags = FIRE_PROOF
	ADD_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT)

/obj/item/clothing/gloves/roguetown/leather/midsomber/dropped(mob/living/carbon/human/user)
	. = ..()
	if(QDELETED(src))
		return
	qdel(src)

/obj/item/clothing/gloves/roguetown/blacksteel/modern/plategloves/bulwark
	name = "machined gloves"
	desc = "Scare them."
	icon_state = "ibulwark"
	item_state = "ibulwark"
	sleeved = 'icons/roguetown/clothing/onmob/gloves.dmi'
	icon = 'icons/roguetown/clothing/gloves.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/gloves.dmi'

/obj/item/clothing/gloves/roguetown/leather/flamer
	name = "ashed gloves"
	desc = "Charred gloves. Fire resistant."
	icon_state = "flamer"
	item_state = "flamer"
	armor = list("blunt" = 100, "slash" = 70, "stab" = 50, "piercing" = 50, "fire" = 90, "acid" = 0)
