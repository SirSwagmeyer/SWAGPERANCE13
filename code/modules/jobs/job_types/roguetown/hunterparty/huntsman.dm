/datum/job/roguetown/huntsman
	title = "Huntsman"
	flag = HUNTSMAN
	department_flag = HUNTER
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	allowed_races = RACES_CONSCRIPT
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT)
	advclass_cat_rolls = list(CTAG_HUNTSMAN = 20)


	tutorial = "You are a Huntsman of the Huntmaster's Party. \
				The Dictate and Empire send their unruly and unworthy soldiers to this coalition force. \
				Their main goal is to fight the undead hordes of the Wild Hunt in this area. \
				You unfortunately make up the rank and file of the Hunting Party." 

	outfit = /datum/outfit/job/roguetown/huntsman
	display_order = JDO_HUNTSMAN
	give_bank_account = TRUE
	min_pq = 0
	max_pq = null

/datum/outfit/job/roguetown/huntsman/pre_equip(mob/living/carbon/human/H)
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/lord
	shoes = /obj/item/clothing/shoes/roguetown/boots
	armor = /obj/item/clothing/suit/roguetown/armor/plate/half/iron
	pants = /obj/item/clothing/under/roguetown/trou/artipants
	cloak = /obj/item/clothing/cloak/huntabard
	belt = /obj/item/storage/belt/rogue/leather/black/soldier
	beltl = /obj/item/flashlight/flare/torch/lantern
	beltr = /obj/item/storage/belt/rogue/pouch/ammobag/rifle
	wrists = /obj/item/scomstone/hunter
	gloves = /obj/item/clothing/gloves/roguetown/eastgloves1
	backr = /obj/item/storage/backpack/rogue/backpack
	backpack_contents = list(
		/obj/item/storage/belt/rogue/pouch/coins/mid,
	)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/rifles, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/armorsmithing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/weaponsmithing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
	H.change_stat("strength", 1)
	H.change_stat("constitution", 1)
	H.change_stat("endurance", 1)
	H.change_stat("perception", 2)
	H.change_stat("speed", 1)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)


/datum/job/roguetown/huntsman/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	. = ..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")

/datum/advclass/huntsman/risvon
	name = "Risvon"
	tutorial = "You originate from the Dictate. You showed too much weakness, resulting in being forced into service with the Hunter's Party. Prove your strength and survive, or perish to the hoard."
	outfit = /datum/outfit/job/roguetown/huntsman/risvon
	category_tags = list(CTAG_HUNTSMAN)

/datum/outfit/job/roguetown/huntsman/risvon/pre_equip(mob/living/carbon/human/H)
	backl = /obj/item/gun/ballistic/rifle/repeater/springfield
	head = /obj/item/clothing/head/roguetown/helmet/kettle/iron/soldato
	mask = /obj/item/clothing/mask/rogue/gasmask/risvonmask
	H.cmode_music = 'sound/music/combat_soldato.ogg'

/datum/advclass/huntsman/perserdun
	name = "Perserdun"
	tutorial = "You originate from the Empire. You stepped out of line one too many times, resulting in being forced into service with the Hunter's Party. Prove your loyalty and survive, or perish to the hoard."
	outfit = /datum/outfit/job/roguetown/huntsman/perserdun
	category_tags = list(CTAG_HUNTSMAN)

/datum/outfit/job/roguetown/huntsman/perserdun/pre_equip(mob/living/carbon/human/H)
	backl = /obj/item/gun/ballistic/rifle/repeater/perserdun
	head = /obj/item/clothing/head/roguetown/helmet/sallet/visored/iron
	mask = /obj/item/clothing/mask/rogue/gasmask/perserdunmask
	H.cmode_music = 'sound/music/combat_armsman.ogg'



