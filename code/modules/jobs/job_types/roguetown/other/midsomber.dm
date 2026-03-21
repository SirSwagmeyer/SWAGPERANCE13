//admin spawn only. used for events/team balancing ig

/datum/job/roguetown/midsomber
	title = "Midsomber Night's Childe"
	flag = DEATHKNIGHT
	department_flag = SLOP
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	min_pq = null //no pq
	max_pq = null

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	tutorial = ""

	spells = list(/obj/effect/proc_holder/spell/invoked/projectile/bloodsteal, /obj/effect/proc_holder/spell/invoked/projectile/fetch, /obj/effect/proc_holder/spell/invoked/projectile/bloodlightning, /obj/effect/proc_holder/spell/self/recall_weapon, /obj/effect/proc_holder/spell/self/bind_weapon)
	outfit = /datum/outfit/job/roguetown/midsomber

	show_in_credits = FALSE
	give_bank_account = FALSE

	cmode_music = 'sound/music/combat_midsomber.ogg'

/datum/outfit/job/roguetown/midsomber/pre_equip(mob/living/carbon/human/H)
	belt = /obj/item/storage/belt/rogue/leather
	pants = /obj/item/clothing/under/roguetown/platelegs/blk/death
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/midsomber
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/midsomber
	gloves = /obj/item/clothing/gloves/roguetown/leather/midsomber
	backr = /obj/item/storage/backpack/rogue/satchel
	backl = /obj/item/rogueweapon/sword/sabre/midsomber

	H.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 5, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 5, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/magic/arcane, 3, TRUE)
	H.mind?.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/bloodsteal)
	H.mind?.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/fetch)
	H.mind?.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/bloodlightning)
	H.mind?.AddSpell(new /obj/effect/proc_holder/spell/self/recall_weapon)
	H.mind?.AddSpell(new /obj/effect/proc_holder/spell/self/bind_weapon)
	H.mind?.AddSpell (new /obj/effect/proc_holder/spell/invoked/funeral)

	ADD_TRAIT(H, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_INFINITE_STAMINA, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOLIMBDISABLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOBREATH, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOPAIN, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_TOXIMMUNE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOSLEEP, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_SHOCKIMMUNE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_ARCYNE_T2, TRAIT_GENERIC)

	to_chat(H, span_warning("You start with Bind Weapon. Remember to Bind your weapon so you can use your abilities and build up Arcyne Momentum."))

	var/subclass_selected = "blade"
	var/datum/status_effect/buff/arcyne_momentum/momentum = H.apply_status_effect(/datum/status_effect/buff/arcyne_momentum)
	if(momentum)
		momentum.chant = subclass_selected

	H.change_stat("intelligence", 3)
	H.change_stat("strength", 2)
	H.change_stat("endurance", 2)
	H.change_stat("constitution", 2)
	H.change_stat("speed", 3)
	ADD_TRAIT(H, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_INFINITE_STAMINA, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOLIMBDISABLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOBREATH, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOPAIN, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_TOXIMMUNE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOSLEEP, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_SHOCKIMMUNE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_ARCYNE_T2, TRAIT_GENERIC)
	H.ambushable = FALSE

	var/datum/antagonist/new_antag = new /datum/antagonist/vampire()
	H.mind.add_antag_datum(new_antag)
