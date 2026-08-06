/datum/job/roguetown/mountebank
	title = "Mountebank"
	flag = MOUNTEBANK
	department_flag = HUNTERS
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	allowed_races = RACES_TEMPERANCE_BATTLEMEDICS
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)

	tutorial = "You are a Mountebank, a Mercenary serving in the Huntmaster's Party. \
				You specialize in tending wounds, be they bullet or beast.\
				You can use a rifle like any other, but you should depend on the Huntsmen to keep you defended.\
				Your primary purpose will be burning the rot from the infected, deadites run rampant in these lands." 

	outfit = /datum/outfit/job/roguetown/mountebank
	display_order = JDO_MOUNTEBANK
	give_bank_account = TRUE
	min_pq = 0
	max_pq = null

	cmode_music = 'sound/music/combat_auxiliar.ogg'

/datum/outfit/job/roguetown/mountebank/pre_equip(mob/living/carbon/human/H)
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/lord
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced
	beltl = /obj/item/flashlight/flare/torch/lantern
	armor = /obj/item/clothing/suit/roguetown/armor/brigandine/light
	cloak = /obj/item/clothing/cloak/huntabard
	pants = /obj/item/clothing/under/roguetown/trou/artipants
	mask = /obj/item/clothing/mask/rogue/gasmask/mountebank
	wrists = /obj/item/scomstone/hunter
	belt = /obj/item/storage/belt/rogue/leather/black/soldier
	beltr = /obj/item/storage/belt/rogue/surgery_bag/full
	neck = /obj/item/clothing/neck/roguetown/chaincoif/full
	gloves = /obj/item/clothing/gloves/roguetown/leather/latex
	backl = /obj/item/gun/ballistic/rifle/repeater/lebel
	backr = /obj/item/storage/backpack/rogue/backpack
	backpack_contents = list(
		/obj/item/reagent_containers/glass/bottle/rogue/healthpotnew = 3,
		/obj/item/storage/belt/rogue/pouch/ammobag/rifle,
		/obj/item/storage/belt/rogue/pouch/coins/mid,
		/obj/item/natural/cloth,
		/obj/item/rogueweapon/sword/short,
		/obj/item/rope,
	)
	H.adjust_skillrank(/datum/skill/misc/medicine, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
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
	if(H.mind)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/diagnose/secular)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
