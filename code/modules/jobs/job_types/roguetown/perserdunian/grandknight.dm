/datum/job/roguetown/grandknight
	title = "Grand Knight"
	flag = GRANDKNIGHT
	department_flag = PERSERDUN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_races = RACES_TEMPERANCE
	allowed_sexes = list(MALE)
	allowed_ages = list(AGE_ADULT)

	tutorial = "You're the right hand man of the Grandmaster. Essentially a drugged up, combative Lieutenant. \
				Your main goal is to draw the most attention onto yourself, while soaking up the most damage. \
				Typically, Grand Knights are hand selected by their Grandmaster. You might also be assigned to one. \
				Also, most Grand Knights lack fine-motor skills, due to the increased intake of stimulants. They aren't trained in guns." 

	outfit = /datum/outfit/job/roguetown/grandknight
	display_order = JDO_GRANDKNIGHT
	give_bank_account = TRUE
	min_pq = 0
	max_pq = null

	cmode_music = 'sound/music/combat_grandknight.ogg'

/datum/job/roguetown/grandknight/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(istype(H.wear_ring, /obj/item/roguekey/perserdun))
			var/obj/item/clothing/S = H.wear_ring
			var/index = findtext(H.real_name, " ")
			if(index)
				index = copytext(H.real_name, 1,index)
			if(!index)
				index = H.real_name
			S.name = " [index]'s dogtag"



/datum/outfit/job/roguetown/grandknight/pre_equip(mob/living/carbon/human/H)
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/lord
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor
	beltl = /obj/item/flashlight/flare/torch/lantern
	armor = /obj/item/clothing/suit/roguetown/armor/plate/full/iron
	cloak = /obj/item/clothing/cloak/perserduntabard
	pants = /obj/item/clothing/under/roguetown/platelegs/iron
	head = /obj/item/clothing/head/roguetown/helmet/heavy/bucket/iron
	mask = /obj/item/clothing/mask/rogue/gasmask/perserdunmask
	neck = /obj/item/clothing/neck/roguetown/chaincoif
	belt = /obj/item/storage/belt/rogue/leather/black
	beltl = /obj/item/flashlight/flare/torch/lantern
	beltr = /obj/item/gasgrenade
	backl = /obj/item/rogueweapon/stoneaxe/oath
	wrists = /obj/item/scomstone/garrison
	gloves = /obj/item/clothing/gloves/roguetown/plate/iron
	id = /obj/item/roguekey/perserdun
	backr = /obj/item/storage/backpack/rogue/backpack/perserdun
	backpack_contents = list(
		/obj/item/rogueweapon/huntingknife/idagger/steel,
		/obj/item/storage/belt/rogue/pouch/coins/rich,
		/obj/item/gasgrenade,
		/obj/item/grenade,
		/obj/item/reagent_containers/glass/bottle/rogue/healthpotnew,
	)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE) //test 2 see if it's broken
	H.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axes, 5, TRUE) // mf the fuggin' soldats are better than this guy hooooly at least give him 10% more chance to get past their axes
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/armorsmithing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
	H.change_stat("strength", 2)
	H.change_stat("constitution", 3)
	H.change_stat("endurance", 3)
	H.change_stat("perception", 2)
	H.change_stat("intelligence", 2)
	H.change_stat("speed", 2)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_LONGSTRIDER, TRAIT_GENERIC)

