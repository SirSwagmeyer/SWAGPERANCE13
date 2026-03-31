/obj/item/gun/ballistic/rifle/repeater/patience
	name = "AMR 'Patience'"
	desc = "The Empire loves weapons like these. Shreds through people, and kicks like a bitch."
	icon_state = "heavysniper"
	item_state = "heavysniper"
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/patience
	slowdown = 0.5
	spread = 0.2
	pump_sound = 'sound/combat/ranged/patiencecock.ogg'
	fire_sound = list('sound/combat/ranged/sniper_fire.ogg')
	load_sound = 'sound/combat/ranged/patienceload.ogg'
	recoil = 4

/obj/item/gun/ballistic/shotgun/eternal
	name = "PAX 'Eternal'"
	desc = "Paint some /real/ ugly holes into your enemies. Comes with a reinforced buttstock, for smashing."
	icon_state = "trenchgun"
	item_state = "trenchgun"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/eternal
	slowdown = 0.15
	spread = 0.5
	fire_sound = SHOTGUNSHOT
	pump_sound = 'sound/combat/ranged/shotgunpump.ogg'
	recoil = 0.15
	load_sound = SHOTGUNINSERT
	rack_delay = 2
	force = 75
	possible_item_intents = list(
		/datum/intent/shoot/shotgun,
		/datum/intent/arc/shotgun,
		/datum/intent/mace/smash,
		INTENT_GENERIC,
		)

/obj/item/gun/ballistic/rifle/reaper
	name = "GRD 'Reaper'"
	desc = "One of the few semi-automatic guns around. Shoots rifle rounds, and loads using a clip. Mind the scratchy bolt, it might not close by itself sometimes, give it a nice tug and send it home. The trigger might get stuck from time to time too, so try pulling it faster to force it to shoot. The name has a touch of irony to it, sure it kills, hell it ruins people.... but with how fast you dump the clip, you might as well be visiting the reaper yourself."
	icon_state = "rsc"
	item_state = "rsc"
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/reaper
	slowdown = 0.2
	bolt_type = BOLT_TYPE_LOCKING
	experimental_inhand = FALSE
	empty_indicator = TRUE
	fire_sound = RIFLESHOT
	pump_sound = 'sound/combat/ranged/smg_cock.ogg'
	load_sound = 'sound/combat/ranged/smg_magin.ogg'
	recoil = 0.15
	semi_auto = TRUE
