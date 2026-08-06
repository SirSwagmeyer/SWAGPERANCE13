/datum/job/roguetown/hedgeborn
	title = "Hedgeborn"
	flag = HEDGEBORN
	department_flag = HUNTERS
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	allowed_races = RACES_CONSCRIPT
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)

	tutorial = "You are a Hedgeborn, a trusted Mercenary under the Huntmaster. \
				You're the second highest ranking member of the Hunting Party, and the right hand of the Huntmaster. \
				You wield plate armor and a mighty sword, but have little experienced in ranged weaponry. \
				You have the unfortunate role of putting yourself between the lines of inexperienced Huntsmen and the tides of Undead." 

	outfit = /datum/outfit/job/roguetown/hedgeborn
	display_order = JDO_HEDGEBORN
	give_bank_account = TRUE
	min_pq = 0
	max_pq = null

	cmode_music = 'sound/music/combat_grandknight.ogg'

/datum/outfit/job/roguetown/hedgeborn/pre_equip(mob/living/carbon/human/H)
	head = /obj/item/clothing/head/roguetown/helmet/heavy/barbute/visor/hedge
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/lord
	shoes = /obj/item/clothing/shoes/roguetown/boots
	armor = /obj/item/clothing/suit/roguetown/armor/plate/hauberk/alt
	pants = /obj/item/clothing/under/roguetown/chainlegs/iron
	neck = /obj/item/clothing/neck/roguetown/bevor/iron
	cloak = /obj/item/clothing/cloak/huntabard
	belt = /obj/item/storage/belt/rogue/leather/black/soldier
	beltl = /obj/item/flashlight/flare/torch/lantern
	wrists = /obj/item/scomstone/hunter
	gloves = /obj/item/clothing/gloves/roguetown/eastgloves1
	backr = /obj/item/storage/backpack/rogue/backpack
	backl = /obj/item/gwstrap
	r_hand = /obj/item/rogueweapon/greatsword/grenz
	backpack_contents = list(
		/obj/item/storage/belt/rogue/pouch/coins/mid,
	)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/armorsmithing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
	H.change_stat("strength", 2)
	H.change_stat("constitution", 3)
	H.change_stat("endurance", 3)
	H.change_stat("perception", 1)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
