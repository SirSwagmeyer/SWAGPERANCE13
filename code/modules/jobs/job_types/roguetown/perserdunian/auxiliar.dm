/datum/job/roguetown/auxiliarist
	title = "Auxiliarist"
	flag = AUXILIARIST
	department_flag = PERSERDUN
	faction = "Station"
	total_positions = 4
	spawn_positions = 4
	allowed_races = RACES_CONSCRIPT
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT)

	tutorial = "You are a supporter of Perserdun's war effort. \
				Whenever you are a leech or an ingeniare, you still carry a gun and know how to use it.\
				You've been granted a cloth to apply to your helmet in order to help identify what you are.\
				Red is for Ingenaires, Blue is for Leeches. It's mandatory for you to wear this." 

	outfit = /datum/outfit/job/roguetown/auxiliarist
	display_order = JDO_AUXILIARIST
	give_bank_account = TRUE
	min_pq = 0
	max_pq = null

	cmode_music = 'sound/music/combat_auxiliar.ogg'

/datum/job/roguetown/auxiliarist/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	. = ..()
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

/datum/outfit/job/roguetown/auxiliarist/pre_equip(mob/living/carbon/human/H)
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/lord
	shoes = /obj/item/clothing/shoes/roguetown/boots
	beltl = /obj/item/flashlight/flare/torch/lantern
	id = /obj/item/roguekey/perserdun
	armor = /obj/item/clothing/suit/roguetown/armor/brigandine/light
	cloak = /obj/item/clothing/cloak/perserduntabard
	pants = /obj/item/clothing/under/roguetown/trou/artipants
	mask = /obj/item/clothing/mask/rogue/gasmask/perserdunmask
	wrists = /obj/item/scomstone/garrison
	neck = /obj/item/clothing/neck/roguetown/chaincoif
	belt = /obj/item/storage/belt/rogue/leather/black
	beltr = /obj/item/storage/belt/rogue/pouch/stim
	head = /obj/item/clothing/head/roguetown/helmet/sallet/visored/iron
	gloves = /obj/item/clothing/gloves/roguetown/leather/latex
	backl = /obj/item/gun/ballistic/rifle/repeater/perserdun
	backr = /obj/item/storage/backpack/rogue/backpack/perserdun
	backpack_contents = list(
		/obj/item/reagent_containers/glass/bottle/rogue/healthpotnew = 3,
		/obj/item/ammo_box/handfuls/rifle = 6,
		/obj/item/storage/belt/rogue/pouch/coins/poor,
		/obj/item/gasgrenade = 2,
		/obj/item/natural/cloth,
	)
	H.adjust_skillrank(/datum/skill/misc/medicine, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/rifles, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/armorsmithing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
	H.change_stat("perception", 3)
	H.change_stat("intelligence", 3)
	H.change_stat("speed", 2)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)