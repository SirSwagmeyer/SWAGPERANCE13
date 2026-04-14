/obj/projectile/bullet/flamer
	name = "flamer napalm"
	icon_state = "flame"
	damage = 40
	armor_penetration = 30
	hitscan = FALSE
	ignore_source_check = TRUE
	woundclass = BCLASS_BURN
	spread = 15
	damage_type = BURN

/obj/projectile/bullet/flamer/on_hit(target)
	. = ..()
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		if(!istype(H.wear_armor, /obj/item/clothing/suit/roguetown/armor/leather/heavy/coat/flamer))
			H.adjust_fire_stacks(5)
			H.IgniteMob()
			H.emote("agony", forced = TRUE)
		new /obj/flamer_fire(get_turf(src))

/obj/flamer_fire
	name = "fire"
	desc = "AHHHHHHH!!!"
	anchored = 1
	mouse_opacity = 0
	icon = 'icons/effects/fire.dmi'
	icon_state = "red_2"
	var/firelevel = 12 //Tracks how much "fire" there is. Basically the timer of how long the fire burns
	var/burnlevel = 10 //Tracks how HOT the fire is. This is basically the heat level of the fire and determines the temperature.
	var/flame_color = "red"

/obj/flamer_fire/New(loc, fire_lvl, burn_lvl, f_color, fire_spread_amount)
	..()
	var/turf/T = loc
	if(!istype(T)) //Is it a valid turf? Has to be on a floor
		qdel(src)
		return

	updateicon()

	if(!firelevel)
		qdel(src)
		return
	if(istype(loc, /turf/open/water))//No catching the water on fire.
		qdel(src)
	playsound(src, pick(FLAMECOMBUST), 50)
	if (f_color)
		flame_color = f_color

	icon_state = "[flame_color]_2"
	if(fire_lvl) firelevel = fire_lvl
	if(burn_lvl) burnlevel = burn_lvl
	START_PROCESSING(SSobj,src)

	if(fire_spread_amount > 0)
		var/turf/Turf
		for(var/dirn in GLOB.cardinals)
			Turf = get_step(loc, dirn)
			if(istype(Turf,/turf/open/water)) continue//Do not light the water on fire please.
			if(locate(/obj/flamer_fire) in Turf) continue //No stacking
			var/new_spread_amt = Turf.density ? 0 : fire_spread_amount - 1 //walls stop the spread
			if(new_spread_amt)
				for(var/obj/O in Turf)
					if(!O.CanPass(src, loc))
						new_spread_amt = 0
						break
			spawn(0) //delay so the newer flame don't block the spread of older flames
				new /obj/flamer_fire(Turf, fire_lvl, burn_lvl, f_color, new_spread_amt)


/obj/flamer_fire/Destroy()
	//for(var/obj/o in particles)
	//	qdel(o)
	set_light(0)
	STOP_PROCESSING(SSobj,src)
	. = ..()


/obj/flamer_fire/Crossed(mob/living/M) //Only way to get it to reliable do it when you walk into it.
	if(istype(M))
		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			if(istype(H.wear_armor, /obj/item/clothing/suit/roguetown/armor/leather/heavy/coat/flamer))
				return
		M.adjust_fire_stacks(burnlevel) //Make it possible to light them on fire later.
		if (prob(firelevel + 2*M.fire_stacks)) //the more soaked in fire you are, the likelier to be ignited
			M.IgniteMob()

		M.adjustFireLoss(round(burnlevel*0.5)) //This makes fire stronk.
		M.emote("agony", forced = TRUE)

/obj/flamer_fire/proc/updateicon()
	if(burnlevel < 15)
		color = "#dfdfdf" //make it darker to make show its weaker.
		alpha = 195
	switch(firelevel)
		if(1 to 9)
			icon_state = "[flame_color]_1"
			set_light(l_color = rgb(LERP(250,150,1),LERP(160,150,1),LERP(25,150,1)))
		if(10 to 25)
			icon_state = "[flame_color]_2"
			set_light(l_color = rgb(LERP(250,150,1),LERP(160,150,1),LERP(25,150,1)))
		if(25 to INFINITY) //Change the icons and luminosity based on the fire's intensity
			icon_state = "[flame_color]_3"
			set_light(l_color = rgb(LERP(250,150,1),LERP(160,150,1),LERP(25,150,1)))


/obj/flamer_fire/process()

	firelevel = max(0, firelevel)

	updateicon()

	if(!firelevel)
		qdel(src)
		return
	update_icon()
	var/j = 0
	for(var/i in loc)
		if(++j >= 11) break
		if(isliving(i))
			var/mob/living/I = i
			if(istype(I,/mob/living/carbon/human))
				var/mob/living/carbon/human/M = I
				if(istype(M.wear_armor, /obj/item/clothing/suit/roguetown/armor/leather/heavy/coat/flamer))
					continue
			I.adjust_fire_stacks(burnlevel) //If i stand in the fire i deserve all of this. Also Napalm stacks quickly.
			I.IgniteMob()

	//This has been made a simple loop, for the most part flamer_fire_act() just does return, but for specific items it'll cause other effects.
	firelevel -= 2 //reduce the intensity by 2 per tick
	return
