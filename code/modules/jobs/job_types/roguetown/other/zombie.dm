/datum/job/roguetown/deadite
	title = "Deadite"
	flag =  ZOMBIE
	department_flag = UNAFFILIATED
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	allowed_races = RACES_ALL_KINDS
	allowed_sexes = list(MALE, FEMALE)

	tutorial = "You're a deadite. Consume or convert the living."

	outfit = /datum/outfit/job/roguetown/zombie

	display_order = JDO_ZOMBIE
	give_bank_account = FALSE
	min_pq = 0
	max_pq = null

	advclass_cat_rolls = list(CTAG_ZOMBIE = 20)

	job_reopens_slots_on_death = TRUE
	always_show_on_latechoices = TRUE
	announce_latejoin = FALSE
	show_in_credits = FALSE
	give_bank_account = FALSE

	cmode_music = 'sound/music/combat_zizlime.ogg'

/datum/outfit/job/roguetown/zombie/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/misc/climbing, 6, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
	H.adjust_skillrank(/datum/skill/labor/farming, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	belt = /obj/item/storage/belt/rogue/leather/rope
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
	pants = /obj/item/clothing/under/roguetown/trou
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	backl = /obj/item/storage/backpack/rogue/satchel
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	armor = /obj/item/clothing/suit/roguetown/armor/workervest
	beltr = /obj/item/flint
	if(H.pronouns == SHE_HER || H.pronouns == THEY_THEM_F)
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/random
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
		pants = null
	H.change_stat("strength", 4)
	H.change_stat("endurance", 4)
	H.change_stat("constitution", 4)

/datum/job/roguetown/deadite/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		var/mob/living/carbon/human/H = L
		H.mind.add_antag_datum(/datum/antagonist/zombie, team = FALSE, admin_panel = TRUE)
		addtimer(CALLBACK(H, GLOBAL_PROC_REF(wake_zombie), H, FALSE, TRUE), 5 SECONDS)