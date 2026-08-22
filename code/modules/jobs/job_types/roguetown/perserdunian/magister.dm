/datum/job/roguetown/magister
	title = "Magister Enginseer"
	flag = MAGISTER
	department_flag = PERSERDUN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_races = RACES_TEMPERANCE_BATTLEMEDICS
	allowed_sexes = list(MALE, FEMALE)
	tutorial = "You are an Enginseer, a member of a cult devoted to the MACHINE. The Enginseers are neutral by nature, but the order has split over the war. As a Magister Enginseer, you have sided with the Empire, believing the Dictate's use of the MACHINE is dangerous and its goals reckless. Your greatest service is retrieving and reviving fallen soldiers from afar through one of your sanctioned inventions. It is an ugly irony that your work only feeds the war you despise, but you cannot allow the Dictate to win."
	outfit = /datum/outfit/job/roguetown/magister
	display_order = JDO_MAGISTER
	give_bank_account = TRUE
	min_pq = 0
	max_pq = null
	cmode_music = 'sound/music/combat_servisto.ogg'


/datum/job/roguetown/magister/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(istype(H.wear_ring, /obj/item/roguekey/perserdun))
			var/obj/item/clothing/S = H.wear_ring
			var/index = findtext(H.real_name, " ")
			if(index)
				index = copytext(H.real_name, 1, index)
			if(!index)
				index = H.real_name
			S.name = " [index]'s dogtag"


/datum/outfit/job/roguetown/magister/pre_equip(mob/living/carbon/human/H)
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/lord
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced
	armor = /obj/item/clothing/suit/roguetown/armor/plate/scale/inqcoat/enginseer
	cloak = /obj/item/clothing/cloak/perserduntabard
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
	belt = /obj/item/storage/belt/rogue/leather/black/soldier
	beltl = /obj/item/flashlight/flare/torch/lantern
	beltr = /obj/item/storage/belt/rogue/pouch/stim
	mask = /obj/item/clothing/mask/rogue/gasmask/perserdunmask
	head = /obj/item/clothing/head/roguetown/roguehood/shalal/heavyhood/cmo
	wrists = /obj/item/scomstone/garrison
	neck = /obj/item/storage/belt/rogue/pouch/coins/mid
	gloves = /obj/item/clothing/gloves/roguetown/eastgloves1
	id = /obj/item/roguekey/perserdun
	backr = /obj/item/storage/backpack/rogue/backpack/risvon

	backpack_contents = list(
		/obj/item/storage/belt/rogue/pouch/coins/rich,
		/obj/item/rogueweapon/stoneaxe/woodcut/risvon,
	)

	H.adjust_skillrank(/datum/skill/misc/medicine, 5, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 6, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 6, TRUE)
	H.adjust_skillrank(/datum/skill/magic/arcane, 6, TRUE)

	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/pistols, 2, TRUE)

	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)

	H.change_stat("intelligence", 6)
	H.change_stat("constitution", -4)
	H.change_stat("endurance", -2)
	H.change_stat("speed", 2)

	if(H.mind)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/diagnose/secular)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/regression)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/convergence)
//		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/conjure_BEHOLDER)

	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_LONGSTRIDER, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_ARCYNE_T4, TRAIT_GENERIC)
