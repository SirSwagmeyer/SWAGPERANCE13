/obj/item/gun/ballistic/pistol
	name = "\improper dogshit pistol"
	desc = "" //usually used by syndicates
	icon_state = "pistol"
	fire_sound = 'sound/blank.ogg'
	load_sound = 'sound/blank.ogg'
	eject_sound = 'sound/blank.ogg'
	fire_sound_volume = 90
	dry_fire_sound = 'sound/blank.ogg'
	casing_ejector = FALSE
	internal_magazine = TRUE
	bolt_type = BOLT_TYPE_NO_BOLT
	tac_reloads = FALSE
	var/spin_delay = 10
	var/recent_spin = 0
	bolt_wording = "primer"
	dry_fire_sound = 'sound/blank.ogg'
	slot_flags = ITEM_SLOT_HIP
	icon = 'icons/roguetown/weapons/32guns.dmi'
	possible_item_intents = list(
		/datum/intent/shoot/pistol,
		/datum/intent/arc/pistol,
		INTENT_GENERIC,
		)
/datum/intent/shoot/pistol
	chargedrain = 0
	no_early_release = TRUE

/datum/intent/shoot/pistol/get_chargetime()
	if(!mastermob || !chargetime)
		var/newtime = 0
		newtime = ((newtime + 10) - (mastermob.get_skill_level(/datum/skill/combat/pistols) * (4)))
		if(strength_check == TRUE)
			newtime = ((newtime + 10) - (mastermob.STASTR / 2))
		else
			newtime = newtime 
		newtime = ((newtime + 20) - (mastermob.STAPER))

/datum/intent/arc/pistol
	chargetime = 1
	chargedrain = 0
	no_early_release = TRUE

/datum/intent/arc/pistol/can_charge()
	if(mastermob)
		if(mastermob.get_num_arms(FALSE) < 2)
			return FALSE
		if(mastermob.get_inactive_held_item())
			return FALSE
	return TRUE

/datum/intent/arc/pistol/get_chargetime()
	if(mastermob && chargetime)
		var/newtime = 0
		newtime = ((newtime + 10) - (mastermob.get_skill_level(/datum/skill/combat/pistols) * (4)))
		if(strength_check == TRUE)
			newtime = ((newtime + 10) - (mastermob.STASTR / 2))
		else
			newtime = newtime 
		newtime = ((newtime + 20) - (mastermob.STAPER))
		if(newtime > 3)
			return newtime
		else
			return 3
	else
		return chargetime

/////////////  pistols


/obj/item/gun/ballistic/rifle/repeater/pistol 
	name = "SiR 'Harland'"
	desc = "A clip-loaded pistol. Mass produced, and issued to Risvon Soldats. Requires manual cocking."
	icon_state = "pocketpistol"
	item_state = "pocketpistol"
	w_class = WEIGHT_CLASS_SMALL
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/pistol
	slowdown = 0.15
	spread = 0.5
	pump_sound = 'sound/combat/ranged/hpistol_cock.ogg'
	fire_sound = PISTOLSHOT
	load_sound = 'sound/combat/ranged/clipload.ogg'
	recoil = 0.15
	slot_flags = ITEM_SLOT_HIP

/obj/item/gun/ballistic/rifle/repeater/jackal 
	name = "SPR 'Jackal'"
	desc = "One of the few semi-automatic designs that's ever been produced. Comes with its own magazine, and fires a weak cartridge."
	icon_state = "handgun"
	item_state = "handgun"
	w_class = WEIGHT_CLASS_SMALL
	mag_type = /obj/item/ammo_box/magazine/jackal
	slowdown = 0.15
	spread = 0.5
	pump_sound = 'sound/combat/ranged/pistol_cock.ogg'
	fire_sound = PISTOLSHOT
	load_sound = 'sound/combat/ranged/pistol_magin.ogg'
	eject_sound = 'sound/combat/ranged/pistol_magout.ogg'
	recoil = 0.15
	semi_auto = TRUE
	slot_flags = ITEM_SLOT_HIP

/obj/item/gun/ballistic/rifle/repeater/commandant
	name = "ANL 'Liberation'"
	desc = "Clip-loaded, semi-automatic pistol. Honor the Ziggurate."
	icon_state = "machinepistol"
	item_state = "machinepistol"
	w_class = WEIGHT_CLASS_SMALL
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/machinepistol
	slowdown = 0.15
	spread = 0.5
	pump_sound = 'sound/combat/ranged/hpistol_cock.ogg'
	fire_sound = PISTOLSHOT
	load_sound = 'sound/combat/ranged/clipload.ogg'
	recoil = 0.15
	semi_auto = TRUE
	slot_flags = ITEM_SLOT_BACK

