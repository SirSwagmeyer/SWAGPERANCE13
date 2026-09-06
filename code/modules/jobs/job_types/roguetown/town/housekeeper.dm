/datum/job/roguetown/housekeeper
	title = "Head Housekeeper"
	flag = HOUSEKEEPER
	department_flag = KINGSROW
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_TEMPERANCE_NONCOMBATANT
	selection_color = JCOLOR_KINGSROW
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)

	tutorial = "You are the Head Housekeeper, the most trusted servant of the King's Row Estate. \
				Prior to the coup, you were the protector of the manor, along with the other maids and butlers. \
				That isn't to say that you aren't also an excellent cook. But with your former master slain, you now serve the Hierarch. \
				You're about the same age as the Hierarch and Displaced, having grown up together."

	outfit = /datum/outfit/job/roguetown/housekeeper
	display_order = JDO_HOUSEKEEPER
	give_bank_account = TRUE
	min_pq = 0
	max_pq = null

	cmode_music = 'sound/music/combat_housekeeper.ogg'

/datum/outfit/job/roguetown/housekeeper/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced/short
	gloves = /obj/item/clothing/gloves/roguetown/eastgloves1
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy
	belt = /obj/item/storage/belt/rogue/leather/knifebelt/black/steel
	beltl = /obj/item/flashlight/flare/torch/lantern
	beltr = /obj/item/storage/keyring/gatemaster //for armory access
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(
		/obj/item/rogueweapon/huntingknife/idagger/dtace = 1,
		/obj/item/reagent_containers/glass/bottle/rogue/redwine = 1,
		/obj/item/reagent_containers/glass/bottle/rogue/elfblue = 1,
		/obj/item/reagent_containers/glass/bottle/rogue/healthpotnew = 1,
		/obj/item/natural/cloth = 1,
		)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 5, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 5, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 5, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 5, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 5, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 5, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/rifles, 3, TRUE)
	H.adjust_skillrank(/datum/skill/labor/farming, 4, TRUE)
	H.adjust_skillrank(/datum/skill/labor/butchering, 4, TRUE)
	H.change_stat("intelligence", 2)
	H.change_stat("endurance", 4)
	H.change_stat("perception", 2)
	H.change_stat("speed", 3)
	if(should_wear_masc_clothes(H))
		pants = /obj/item/clothing/under/roguetown/tights/manor
		shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/freifechter/housekeeper
		armor = /obj/item/clothing/suit/roguetown/armor/leather/heavy/coat/butler
	else if(should_wear_femme_clothes(H))
		head = /obj/item/clothing/head/roguetown/maid
		shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy
		armor = /obj/item/clothing/suit/roguetown/armor/leather/heavy/coat/nelly
		cloak = /obj/item/clothing/cloak/apron/waist/fancymaid
		pants = /obj/item/clothing/under/roguetown/tights/stockings/silk
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
//nellymaxxing
