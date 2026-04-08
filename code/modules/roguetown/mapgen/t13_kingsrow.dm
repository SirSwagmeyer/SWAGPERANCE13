
/obj/effect/landmark/mapGenerator/rogue/kingsrow
	mapGeneratorType = /datum/mapGenerator/kingsrow
	endTurfX = 225
	endTurfY = 225
	startTurfX = 1
	startTurfY = 1


/datum/mapGenerator/kingsrow
	modules = list(/datum/mapGeneratorModule/kingsrow,/datum/mapGeneratorModule/kingsrowroad,/datum/mapGeneratorModule/kingsrowsnow)


/datum/mapGeneratorModule/kingsrow
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	allowed_turfs = list(/turf/open/floor/rogue/dirt)
	excluded_turfs = list(/turf/open/floor/rogue/dirt/road)
	spawnableAtoms = list(/obj/structure/flora/newtree = 10,
							/obj/structure/flora/roguegrass/bush = 15,
							/obj/structure/flora/roguegrass = 40,
							/obj/structure/flora/roguegrass/herb/random = 5,
							/obj/structure/flora/roguegrass/bush/westleach = 5,
							/obj/item/natural/stone = 15,
							/obj/item/natural/rock = 5,
							/obj/item/grown/log/tree/stick = 10,
							/obj/structure/flora/roguetree/stump/log = 3,
							/obj/structure/flora/roguetree/stump = 4,
							/obj/effect/mine/explosive = 2,
							/obj/effect/frogmine = 2)
	spawnableTurfs = list(/turf/open/floor/rogue/dirt/road=2,
						/turf/open/water/swamp=1)
	allowed_areas = list(/area/rogue/outdoors/beach/forest/south)

/datum/mapGeneratorModule/kingsrowroad
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	allowed_turfs = list(/turf/open/floor/rogue/dirt/road)
	spawnableAtoms = list(/obj/item/natural/stone = 5, /obj/effect/mine/explosive = 1, /obj/effect/frogmine = 1)
	allowed_areas = list(/area/rogue/outdoors/beach/forest/south)

/datum/mapGeneratorModule/kingsrowsnow
	clusterCheckFlags = CLUSTER_CHECK_SAME_ATOMS
	allowed_turfs = list(/turf/open/floor/rogue/snow, /turf/open/floor/rogue/snowpatchy, /turf/open/floor/rogue/snowrough)
	spawnableAtoms = list(/obj/structure/flora/roguegrass = 20, 
                            /obj/structure/flora/roguetree/stump = 4)
