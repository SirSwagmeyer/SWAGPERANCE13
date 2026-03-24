/datum/job/roguetown/hierarch
	title = "Hierarch"
	flag = HIERARCH
	department_flag = KINGSROW
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_races = RACES_TEMPERANCE
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT)
	selection_color = JCOLOR_KINGSROW

	tutorial = "You're the leading force of modernity in Kingsrow. \
				Originally some Council Member, or a Hand - you decided to take power from your Master with the new stash of arms given. \
				Your main goal is to remain an independent state, or at least have some form of sovereignty as you sell away your land. \
				You should also prioritize your people before the foreign factions. They generally appreciate the work you put in."

	outfit = /datum/outfit/job/roguetown/hierarch
	display_order = JDO_HIERARCH
	give_bank_account = TRUE
	min_pq = 0
	max_pq = null

	cmode_music = 'sound/music/combat_hierarch.ogg'

/datum/outfit/job/roguetown/hierarch/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/boots/nobleboot
	belt = /obj/item/storage/belt/rogue/leather/black
	beltl = /obj/item/flashlight/flare/torch/lantern
	beltr = /obj/item/storage/keyring/royal
	id = /obj/item/clothing/ring/gold
	backl = /obj/item/storage/backpack/rogue/satchel
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.change_stat("intelligence", 2)
	H.change_stat("constitution", 1)
	H.change_stat("endurance", 1)
	H.change_stat("perception", 2)
	H.change_stat("speed", 2)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)

	if(should_wear_masc_clothes(H))
		armor = /obj/item/clothing/suit/roguetown/armor/leather/heavy/hierarch
		pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
		shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy
		gloves = /obj/item/clothing/gloves/roguetown/eastgloves1
	else if(should_wear_femme_clothes(H))
		shirt = /obj/item/clothing/suit/roguetown/shirt/hierarchess
