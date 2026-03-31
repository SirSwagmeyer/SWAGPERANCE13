/obj/projectile/bullet/a762
	name = "7.62mmR lead bullet"
	icon_state = "bullet_proj"
	damage = 70

/obj/projectile/bullet/a577
	name = ".577 bullet"
	icon_state = "bullet_proj"
	damage = 160

/obj/projectile/bullet/a50
	name = ".50 caliber bullet"
	icon_state = "bullet_proj"
	damage = 140 
	armor_penetration = 100 //might be super broken, watch during playtests

/obj/projectile/bullet/a9mm
	name = "9mm bullet"
	icon_state = "bullet_proj"
	damage = 40

/obj/projectile/bullet/a44
	name = ".44 bullet"
	icon_state = "bullet_proj"
	damage = 60
	armor_penetration = 40 // added armor pen due to the fact it's a higher-load and higher-caliber than 9mm

/obj/projectile/bullet/a22lr
	name = ".22LR bullet"
	icon_state = "bullet_proj"
	damage = 30

/obj/projectile/bullet/a45acp
	name = ".45 ACP bullet"
	icon_state = "bullet_proj"
	damage = 48

/obj/projectile/bullet/a380
    name = ".380 ACP bullet"
    icon_state = "bullet_proj"
    damage = 50
    armor_penetration = 30

// shotgun

/obj/projectile/bullet/shotgun_slug
	name = "12g shotgun slug"
	damage = 70
	spread = 2
	armor_penetration = 65

/obj/projectile/bullet/pellet/shotgun_buckshot
	name = "buckshot pellet"
	damage = 13.5
	armor_penetration = 50

// shotgun falloff
/obj/projectile/bullet/pellet
	var/tile_dropoff = 0.45
	var/tile_dropoff_s = 1.25

/obj/projectile/bullet/pellet/Range()
	..()
	if(damage > 0)
		damage -= tile_dropoff
	if(damage < 0)
		qdel(src)
