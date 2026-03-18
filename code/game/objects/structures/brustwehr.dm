//port from escal, this is horrific shitcode bye
/obj/structure/brutswehrincomplete
	name = "incomplete brustwehr"
	icon = 'icons/obj/structures.dmi'
	icon_state = "brustwehr_isntready"
	density = 1
	anchored = 1
	climbable = FALSE
	var/digstage = 0

/obj/structure/brutswehr/CanPass(atom/movable/mover, turf/target)
	if(isobserver(mover))
		return 1
	if(istype(mover) && (mover.pass_flags & PASSGRILLE))
		return 1
	if(mover.throwing && !ismob(mover))
		return 1
	return ..()

/obj/structure/brutswehrincomplete/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/rogueweapon/shovel))
		var/obj/item/rogueweapon/shovel/C = W
		if(user.used_intent.type == /datum/intent/shovelscoop)
			if(C.heldclod)
				if(C.working)
					return
				C.working = 1
				if(!C.ground > 0)
					C.working = 0
					return
				playsound(src, 'sound/items/empty_shovel.ogg', 100, 1)
				if(!do_after(user, 10,src))
					to_chat(user, "Hold still to do this.")
					C.working = 0
					return
				C.ground--
				digstage++
				C.working = 0
				to_chat(user, "You put some ground onto the [src].")
				if(digstage <= 2)
					to_chat(user, "<span class='warning'>You need [3 - digstage] more piles.</span>")
				update_stage()
				var/obj/item/I = C.heldclod
				C.heldclod = null
				qdel(I)
				C.update_icon()

		else
			return ..()

/obj/structure/brutswehrincomplete/proc/update_stage()
	if(digstage >= 3)
		new /obj/structure/brutswehr(src.loc)
		qdel(src)

/obj/structure/brutswehr
	name = "brustwehr"
	desc = "Land structure to cover your ass!"
	icon = 'icons/obj/sandbags.dmi'
	icon_state = "brustwehr_0"
	density = 1
	anchored = 1
	smooth = TRUE
	climbable = TRUE
	var/basic_chance = 20
	var/health = 800
	var/reinforced = 0 //has there been a bridge built?

/obj/structure/brutswehr/New()
	..()
	update_nearby_icons()

/obj/structure/brutswehr/Destroy()
	basic_chance = null
	..()


/obj/structure/brutswehr/CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
	if(istype(mover, /obj/projectile))
		var/obj/projectile/proj = mover

		if(proj.firer && Adjacent(proj.firer))
			return 1

		if (get_dist(proj.starting, loc) <= 1)//allows to fire from 1 tile away of sandbag
			return 1

		return check_cover(mover, target)

	else if(istype(mover, /obj))
		return 1

	else
		..()

//checks if projectile 'P' from turf 'from' can hit whatever is behind the table. Returns 1 if it can, 0 if bullet stops.
/obj/structure/brutswehr/proc/check_cover(obj/projectile/P, turf/from)
	var/turf/cover = get_step(loc, get_dir(from, loc))
	if (get_dist(P.starting, loc) <= 1) //Barricades won't help you if people are THIS close
		return 1
	if (get_turf(P.original) == cover)
		var/chance = 70
		if (ismob(P.original))
			var/mob/living/L = P.original
			if(!isnull(L.mind) && (L.mobility_flags & MOBILITY_STAND) && !L.buckled)
				chance += 20				//Lying down lets you catch less bullets 
		if(prob(chance))
			health -= P.damage/4
			visible_message("<span class='warning'>[P] hits [src]!</span>")
			health_check()
			return 0
	return 1

	//Check Health
/obj/structure/brutswehr/proc/health_check(var/die)
	if(health < 1 || die)
		update_nearby_icons()
		visible_message("\red <B>[src] falls apart!</B>")
		qdel(src)

	//Explosion Act
/obj/structure/brutswehr/ex_act(severity)
	switch(severity)
		if(1.0)
			visible_message("\red <B>[src] is blown apart!</B>")
			src.update_nearby_icons()
			qdel(src)
			return
		if(2.0)
			src.health -= rand(30,60)
			if (src.health <= 0)
				visible_message("\red <B>[src] is blown apart!</B>")
				src.update_nearby_icons()
				qdel(src)
			return
		if(3.0)
			src.health -= rand(10,30)
			if (src.health <= 0)
				visible_message("\red <B>[src] is blown apart!</B>")
				src.update_nearby_icons()
				qdel(src)
			return

	//Update Sides
/obj/structure/brutswehr/proc/update_nearby_icons()
	update_icon()
	for(var/direction in GLOB.cardinals)
		for(var/obj/structure/brutswehr/B in get_step(src,direction))
			B.update_icon()

	//Update Icons
/obj/structure/brutswehr/update_icon()
	spawn(2)
		if(!src)
			return
		var/junction = 0 //will be used to determine from which side the barricade is connected to other barricades
		for(var/obj/structure/brutswehr/B in orange(src,1))
			if(abs(x-B.x)-abs(y-B.y) ) 		//doesn't count barricades, placed diagonally to src
				junction |= get_dir(src,B)

		icon_state = "brustwehr_[junction]"
		return


/*
/obj/item/weapon/ore/glass/attack_self(mob/user as mob)
	if(!isturf(user.loc))
		to_chat(user, "\red Haha. Nice try.")
		return

	if(!check4struct(user))
		return

	var/obj/structure/brutswehr/B = new(user.loc)
	B.set_dir(user.dir)
	user.drop_item()
	qdel(src)
*/
