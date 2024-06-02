function update_timer(new_time) {
	document.getElementById('queue_timer').innerHTML = new_time; 
}

function update_playersegments(new_count, list) {
	document.getElementById('current_count').innerHTML = new_count;
	document.getElementById('player_table').innerHTML = list;
}
