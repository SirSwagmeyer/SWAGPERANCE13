/datum/advclass/mage
	name = "Mage"
	tutorial = "Mages are skilled in the arcane. Scholars all over the world spend years studying magic - most do not succeed."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/mage
	category_tags = list(CTAG_ADVENTURER, CTAG_COURTAGENT)
	traits_applied = list(TRAIT_OUTLANDER)
	classes = list("Sorcerer" = "You are a learned mage and a scholar, having spent your life studying the arcane and its ways.")

/datum/outfit/job/roguetown/adventurer/mage/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/classes = list("Sorcerer")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)
	
		if("Sorcerer")
			to_chat(H, span_warning("You are a learned mage and a scholar, having spent your life studying the arcane and its ways."))
			head = /obj/item/clothing/head/roguetown/roguehood/mage
			shoes = /obj/item/clothing/shoes/roguetown/boots
			pants = /obj/item/clothing/under/roguetown/trou/leather
			shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
			armor = /obj/item/clothing/suit/roguetown/shirt/robe/mage
			belt = /obj/item/storage/belt/rogue/leather
			beltr = /obj/item/reagent_containers/glass/bottle/rogue/manapot
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			beltl = /obj/item/rogueweapon/huntingknife
			backl = /obj/item/storage/backpack/rogue/satchel
			backr = /obj/item/rogueweapon/woodstaff
			backpack_contents = list(
				/obj/item/flashlight/flare/torch = 1,
				/obj/item/spellbook_unfinished/pre_arcyne = 1,
				/obj/item/roguegem/amethyst = 1,
				/obj/item/recipe_book/survival = 1,
				/obj/item/rogueweapon/scabbard/sheath = 1,
				/obj/item/recipe_book/magic = 1,
				/obj/item/chalk = 1
				)
			H.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
			H.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
			H.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
			H.adjust_skillrank(/datum/skill/craft/alchemy, 2, TRUE)
			H.adjust_skillrank(/datum/skill/magic/arcane, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.dna.species.soundpack_m = new /datum/voicepack/male/wizard()
			if(H.age == AGE_OLD)
				H.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)
				H.mind?.adjust_spellpoints(6)
			H.change_stat("intelligence", 3)
			H.change_stat("perception", 2)
			H.change_stat("speed", 1)
			H.mind?.adjust_spellpoints(18)
			H.mind?.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
			ADD_TRAIT(H, TRAIT_MAGEARMOR, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_ARCYNE_T3, TRAIT_GENERIC)
			H.cmode_music = 'sound/music/cmode/adventurer/combat_outlander4.ogg'
			switch(H.patron?.type)
				if(/datum/patron/inhumen/zizo)
					H.cmode_music = 'sound/music/combat_heretic.ogg'
