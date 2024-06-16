
/mob/living/simple_animal/Topic(href, href_list)
	. = ..()
	if(href_list["inspect_animal"] && (isobserver(usr) || usr.canUseTopic(src, BE_CLOSE, NO_DEXTERITY)))
		var/list/msg = list()
		if(length(simple_wounds))
			msg += "<B>Wounds:</B>"
			for(var/datum/wound/wound as anything in simple_wounds)
				msg += wound.get_visible_name(usr)

		if(length(simple_embedded_objects))
			msg += "<B>Embedded objects:</B>"
			for(var/obj/item/embedded in simple_embedded_objects)
				msg += "<a href='?src=[REF(src)];embedded_object=[REF(embedded)]'>[embedded.name]</a>"

		to_chat(usr, span_info("[msg.Join("\n")]"))

	if(href_list["embedded_object"] && usr.canUseTopic(src, BE_CLOSE, NO_DEXTERITY))
		var/obj/item/I = locate(href_list["embedded_object"]) in simple_embedded_objects
		if(QDELETED(I) || !simple_remove_embedded_object(I))
			return
		usr.put_in_hands(I)
		playsound(loc, 'sound/foley/flesh_rem.ogg', 100, TRUE, -2)
		if(usr == src)
			usr.visible_message(span_notice("[usr] rips [I] out of [usr.p_them()]self!"), span_notice("I remove [I] from myself."))
		else
			usr.visible_message(span_notice("[usr] rips [I] out of [src]!"), span_notice("I rip [I] from [src]."))
