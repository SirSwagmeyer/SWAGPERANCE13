/datum/job/roguetown/manorservant
	title = "Manor Servant"
	flag = MANORSERVANT
	department_flag = KINGSROW
	faction = "Station"
	total_positions = 3
	spawn_positions = 3
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_TEMPERANCE_NONCOMBATANT
	selection_color = JCOLOR_KINGSROW
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)

	tutorial = "You are a butler or maid of the King's Row estate. \
				Your duty is to cook and to keep the manor clean of dirt, grime and occasional unwelcome guests. \
				A toilsome life, even more so now that your master has been killed in the Hierarch's coup. You've been kept alive to continue your duties. \
				You follow the Housekeeper's commands. You fear the Bulwarks and may pity the displaced Heir."

	outfit = /datum/outfit/job/roguetown/servant
	display_order = JDO_SERVANT
	give_bank_account = TRUE
	min_pq = 0
	max_pq = null

	cmode_music = 'sound/music/combat_maids.ogg'

/datum/outfit/job/roguetown/servant/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	gloves = /obj/item/clothing/gloves/roguetown/eastgloves1
	l_hand = /obj/item/candle/candlestick/silver/single/lit
	beltr = /obj/item/storage/keyring/servant //keyring to be decided
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(
		/obj/item/rogueweapon/huntingknife/cleaver = 1,
		/obj/item/reagent_containers/glass/bottle/rogue/redwine = 2,
		/obj/item/natural/cloth = 1,
		)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/rifles, 2, TRUE)
	H.adjust_skillrank(/datum/skill/labor/farming, 3, TRUE)
	H.adjust_skillrank(/datum/skill/labor/butchering, 3, TRUE)
	H.change_stat("intelligence", 1)
	H.change_stat("endurance", 3)
	H.change_stat("perception", 1)
	H.change_stat("speed", 2)
	if(should_wear_masc_clothes(H))
		pants = /obj/item/clothing/under/roguetown/tights/manor
		belt = /obj/item/storage/belt/rogue/leather/black/butler
		shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/butler
	else if(should_wear_femme_clothes(H))
		head = /obj/item/clothing/head/roguetown/maid
		shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/maid
		cloak = /obj/item/clothing/cloak/apron/waist/maid
		belt = /obj/item/storage/belt/rogue/leather/sash/maid
		pants = /obj/item/clothing/under/roguetown/tights/stockings/silk
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)//wuthering heights butler
