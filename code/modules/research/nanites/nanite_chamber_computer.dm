/obj/machinery/computer/nanite_chamber_control
	name = "nanite chamber control console"
	desc = "Controls a connected nanite chamber. Can inoculate nanites, load programs, and analyze existing nanite swarms."
	var/obj/machinery/nanite_chamber/chamber
	var/obj/item/disk/nanite_program/disk
	circuit = /obj/item/circuitboard/computer/nanite_chamber_control
	icon_screen = "nanite_chamber_control"

/obj/machinery/computer/nanite_chamber_control/Initialize()
	. = ..()
	find_chamber()

/obj/machinery/computer/nanite_chamber_control/proc/find_chamber()
	for(var/direction in GLOB.cardinals)
		var/C = locate(/obj/machinery/nanite_chamber, get_step(src, direction))
		if(C)
			var/obj/machinery/nanite_chamber/NC = C
			chamber = NC
			NC.console = src

/obj/machinery/computer/nanite_chamber_control/interact()
	if(!chamber)
		find_chamber()
	..()

/obj/machinery/computer/nanite_chamber_control/ui_interact(mob/user, ui_key = "main", datum/tgui/ui = null, force_open = FALSE, datum/tgui/master_ui = null, datum/ui_state/state = GLOB.default_state)
	SStgui.try_update_ui(user, src, ui_key, ui, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "nanite_chamber_control", name, 550, 800, master_ui, state)
		ui.open()

/obj/machinery/computer/nanite_chamber_control/ui_data()
	var/list/data = list()

	if(!chamber)
		data["status_msg"] = "No chamber detected."
		return data

	if(!chamber.occupant)
		data["status_msg"] = "No occupant detected."
		return data

	var/mob/living/L = chamber.occupant

	if(!(MOB_ORGANIC in L.mob_biotypes) && !(MOB_UNDEAD in L.mob_biotypes))
		data["status_msg"] = "Occupant not compatible with nanites."
		return data

	if(chamber.busy)
		data["status_msg"] = chamber.busy_message
		return data

	data["scan_level"] = chamber.scan_level
	data["locked"] = chamber.locked
	data["occupant_name"] = chamber.occupant.name

	SEND_SIGNAL(L, COMSIG_NANITE_UI_DATA, data, chamber.scan_level)

	return data

/obj/machinery/computer/nanite_chamber_control/ui_act(action, params)
	if(..())
		return
	switch(action)
		if("toggle_lock")
			chamber.locked = !chamber.locked
			chamber.update_icon()
			. = TRUE
		if("set_safety")
			var/threshold = input("Set safety threshold (0-500):", name, null) as null|num
			if(!isnull(threshold))
				chamber.set_safety(CLAMP(round(threshold, 1),0,500))
				playsound(src, "terminal_type", 25, 0)
				chamber.occupant.investigate_log("'s nanites' safety threshold was set to [threshold] by [key_name(usr)] via [src] at [AREACOORD(src)].", INVESTIGATE_NANITES)
			. = TRUE
		if("set_cloud")
			var/cloud_id = input("Set cloud ID (1-100, 0 to disable):", name, null) as null|num
			if(!isnull(cloud_id))
				chamber.set_cloud(CLAMP(round(cloud_id, 1),0,100))
				playsound(src, "terminal_type", 25, 0)
				chamber.occupant.investigate_log("'s nanites' cloud id was set to [cloud_id] by [key_name(usr)] via [src] at [AREACOORD(src)].", INVESTIGATE_NANITES)
			. = TRUE
		if("toggle_cloud")
			chamber.toggle_cloud()
			playsound(src, "terminal_type", 25, 0)
			chamber.occupant.investigate_log("'s nanites' cloud sync was toggled by [key_name(usr)] via [src] at [AREACOORD(src)].", INVESTIGATE_NANITES)
			. = TRUE
		if("connect_chamber")
			find_chamber()
			. = TRUE
		if("nanite_injection")
			playsound(src, 'sound/machines/terminal_prompt.ogg', 25, 0)
			chamber.inject_nanites()
			log_combat(usr, chamber.occupant, "injected", null, "with nanites via [src]")
			chamber.occupant.investigate_log("was injected with nanites by [key_name(usr)] via [src] at [AREACOORD(src)].", INVESTIGATE_NANITES)
			. = TRUE
