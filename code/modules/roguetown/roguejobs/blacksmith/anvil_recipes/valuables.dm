/datum/anvil_recipe/valuables
	appro_skill = /datum/skill/craft/blacksmithing
	craftdiff = 2

/datum/anvil_recipe/valuables/gold
	name = "gold statue"
	req_bar = /obj/item/ingot/gold
	created_item = /obj/item/roguestatue/gold
	i_type = "Valuables"

/datum/anvil_recipe/valuables/silver
	name = "silver statue"
	req_bar = /obj/item/ingot/silver
	created_item = /obj/item/roguestatue/silver
	i_type = "Valuables"

/datum/anvil_recipe/valuables/iron
	name = "iron statue"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/roguestatue/iron
	i_type = "Valuables"

/datum/anvil_recipe/valuables/steel
	name = "steel statue"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/roguestatue/steel
	i_type = "Valuables"

/*
/datum/anvil_recipe/valuables/eargol
	name = "gold earrings"
	req_bar = /obj/item/ingot/gold
	created_item = list(/obj/item/rogueacc/eargold,
						/obj/item/rogueacc/eargold,
						/obj/item/rogueacc/eargold)
	type = "Valuables"

/datum/anvil_recipe/valuables/earsil
	name = "silver earrings"
	req_bar = /obj/item/ingot/silver
	created_item = list(/obj/item/rogueacc/earsilver,
						/obj/item/rogueacc/earsilver,
						/obj/item/rogueacc/earsilver)*/
//	i_type = "Valuables"

/datum/anvil_recipe/valuables/ringg
	name = "3x gold rings"
	req_bar = /obj/item/ingot/gold
	created_item = list(/obj/item/clothing/ring/gold, /obj/item/clothing/ring/gold, /obj/item/clothing/ring/gold)
	i_type = "Valuables"

/datum/anvil_recipe/valuables/rings
	name = "3x silver rings"
	req_bar = /obj/item/ingot/silver
	created_item = list(/obj/item/clothing/ring/silver, /obj/item/clothing/ring/silver, /obj/item/clothing/ring/silver)
	i_type = "Valuables"

//gold rings
/datum/anvil_recipe/valuables/emeringg
	name = "Gold Gemerald Ring (+ Gemerald)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/roguegem/green)	
	created_item = /obj/item/clothing/ring/emerald
	i_type = "Valuables"

/datum/anvil_recipe/valuables/rubyg
	name = "Gold Rontz Ring (+ Rontz)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/roguegem)	
	created_item = /obj/item/clothing/ring/ruby
	i_type = "Valuables"

/datum/anvil_recipe/valuables/topazg
	name = "Gold Toper Ring (+ Toper)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/roguegem/yellow)	
	created_item = /obj/item/clothing/ring/topaz
	i_type = "Valuables"

/datum/anvil_recipe/valuables/quartzg
	name = "Gold Blortz Ring (+ Blortz)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/roguegem/blue)	
	created_item = /obj/item/clothing/ring/quartz
	i_type = "Valuables"

/datum/anvil_recipe/valuables/sapphireg
	name = "Gold Saffira Ring (+ Saffira)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/roguegem/violet)	
	created_item = /obj/item/clothing/ring/sapphire
	i_type = "Valuables"

/datum/anvil_recipe/valuables/diamondg
	name = "Gold Dorpel Ring (+ Dorpel)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/roguegem/diamond)	
	created_item = /obj/item/clothing/ring/diamond
	i_type = "Valuables"

//steel rings
/datum/anvil_recipe/valuables/emerings
	name = "Steel Gemerald Ring (+ Gemerald)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/roguegem/green)	
	created_item = /obj/item/clothing/ring/emeralds
	i_type = "Valuables"

/datum/anvil_recipe/valuables/rubys
	name = "Steel Rontz Ring (+ Rontz)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/roguegem)	
	created_item = /obj/item/clothing/ring/rubys
	i_type = "Valuables"

/datum/anvil_recipe/valuables/topazs
	name = "Steel Toper Ring (+ Toper)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/roguegem/yellow)	
	created_item = /obj/item/clothing/ring/topazs
	i_type = "Valuables"

/datum/anvil_recipe/valuables/quartzs
	name = "Steel Blortz Ring (+ Blortz)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/roguegem/blue)	
	created_item = /obj/item/clothing/ring/quartzs
	i_type = "Valuables"

/datum/anvil_recipe/valuables/sapphires
	name = "Steel Saffira Ring (+ Saffira)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/roguegem/violet)	
	created_item = /obj/item/clothing/ring/sapphires
	i_type = "Valuables"

/datum/anvil_recipe/valuables/diamonds
	name = "Steel Dorpel Ring (+ Dorpel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/roguegem/diamond)	
	created_item = /obj/item/clothing/ring/diamonds
	i_type = "Valuables"

/datum/anvil_recipe/valuables/terminus
	name = "Terminus Est (+ 1 Gold Bar, + 1 Steel, + 1 Rontz)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/ingot/gold, /obj/item/ingot/steel, /obj/item/roguegem)	
	created_item = /obj/item/rogueweapon/sword/long/exe/cloth
	craftdiff = 3
	i_type = "Weapons"

