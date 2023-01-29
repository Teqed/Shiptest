/datum/job/lawyer
	name = "Lawyer"
	total_positions = 2
	spawn_positions = 2
	wiki_page = "Lawyer" //WS Edit - Wikilinks/Warning
	var/lawyers = 0 //Counts lawyer amount

	outfit = /datum/outfit/job/lawyer

	access = list(ACCESS_LAWYER, ACCESS_COURT, ACCESS_SEC_DOORS)
	minimal_access = list(ACCESS_LAWYER, ACCESS_COURT, ACCESS_SEC_DOORS)
	mind_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_LAWYER

/datum/outfit/job/lawyer
	name = "Lawyer"
	job_icon = "lawyer"
	jobtype = /datum/job/lawyer

	belt = /obj/item/pda/lawyer
	ears = /obj/item/radio/headset/headset_srvsec
	uniform = /obj/item/clothing/under/rank/civilian/lawyer/bluesuit
	alt_uniform = /obj/item/clothing/under/rank/civilian/lawyer/red //WS Edit - Alt Uniforms
	suit = /obj/item/clothing/suit/toggle/lawyer
	shoes = /obj/item/clothing/shoes/laceup
	l_hand = /obj/item/storage/briefcase/lawyer
	l_pocket = /obj/item/laser_pointer
	r_pocket = /obj/item/clothing/accessory/lawyers_badge

	chameleon_extras = /obj/item/stamp/law

/datum/outfit/job/lawyer/corporaterepresentative
	uniform = /obj/item/clothing/under/suit/navy
	suit = /obj/item/clothing/suit/toggle/lawyer/navy
	ears = /obj/item/radio/headset/headset_cent
	neck = /obj/item/clothing/neck/tie/blue
	l_hand = /obj/item/clipboard
	r_pocket = /obj/item/pen/fountain

/datum/outfit/job/lawyer/opscoord //this is the best fit I could find. To-Do, make them their own job dm and outfits
	name = "Operations Coordinator"

	uniform = /obj/item/clothing/under/suit/black
	suit = /obj/item/clothing/suit/toggle/lawyer/black
	ears = /obj/item/radio/headset/binary
	neck = /obj/item/clothing/neck/tie/black
	r_pocket = /obj/item/pen/fourcolor

/datum/outfit/job/lawyer/goldie
	name = "GOLD Delegate"

	uniform = /obj/item/clothing/under/suit/navy
	suit = /obj/item/clothing/suit/toggle/lawyer/minutemen
	neck = /obj/item/clothing/neck/tie/blue
	ears = /obj/item/radio/headset/minutemen
