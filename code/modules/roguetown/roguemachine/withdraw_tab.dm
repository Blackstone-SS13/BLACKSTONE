/datum/tab/withdraw
	var/stockpile_index = -1
	var/budget = 0
	var/parent_structure = null

/datum/tab/withdraw/New(stockpile_param, structure_param)
	. = ..()
	stockpile_index = stockpile_param
	parent_structure = structure_param

/datum/tab/withdraw/proc/get_contents()
	var/contents = "<center>TOWN STOCKPILE<BR>"
	contents += "<a href='?src=[REF(parent_structure)];navigate=directory'>(back)</a><BR>"
	contents += "--------------<BR>"
	contents += "<a href='?src=[REF(parent_structure)];change=1'>Stored Mammon: [budget]</a></center><BR>"

	for(var/datum/roguestock/stockpile/A in SStreasury.stockpile_datums)
		contents += "[A.name]<BR>"
		contents += "[A.desc]<BR>"
		contents += "Stockpiled Amount (Local): [A.held_items[stockpile_index]]<BR>"
		var/remote_stockpile = stockpile_index == 1 ? 2 : 1
		contents += "Stockpiled Amount (Remote): [A.held_items[remote_stockpile]]<BR>"
		if(!A.withdraw_disabled)
			contents += "<a href='?src=[REF(parent_structure)];withdraw=[REF(A)]'>\[Withdraw Local ([A.withdraw_price])\] </a>"
			contents += "<a href='?src=[REF(parent_structure)];withdraw=[REF(A)];remote=1'>\[Withdraw Remote ([A.withdraw_price+A.transport_fee])\]</a><BR><BR>"
		else
			contents += "Withdrawing Disabled...<BR><BR>"
	
	return contents
