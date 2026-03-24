/datum/job/roguetown/barkeep
	title = "Innkeeper"
	flag = BARKEEP
	department_flag = KINGSROW
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_races = RACES_ALL_KINDS

	tutorial = "Adventurers, soldiers - even the regular townsfolk. You're both the bartender and the cook. So, let's make some money."

	outfit = /datum/outfit/job/roguetown/barkeep
	give_bank_account = 43
	min_pq = -4
	max_pq = null
	round_contrib_points = 3
	cmode_music = 'sound/music/cmode/towner/combat_retired.ogg'

/datum/outfit/job/roguetown/barkeep/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.adjust_skillrank(/datum/skill/labor/butchering, 3, TRUE)
	H.adjust_skillrank(/datum/skill/labor/farming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/carpentry, 2, TRUE) //apprentice to do some basic repairs around the inn if need be
	H.adjust_skillrank(/datum/skill/misc/music, 2, TRUE)
	if(H.age == AGE_MIDDLEAGED)
		H.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/music, 1, TRUE)
	if(H.age == AGE_OLD)
		H.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/music, 1, TRUE)
	pants = /obj/item/clothing/under/roguetown/tights/black
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	backr = /obj/item/storage/backpack/rogue/satchel
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/storage/belt/rogue/pouch/coins/mid
	beltr = /obj/item/storage/keyring/innkeep
	if(should_wear_femme_clothes(H))
		armor = /obj/item/clothing/suit/roguetown/shirt/dress
		cloak = /obj/item/clothing/cloak/apron/waist
	else if(should_wear_masc_clothes(H))
		shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
		armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/sailor
	backpack_contents = list(
		/obj/item/recipe_book/survival,
		/obj/item/bottle_kit
	)
	H.change_stat("strength", 1)
	H.change_stat("endurance", 1)
	H.change_stat("constitution", 1)
	H.change_stat("intelligence", 1)
	H.change_stat("speed", 1)
	ADD_TRAIT(H, TRAIT_EMPATH, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_CICERONE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_TAVERN_FIGHTER, TRAIT_GENERIC)
