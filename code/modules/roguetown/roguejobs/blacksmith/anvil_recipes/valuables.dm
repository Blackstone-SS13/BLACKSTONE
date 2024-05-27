/datum/anvil_recipe/valuables
	appro_skill = /datum/skill/craft/blacksmithing
	craftdiff = 2
/datum/anvil_recipe/valuables/gold
	name = "Statue"
	req_bar = /obj/item/ingot/gold
	created_item = /obj/item/roguestatue/gold

/datum/anvil_recipe/valuables/silver
	name = "Statue"
	req_bar = /obj/item/ingot/silver
	created_item = /obj/item/roguestatue/silver

/datum/anvil_recipe/valuables/iron
	name = "Statue"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/roguestatue/iron

/datum/anvil_recipe/valuables/steel
	name = "Statue"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/roguestatue/steel

/*
/datum/anvil_recipe/valuables/eargol
	name = "gold earrings"
	req_bar = /obj/item/ingot/gold
	created_item = list(/obj/item/rogueacc/eargold,
						/obj/item/rogueacc/eargold,
						/obj/item/rogueacc/eargold)

/datum/anvil_recipe/valuables/earsil
	name = "silver earrings"
	req_bar = /obj/item/ingot/silver
	created_item = list(/obj/item/rogueacc/earsilver,
						/obj/item/rogueacc/earsilver,
						/obj/item/rogueacc/earsilver)*/

/datum/anvil_recipe/valuables/ringg
	name = "Rings 3x"
	req_bar = /obj/item/ingot/gold
	created_item = list(/obj/item/clothing/ring/gold, /obj/item/clothing/ring/gold, /obj/item/clothing/ring/gold)

/datum/anvil_recipe/valuables/rings
	name = "Rings 3x"
	req_bar = /obj/item/ingot/silver
	created_item = list(/obj/item/clothing/ring/silver, /obj/item/clothing/ring/silver, /obj/item/clothing/ring/silver)

//gold rings
/datum/anvil_recipe/valuables/emeringg
	name = "Gemerald ring (+ Gemerald)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/roguegem/green)	
	created_item = /obj/item/clothing/ring/emerald

/datum/anvil_recipe/valuables/rubyg
	name = "Rontz ring (+ Rontz)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/roguegem)	
	created_item = /obj/item/clothing/ring/ruby

/datum/anvil_recipe/valuables/topazg
	name = "Toper ring (+ Toper)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/roguegem/yellow)	
	created_item = /obj/item/clothing/ring/topaz

/datum/anvil_recipe/valuables/quartzg
	name = "Blortz ring (+ Blortz)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/roguegem/blue)	
	created_item = /obj/item/clothing/ring/quartz

/datum/anvil_recipe/valuables/sapphireg
	name = "Saffira ring (+ Saffira)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/roguegem/violet)	
	created_item = /obj/item/clothing/ring/sapphire

/datum/anvil_recipe/valuables/diamondg
	name = "Dorpel ring (+ Dorpel)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/roguegem/diamond)	
	created_item = /obj/item/clothing/ring/diamond

//steel rings
/datum/anvil_recipe/valuables/emerings
	name = "Gemerald ring (+ Gemerald)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/roguegem/green)	
	created_item = /obj/item/clothing/ring/emeralds

/datum/anvil_recipe/valuables/rubys
	name = "Rontz ring (+ Rontz)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/roguegem)	
	created_item = /obj/item/clothing/ring/rubys

/datum/anvil_recipe/valuables/topazs
	name = "Toper ring (+ Toper)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/roguegem/yellow)	
	created_item = /obj/item/clothing/ring/topazs

/datum/anvil_recipe/valuables/quartzs
	name = "Blortz ring (+ Blortz)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/roguegem/blue)	
	created_item = /obj/item/clothing/ring/quartzs

/datum/anvil_recipe/valuables/sapphires
	name = "Saffira ring (+ Saffira)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/roguegem/violet)	
	created_item = /obj/item/clothing/ring/sapphires

/datum/anvil_recipe/valuables/diamonds
	name = "Dorpel ring (+ Dorpel)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/roguegem/diamond)	
	created_item = /obj/item/clothing/ring/diamonds

/datum/anvil_recipe/valuables/terminus
	name = "Terminus Est (+ 1 Gold Bar, + 1 Steel, + 1 Rontz)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/ingot/gold, /obj/item/ingot/steel, /obj/item/roguegem)	
	created_item = /obj/item/rogueweapon/sword/long/exe/cloth
	craftdiff = 3

