/obj/item/ammo_box/magazine
	name = "pistol clip"
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	icon = 'icons/roguetown/weapons/gunammo.dmi'
	desc = "template thing"
	icon_state = "pistol_clip"
	ammo_type = /obj/item/ammo_casing/a9mm
	caliber = "a9mm"
	max_ammo = 7

/obj/item/ammo_box/magazine/jackal
	name = "jackal magazine"
	desc = "An extractable magazine. It has a spring on the bottom, and can be seen through."
	multiple_sprites = AMMO_BOX_PER_BULLET
	ammo_type = /obj/item/ammo_casing/a22lr
	caliber = "a22lr"
	max_ammo = 7
	multiload = 1
	icon_state = "handgunmag"

/obj/item/ammo_box/magazine/fury
	name = "fury magazine"
	desc = "An extractable magazine. It has a few holes punched in it, you can see the rounds through it."
	multiple_sprites = AMMO_BOX_PER_BULLET
	ammo_type = /obj/item/ammo_casing/a45acp
	caliber = "a45acp"
	max_ammo = 7
	multiload = 1
	icon_state = "colt-mag"

/obj/item/ammo_box/magazine/luger
    name = "KRL magazine"
    desc = "An extractable magazine. It looks like a standard pistol magazine, except a bit bigger."
    multiple_sprites = AMMO_BOX_PER_BULLET
    ammo_type = /obj/item/ammo_casing/a9mm
    caliber = "a9mm"
    max_ammo = 8
    multiload = 1
    icon_state = "luger-mag"
