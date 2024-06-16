/datum/anvil_recipe
	var/name
	var/list/additional_items = list()
	var/material_quality = 0 // accumulated per added ingot (decided by quality of smelting per ingot)
	var/num_of_materials = 1
	var/median_calculated = FALSE
	var/quality_level_text = "awful"
	var/quality_level = BLACKSMITH_LEVEL_MIN
	var/quality = 0
	var/appro_skill = /datum/skill/craft/blacksmithing
	var/req_bar
	var/created_item
	var/craftdiff = 0
	var/additional_items_text
	var/quality_mod = 0
	var/mistakes = 0
	var/max_mistakes = 0
	var/i_type

	var/datum/parent

/datum/anvil_recipe/New(datum/P, ...)
	parent = P
	. = ..()

/datum/anvil_recipe/proc/advance(mob/user, breakthrough = FALSE, var/obj/item/rogueweapon/hammer/H)
	if(handle_additional_items(user, FALSE))
		return FALSE
	max_mistakes = 3+num_of_materials
	if(!median_calculated) // has the median material quality been calculated?
		material_quality = floor(material_quality/num_of_materials)
		median_calculated = TRUE
	var/current_mistake = FALSE
	var/proab = 14
	var/skill_level
	if(user.mind)
		skill_level = user.mind.get_skill_level(appro_skill)
		proab = (3*(7-skill_level)-smith_quality)+1
		if(!user.mind.get_skill_level(appro_skill))
			proab = 14
	if(prob(proab))
		current_mistake = TRUE
	if(current_mistake)
		mistakes += 1
		if(mistakes >= max_mistakes)
			user.visible_message("<span class='warning'>[user]'s bar falls apart!</span>")
			if(parent)
				var/obj/item/P = parent
				qdel(P)
			return FALSE
		else
			user.visible_message("<span class='warning'>[user] works a mistake into the bar!</span>", "<span class='warning'>You work a mistake into the bar! ([max_mistakes-mistakes] more mistakes until it falls apart!)</span>")
			return FALSE
	else
		var/quality_change = ((breakthrough ? 15 : 10)+(material_quality-num_of_materials)*2)
		quality += quality_change
		if(user.mind && isliving(user))
			var/mob/living/L = user
			var/boon = user.mind.get_learning_boon(appro_skill)
			var/amt2raise = L.STAINT/2 // (L.STAINT+L.STASTR)/4 optional: add another stat that isn't int
			//i feel like leveling up takes forever regardless, this would just make it faster
			if(amt2raise > 0)
				user.mind.adjust_experience(appro_skill, amt2raise * boon, FALSE)
		if(quality >= 70 && quality_level <= 6)
			quality_level += 1
			quality -= 70
			switch(quality_level)
				if(BLACKSMITH_LEVEL_CRUDE)
					quality_level_text = "crude"
				if(BLACKSMITH_LEVEL_ROUGH)
					quality_level_text = "rough"
				if(BLACKSMITH_LEVEL_COMPETENT)
					quality_level_text = "normal"
				if(BLACKSMITH_LEVEL_FINE)
					quality_level_text = "fine"
				if(BLACKSMITH_LEVEL_FLAWLESS)
					quality_level_text = "flawless"
				if(BLACKSMITH_LEVEL_LEGENDARY to BLACKSMITH_LEVEL_MAX)
					quality_level_text = "legendary"
			to_chat(user, "<span class='info'>You advance the smith item to [quality_level_text] quality level!</span>")
		if(breakthrough)
			user.visible_message("<span class='warning'>[user] strikes the bar!</span>", "<span class='warning'>You strike the bar! (you're roughly [70-quality] work from the next level)</span>")
		else
			user.visible_message("<span class='info'>[user] strikes the bar!</span>", "<span class='info'>You strike the bar! (you're roughly [70-quality] work from the next level)</span>")
		return TRUE

/datum/anvil_recipe/proc/handle_additional_items(mob/user, obj/item/W)
	if(additional_items.len)
		if(!additional_items_text)
			for(var/I in additional_items)
				var/obj/item/NI = new I
				if(additional_items_text)
					additional_items_text = "[additional_items_text], [NI.name]"
				else
					additional_items_text = "[NI.name]"
				qdel(NI)
		if(W)
			user.visible_message("<span class='info'>[user] adds [W]</span>")
		else
			to_chat(user, "<span class='info'>Before you can smith, you will need to add [additional_items_text].</span>")
		return TRUE
	else
		additional_items_text = null
		return FALSE

/datum/anvil_recipe/proc/handle_creation(obj/item/I)
	var/modifier = 0.7+(0.1*quality_level)
	I.name = "[quality_level_text] [I.name]"
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
	if(istype(I, /obj/item/rogueweapon/hammer))
		var/obj/item/rogueweapon/hammer/H
		H.smith_quality = quality_level-3