/obj/item/gun/ballistic/pistol/fury
	name = "Fury"
	desc = "One of the rarer variants of the semi auto pistols found in the wild, this one's got a seven-round magazine, firing some decent rounds out of it too. Looks intimidating. Maybe even hateful."
	icon_state = "colt"
	item_state = "colt"
	w_class = WEIGHT_CLASS_SMALL
	mag_type = /obj/item/ammo_box/magazine/fury
	slowdown = 0.15
	spread = 0.5
	force = 25 //heavy pistol, should be good for whipping someone in the head with
	fire_sound = PISTOLSHOT
	load_sound = 'sound/combat/ranged/pistol_magin.ogg'
	eject_sound = 'sound/combat/ranged/pistol_magout.ogg'
	recoil = 0.15
	semi_auto = TRUE

/obj/item/gun/ballistic/pistol/broomhandle
	name = "KR 'Trenchsweeper'"
	desc = "Heavy and uncomfortable almost requiring two hands to pull this thing up, how the fuck is this a pistol? 10 round capacity fed by 5 round stripper clips loaded with rifle rounds. This thing is just as it's name implies, a trench sweeper. Semi automatic, Smooth trigger despite the weight on this thing. There's a crown stamped on the grip, along with a KR just above it. You'd imagine only someone with a high standing would own this."
	icon_state = "broomhandle"
	item_state = "broomhandle"
	w_class = WEIGHT_CLASS_SMALL
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/broomhandle
	slowdown = 0.25 //BIG pistol
	spread = 0.5
	force = 25 //heavy pistol, should be good for whipping someone in the head with
	fire_sound = PISTOLSHOT
	load_sound = 'sound/combat/ranged/pistol_magin.ogg'
	eject_sound = 'sound/combat/ranged/pistol_magout.ogg'
	recoil = 0.2 //make it FEEL uncomfortable
	semi_auto = TRUE
	slot_flags = ITEM_SLOT_BACK

/obj/item/gun/ballistic/pistol/luger
    name = "KR 'Confessor'"
    desc = "A recently produced kings row pistol, featuring a distinctive slide that jump up each time it fires. With a 8 round magazine, and a decent cartridge, it's a solid choice for a sidearm."
    icon_state = "luger"
    item_state = "luger"
    w_class = WEIGHT_CLASS_SMALL
    mag_type = /obj/item/ammo_box/magazine/luger
    slowdown = 0.15
    spread = 0.5
    force = 15 
    fire_sound = PISTOLSHOT
    load_sound = 'sound/combat/ranged/pistol_magin.ogg'
    eject_sound = 'sound/combat/ranged/pistol_magout.ogg'
    recoil = 0.15
    semi_auto = TRUE

/obj/item/gun/ballistic/pistol/offiseroluger
    name = "KR 'Galinha'"
    desc = "In the war between the Ziggurate and the Perserdun Empire, Kings row supplies both sides, as long as both agree to leave them out of the mess, this pistol is an old relic of those supplies. Given to them many years ago, the heartfelt words spoken before handing over those pieces of overpolished black metal have been long forgotten."
    icon_state = "officerluger"
    item_state = "officerluger"
    w_class = WEIGHT_CLASS_SMALL
    mag_type = /obj/item/ammo_box/magazine/luger
    slowdown = 0.15
    spread = 0.5
    force = 15 
    fire_sound = PISTOLSHOT
    load_sound = 'sound/combat/ranged/pistol_magin.ogg'
    eject_sound = 'sound/combat/ranged/pistol_magout.ogg'
    recoil = 0.15
    semi_auto = TRUE

/obj/item/gun/ballistic/pistol/artyluger
    name = "KR 'Preacher'"
    desc = "A heavily modified version of the standard luger, designed for more careful shots and improved accuracy, featuring a stock that helps with the recoil, while also serving as a good club."
    icon_state = "artyluger"
    item_state = "artyluger"
    w_class = WEIGHT_CLASS_SMALL
    mag_type = /obj/item/ammo_box/magazine/luger
    slowdown = 0.2
    spread = 0.5
    force = 30 //it has a fat fucking stock lemme smack a motherfucker with it
    fire_sound = PISTOLSHOT
    load_sound = 'sound/combat/ranged/pistol_magin.ogg'
    eject_sound = 'sound/combat/ranged/pistol_magout.ogg'
    recoil = 0.05 //stocked pistol
    semi_auto = TRUE
