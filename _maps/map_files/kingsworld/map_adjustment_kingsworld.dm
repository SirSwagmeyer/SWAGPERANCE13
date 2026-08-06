/*
			< ATTENTION >
	If you need to add more map_adjustment, check 'map_adjustment_include.dm'
	These 'map_adjustment.dm' files shouldn't be included in 'dme'
*/

/datum/map_adjustment/kingsworld
	map_file_name = "kingsworld.dmm"
	realm_name = "Kingsworld"
	blacklist = list(
		/datum/job/roguetown/risvonconscript,
		/datum/job/roguetown/perserconscript
	)



