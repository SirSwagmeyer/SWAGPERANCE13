// note for mappers: please put in the trench shotgun & reaper rifle in this guy's armory
// ^^^^^^^^
/datum/job/roguetown/bulwark
	title = "Bulwark"
	flag = BULWARK
	department_flag = RISVON
	faction = "Station"
	total_positions = 6 //temporary solution
	spawn_positions = 6
	allowed_races = RACES_TEMPERANCE
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT)
	advclass_cat_rolls = list(CTAG_BULWARK = 20)


	tutorial = "You're one of the Hierarch's most trusted underlings. \
				You have exclusive access to one of the many high-tier weapons the Hierarch has stockpiled. \
				The main goal is to keep the Hierarch and the town alive. People treat you like a sheriff. \
				Contrary to your namesake, you aren't invincible. Your main strength comes from your guns." 

	outfit = /datum/outfit/job/roguetown/bulwark
	display_order = JDO_BULWARK
	give_bank_account = TRUE
	min_pq = 0
	max_pq = null

	cmode_music = 'sound/music/combat_bulwark.ogg'

/datum/outfit/job/roguetown/bulwark/pre_equip(mob/living/carbon/human/H)
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy //originally was going to be heavy/bulwark, but it looks like shit lol
	shoes = /obj/item/clothing/shoes/roguetown/boots
	armor = /obj/item/clothing/suit/roguetown/armor/leather/heavy/bulwark
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
	belt = /obj/item/storage/belt/rogue/leather/black
	beltl = /obj/item/gun/ballistic/pistol/luger
	beltr = /obj/item/storage/belt/rogue/pouch/stim
	gloves = /obj/item/clothing/gloves/roguetown/eastgloves1
	wrists = /obj/item/scomstone/kingsrow
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE) //how else u gonna drag john shitter outta the town
	H.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/pistols, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/armorsmithing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
	H.change_stat("constitution", 2)
	H.change_stat("endurance", 1)
	H.change_stat("perception", 2)
	H.change_stat("speed", 2)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)


/datum/job/roguetown/bulwark/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	. = ..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")

/datum/advclass/bulwark/shotgun
	name = "Frontman"
	tutorial = "You've selected one of the better shotguns in Kingsrow's armory. Armed with a PAX, your entire thing is trying to engage in tight hallways."
	outfit = /datum/outfit/job/roguetown/bulwark/shotgun
	category_tags = list(CTAG_BULWARK)

/datum/outfit/job/roguetown/bulwark/shotgun/pre_equip(mob/living/carbon/human/H)
	backl = /obj/item/gun/ballistic/shotgun/eternal
	backr = /obj/item/storage/backpack/rogue/satchel/chestrig
	backpack_contents = list(
		/obj/item/reagent_containers/glass/bottle/rogue/healthpotnew = 2,
		/obj/item/ammo_box/handfuls/shotgun = 6,
		/obj/item/storage/belt/rogue/pouch/coins/mid = 1,
		/obj/item/storage/keyring/gatemaster = 1,
		/obj/item/flashlight/flare/torch/lantern = 1,
		/obj/item/ammo_box/magazine/luger = 3,
	)
	H.adjust_skillrank(/datum/skill/combat/shotguns, 4, TRUE)

/datum/advclass/bulwark/rifle
	name = "Marksman"
	tutorial = "You've selected one of the better rifles in Kingsrow's armory. Armed with a GRD 'Reaper,' you generally favor individual targets, and open fields."
	outfit = /datum/outfit/job/roguetown/bulwark/rifle
	category_tags = list(CTAG_BULWARK)

/datum/outfit/job/roguetown/bulwark/rifle/pre_equip(mob/living/carbon/human/H)
	backl = /obj/item/gun/ballistic/rifle/reaper
	backr = /obj/item/storage/backpack/rogue/satchel/chestrig
	backpack_contents = list(
		/obj/item/reagent_containers/glass/bottle/rogue/healthpotnew = 2,
		/obj/item/ammo_box/clip/reaper = 6,
		/obj/item/storage/belt/rogue/pouch/coins/mid = 1,
		/obj/item/storage/keyring/gatemaster = 1,
		/obj/item/flashlight/flare/torch/lantern = 1,
		/obj/item/ammo_box/magazine/luger = 3,
	)
	H.adjust_skillrank(/datum/skill/combat/rifles, 4, TRUE)

