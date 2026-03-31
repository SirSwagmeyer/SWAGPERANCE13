/obj/item/ammo_box/magazine
	name = "magazine"
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


//hmg 

/obj/item/ammo_box/magazine/hmg
	name = "heavy machinegun magazine"
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	max_ammo = 50
	multiload = 1
	icon_state = "hmg-magazine"
	grid_width = 96
	grid_height = 96

/obj/item/ammo_box/magazine/hmg/a303
	name = ".303 box magazine"
	desc = "A box magazine for heavy machineguns."
	ammo_type = /obj/item/ammo_casing/a303
	caliber = "a303"
	max_ammo = 50
	multiload = 1
	icon_state = "303box"

/obj/item/ammo_box/magazine/hmg/a762x59
	name = "7.62x59mm box magazine"
	desc = "A box magazine for heavy machineguns."
	ammo_type = /obj/item/ammo_casing/a762x59
	caliber = "a762x59"
	max_ammo = 50
	multiload = 1
	icon_state = "762x59box"

/obj/item/ammo_box/magazine/hmg/a50d
	name = ".50D box magazine"
	desc = "A box magazine for heavy machineguns."
	ammo_type = /obj/item/ammo_casing/a50d
	caliber = "a50d"
	max_ammo = 40
	multiload = 1
	icon_state = "50dbox"
