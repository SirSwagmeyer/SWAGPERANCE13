
/obj/effect/landmark/mapGenerator/rogue/risvon
	mapGeneratorType = /datum/mapGenerator/risvon
	endTurfX = 128
	endTurfY = 128
	startTurfX = 1
	startTurfY = 1


/datum/mapGenerator/risvon
	modules = list(/datum/mapGeneratorModule/risvon,/datum/mapGeneratorModule/risvonroad)


/datum/mapGeneratorModule/risvon
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	allowed_turfs = list(/turf/open/floor/rogue/dirt, /turf/open/floor/rogue/grassred)
	excluded_turfs = list(/turf/open/floor/rogue/dirt/road)
	spawnableAtoms = list(/obj/structure/flora/newtree = 20,
							/obj/structure/flora/roguegrass/bush = 20,
							/obj/structure/flora/roguegrass = 50,
							/obj/structure/flora/roguegrass/herb/random = 7,
							/obj/structure/flora/roguegrass/bush/westleach = 7,
							/obj/item/natural/stone = 23,
							/obj/item/natural/rock = 6,
							/obj/item/grown/log/tree/stick = 16,
							/obj/structure/flora/roguetree/stump/log = 3,
							/obj/structure/flora/roguetree/stump = 4,
							/obj/effect/frogmine = 1,
							/obj/effect/mine/explosive = 1)
	spawnableTurfs = list(/turf/open/floor/rogue/dirt/road=2)
	allowed_areas = list(/area/rogue/outdoors/risvon)

/datum/mapGeneratorModule/risvonroad
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	allowed_turfs = list(/turf/open/floor/rogue/dirt/road)
	spawnableAtoms = list(/obj/item/natural/stone = 5,/obj/item/grown/log/tree/stick = 3)

