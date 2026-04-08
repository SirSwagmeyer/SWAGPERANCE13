
/obj/effect/landmark/mapGenerator/rogue/perserdun
	mapGeneratorType = /datum/mapGenerator/perserdun
	endTurfX = 128
	endTurfY = 128
	startTurfX = 1
	startTurfY = 1


/datum/mapGenerator/perserdun
	modules = list(/datum/mapGeneratorModule/perserdun,/datum/mapGeneratorModule/perserdunroad)


/datum/mapGeneratorModule/perserdun
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	allowed_turfs = list(/turf/open/floor/rogue/dirt)
	excluded_turfs = list(/turf/open/floor/rogue/dirt/road)
	spawnableAtoms = list(/obj/structure/flora/newtree = 5,
							/obj/structure/flora/roguegrass/bush = 15,
							/obj/structure/flora/roguegrass = 20,
							/obj/structure/flora/roguegrass/herb/random = 3,
							/obj/structure/flora/roguegrass/bush/westleach = 3,
							/obj/item/natural/stone = 20,
							/obj/item/natural/rock = 3,
							/obj/item/grown/log/tree/stick = 10,
							/obj/structure/flora/roguetree/stump/log = 1,
							/obj/structure/flora/roguetree/stump = 10,
							/obj/effect/mine/explosive = 1,
							/obj/effect/frogmine = 1,
							/obj/structure/flora/roguetree/burnt = 20)
	spawnableTurfs = list(/turf/open/floor/rogue/dirt/road=2,
						/turf/open/water/swamp=1)
	allowed_areas = list(/area/rogue/outdoors/perserdun)

/datum/mapGeneratorModule/perserdunroad
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	allowed_turfs = list(/turf/open/floor/rogue/dirt/road)
	spawnableAtoms = list(/obj/item/natural/stone = 5,/obj/item/grown/log/tree/stick = 1)

