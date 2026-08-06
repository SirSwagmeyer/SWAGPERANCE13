/datum/job/roguetown/huntmaster
	title = "Huntmaster"
	flag = HUNTMASTER
	department_flag = HUNTERS
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	allowed_races = RACES_CONSCRIPT
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)

	tutorial = "You are the Huntmaster, a Mercenary leading a party of other sellswords and conscripts. \
				You're here to combat a Wild Hunt, an uprising of undead caused by a magician's woes and failure. \
				Your allegiance lies neither with the Dictate or Empire, but your interests allign and your pockets are full. You serve them for now. \
				Your men are from both factions, they're less experienced and prone to bickering. Most are forced to be here." 

	outfit = /datum/outfit/job/roguetown/huntmaster
	display_order = JDO_HUNTMASTER
	selection_color = JCOLOR_HUNTER
	give_bank_account = TRUE
	min_pq = 0
	max_pq = null

	cmode_music = 'sound/music/combat_huntmaster.ogg'

/datum/outfit/job/roguetown/huntmaster/pre_equip(mob/living/carbon/human/H)
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/lord
	shoes = /obj/item/clothing/shoes/roguetown/boots
	armor = /obj/item/clothing/suit/roguetown/armor/plate/scale/huntmaster
	pants = /obj/item/clothing/under/roguetown/trou/artipants
	neck = /obj/item/clothing/neck/roguetown/bevor/iron
	belt = /obj/item/storage/belt/rogue/leather/black/soldier
	beltl = /obj/item/flashlight/flare/torch/lantern
	beltr = /obj/item/rogueweapon/sword/sabre
	wrists = /obj/item/scomstone/hunter
	gloves = /obj/item/clothing/gloves/roguetown/eastgloves1
	backr = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(
		/obj/item/storage/belt/rogue/pouch/coins/rich,
	)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/pistols, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/armorsmithing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
	if(H.mind)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/holdingweak)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/aimweak)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/chargeweak)
	H.change_stat("intelligence", 3)
	H.change_stat("constitution", 1)
	H.change_stat("endurance", 1)
	H.change_stat("perception", 3)
	H.change_stat("speed", 1)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
