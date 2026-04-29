/datum/reagent/erpjuice
	name = "Erotic Fluid"
	reagent_state = LIQUID
	color = "#ebebeb"
	metabolization_rate = 0.1

/datum/reagent/erpjuice/on_mob_life(mob/living/carbon/M)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		H.adjust_hydration(1)
		H.adjust_nutrition(0.5) //Semen is not very nutritious. The player can go about 3 rounds of cumming before needing to wait a long time code-wise to cum more.
		if(H.blood_volume < BLOOD_VOLUME_NORMAL)
			H.blood_volume = min(H.blood_volume+10, BLOOD_VOLUME_NORMAL)
	..()

/datum/reagent/erpjuice/cum
	description = "A thick, sticky, cream like fluid. produced during an orgasm."
	taste_description = "salty and tangy"

/datum/reagent/erpjuice/femcum
	description = "A slightly milky fluid, thin and watery in texture."
	taste_description = "faintly sweet and mineraly"
