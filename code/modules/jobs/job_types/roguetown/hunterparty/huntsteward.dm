/datum/job/roguetown/huntsteward
	title = "Huntsteward" // While I'd love to just call them Stewards its probably best to avoid confusion with the basic ass steward role in roguecode
	flag = HUNTSTEWARD
	department_flag = HUNTER
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	allowed_races = RACES_CONSCRIPT
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)

	tutorial = "You are a Huntsteward, a Mercenary in the Huntmaster's Party. \
				Your purpose is twofold. you are to command and train the inexperienced Huntsmen and manage the resources of the Hunting Party.\
				You're above the Huntsmen and Mountebanks, but you serve underneath the Huntmaster and Hedgeborn as an officer." 

	outfit = /datum/outfit/job/roguetown/huntsteward
	display_order = JDO_HUNTSTEWARD
	give_bank_account = TRUE
	min_pq = 0
	max_pq = null

	cmode_music = 'sound/music/combat_voltigeur.ogg'

/datum/outfit/job/roguetown/huntsteward/pre_equip(mob/living/carbon/human/H)
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/lord
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced
	armor = /obj/item/clothing/suit/roguetown/armor/plate/half
	cloak = /obj/item/clothing/cloak/huntabard
	pants = /obj/item/clothing/under/roguetown/trou/artipants
	head = /obj/item/clothing/head/roguetown/roguehood/phys
	neck = /obj/item/clothing/neck/roguetown/chaincoif/chainmantle
	mask = /obj/item/clothing/mask/rogue/spectacles //Honestly I thought this would look dogshit at first but the fit goes hard
	belt = /obj/item/storage/belt/rogue/leather/black/soldier
	beltl = /obj/item/flashlight/flare/torch/lantern
	beltr = /obj/item/storage/belt/rogue/pouch/ammobag/shotgun
	backl = /obj/item/gun/ballistic/shotgun/levershotgun
	wrists = /obj/item/scomstone/hunter
	gloves = /obj/item/clothing/gloves/roguetown/eastgloves1
	backr = /obj/item/storage/backpack/rogue/backpack
	backpack_contents = list(
		/obj/item/storage/belt/rogue/pouch/coins/mid,
		/obj/item/rogueweapon/sword/short,
	)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/tracking, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/rifles, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/shotguns, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/armorsmithing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
	H.change_stat("strength", 1)
	H.change_stat("constitution", 1)
	H.change_stat("intelligence", 2)
	H.change_stat("endurance", 1)
	H.change_stat("perception", 3)
	H.change_stat("speed", 2)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_SEEPRICES_SHITTY, TRAIT_GENERIC) // They call me the Knower
