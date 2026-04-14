/obj/effect/shrapnel
	var/projectile_type
	var/radius // shoots a projectile for every turf on this radius from the hit target
	var/override_projectile_range

/obj/effect/shrapnel/proc/do_shrapnel(mob/firer, atom/target)
	if(radius < 1)
		return
	var/turf/target_turf = get_turf(target)
	for(var/turf/shootat_turf in RANGE_TURFS(radius, target) - RANGE_TURFS(radius-1, target))
		var/obj/projectile/P = new projectile_type(target_turf)
		//Shooting Code:
		P.range = radius+1
		P.shouldfire = TRUE
		if(override_projectile_range)
			P.range = override_projectile_range
		P.preparePixelProjectile(shootat_turf, target)
		P.firer = firer // don't hit ourself that would be really annoying
		P.def_zone = pick(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG, BODY_ZONE_CHEST, BODY_ZONE_HEAD, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM)
		P.permutated += target // don't hit the target we hit already with the flak
		for(var/mob/living/M in target)//if you're on the tile bad things happen
			if(M.lying && isturf(firer.loc))//good luck with your saving private ryan move
				if(rand(1,100) >= 10)
					P.original = M
					P.process_hit(M, P.select_target(target))//just directly call a hit on them
					P.shouldfire = FALSE
					qdel(P)
			else if(!M.lying && firer.loc != get_turf(firer.loc))//if the shrapnel isn't from the turf it's probably on the mob
				if(rand(1,100) >= 35)//don't hold a grenade, man!
					P.original = M
					P.process_hit(M, P.select_target(target))
					P.shouldfire = FALSE
					qdel(P)
			else
				if(rand(1,100) >= 70)//still on the same tile. bad stuff still, but not AS bad.
					P.original = M
					P.process_hit(M, P.select_target(target))
					P.shouldfire = FALSE
					qdel(P)
		if (P.shouldfire == TRUE)
			P.fire()
	qdel(src)
