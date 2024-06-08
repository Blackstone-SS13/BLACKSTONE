/datum/anvil_recipe
	var/name
	var/list/additional_items = list()
	var/material_quality = 0 // accumulated per added ingot (decided by quality of smelting per ingot)
	var/num_of_materials = 1 // why are additional_items and req_bar 2 different things?! THE SLOP!
	var/quality = 0 // accumulated per hit, variant on the skill of the smith.
	var/appro_skill = /datum/skill/craft/blacksmithing
	var/req_bar
	var/created_item
	var/craftdiff = 0
	var/additional_items_text
	var/quality_mod = 0
	var/mistakes
	var/i_type

	var/datum/parent

/datum/anvil_recipe/New(datum/P, ...)
	parent = P
	. = ..()

/datum/anvil_recipe/proc/advance(mob/user, breakthrough = FALSE)
	if(!additional_items_text && additional_items.len)
		for(var/I in additional_items)
			var/obj/item/NI = new I
			additional_items_text = "[additional_items_text], [NI.name]"
			qdel(NI)
	if(additional_items_text)
		to_chat(user, "<span class='info'>Before you can smith, you will need to add [additional_items_text].</span>")
		return FALSE
	if(num_of_materials) // has the median material quality been calculated?
		material_quality = floor(material_quality/num_of_materials)
		num_of_materials = 0
	var/current_mistake = FALSE
	var/proab = 14
	var/skill_level
	if(user.mind)
		skill_level = user.mind.get_skill_level(appro_skill)
		proab = 3*(7-skill_level)
		if(!user.mind.get_skill_level(appro_skill))
			proab = 14
	if(prob(proab))
		current_mistake = TRUE
	if(current_mistake)
		mistakes += 1
		if(mistakes >= 3)
			user.visible_message("<span class='warning'>[user] spoils the bar!</span>")
			if(parent)
				var/obj/item/P = parent
				qdel(P)
			return FALSE
		else
			user.visible_message("<span class='warning'>[user] fumbles with the bar!</span>")
			return FALSE
	else
		quality += (breakthrough ? 15 : 10)+(material_quality*2)
		if(user.mind && isliving(user))
			var/mob/living/L = user
			var/boon = user.mind.get_learning_boon(appro_skill)
			var/amt2raise = L.STAINT/2 // (L.STAINT+L.STASTR)/4 optional: add another stat that isn't int
			//i feel like leveling up takes forever regardless, this would just make it faster
			if(amt2raise > 0)
				user.mind.adjust_experience(appro_skill, amt2raise * boon, FALSE)
		if(breakthrough)
			user.visible_message("<span class='warning'>[user] strikes the bar!</span>")
		else
			user.visible_message("<span class='info'>[user] strikes the bar!</span>")
		return TRUE

/datum/anvil_recipe/proc/item_added(mob/user, obj/item/I)
	additional_items -= I
	user.visible_message("<span class='info'>[user] adds [I]</span>")
	additional_items_text = null

/datum/anvil_recipe/proc/handle_creation(obj/item/I)
	material_quality = floor(material_quality/num_of_materials)-2
	quality = floor((quality/num_of_materials)/1500)
	var/modifier
	switch(quality)
		if(BLACKSMITH_LEVEL_MIN to BLACKSMITH_LEVEL_SPOIL)
			I.name = "spoilt [I.name]"
			modifier = 0.3
		if(BLACKSMITH_LEVEL_AWFUL)
			I.name = "awful [I.name]"
			modifier = 0.5
		if(BLACKSMITH_LEVEL_CRUDE)
			I.name = "crude [I.name]"
			modifier = 0.8
		if(BLACKSMITH_LEVEL_ROUGH)
			I.name = "rough [I.name]"
			modifier = 0.9
		if(BLACKSMITH_LEVEL_COMPETENT)
			I.desc = "[I.desc] It is competently made."
		if(BLACKSMITH_LEVEL_FINE)
			I.name = "fine [I.name]"
			modifier = 1.1
		if(BLACKSMITH_LEVEL_FLAWLESS)
			I.name = "flawless [I.name]"
			modifier = 1.2
		if(BLACKSMITH_LEVEL_LEGENDARY to BLACKSMITH_LEVEL_MAX)
			I.name = "legendary [I.name]"
			modifier = 1.3
	
	if(!modifier)
		return
	I.obj_integrity *= modifier
	I.max_integrity  *= modifier
	I.sellprice *= modifier
	if(istype(I, /obj/item/rogueweapon))
		var/obj/item/rogueweapon/W = I
		W.force *= modifier
		W.throwforce *= modifier
		W.block_chance *= modifier
		W.armor_penetration *= modifier
		W.wdefense *= modifier
	if(istype(I, /obj/item/clothing))
		var/obj/item/clothing/C = I
		C.damage_deflection *= modifier
		C.integrity_failure /= modifier
		C.armor = C.armor.multiplymodifyAllRatings(modifier)
		C.equip_delay_self *= modifier
