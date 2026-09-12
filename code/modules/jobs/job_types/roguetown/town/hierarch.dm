/datum/job/roguetown/hierarch
	title = "Hierarch"
	flag = HIERARCH
	department_flag = KINGSROW
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_races = RACES_TEMPERANCE
	allowed_sexes = list(MALE, FEMALE)
	selection_color = JCOLOR_KINGSROW
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)

	tutorial = "You are the current Lord/Lady of Estate for the manor known as King's Row. \
				Once an adopted, low-born mutt of the former owner - you've clawed their way into control as means of revenge. \
				Your main goal is to maintain your authority. You have kept the Displaced Heir alive in order to satiate your desire for vengeance. \
				Most of the servants within the manor despises you for your low birth and degradation of the manor's noble status."

	outfit = /datum/outfit/job/roguetown/hierarch
	display_order = JDO_HIERARCH
	give_bank_account = TRUE
	min_pq = 0
	max_pq = null

	cmode_music = 'sound/music/combat_hierarch.ogg'

/datum/outfit/job/roguetown/hierarch/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/boots/nobleboot
	belt = /obj/item/storage/belt/rogue/leather/black/soldier
	beltl = /obj/item/flashlight/flare/torch/lantern
	beltr = /obj/item/storage/keyring/royal
	id = /obj/item/clothing/ring/gold
	backl = /obj/item/storage/backpack/rogue/satchel
	backr = /obj/item/gun/ballistic/rifle/repeater/broomhandle
	wrists = /obj/item/scomstone/kingsrow
	backpack_contents = list(
		/obj/item/flashlight/flare/torch/lantern = 1,
		/obj/item/rogueweapon/huntingknife/idagger/steel = 1,
		/obj/item/storage/belt/rogue/pouch/stim = 1,
		/obj/item/ammo_box/clip/broomhandle = 6,		
		)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/pistols, 4, TRUE)
	H.change_stat("intelligence", 2)
	H.change_stat("constitution", 1)
	H.change_stat("endurance", 1)
	H.change_stat("perception", 2)
	H.change_stat("speed", 2)
	if(H.mind)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/abuse)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)

	if(should_wear_masc_clothes(H))
		armor = /obj/item/clothing/suit/roguetown/armor/leather/heavy/hierarch
		pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
		shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy
		gloves = /obj/item/clothing/gloves/roguetown/eastgloves1
	else if(should_wear_femme_clothes(H))
		shirt = /obj/item/clothing/suit/roguetown/shirt/hierarchess
		pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
		gloves = /obj/item/clothing/gloves/roguetown/eastgloves1
