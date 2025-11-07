extends Node2D
class_name Highway


func spawn_notes_string(notes_binary: String) -> void:
	var lane_number: int = 1
	for note in notes_binary:
		# A 1 on the binary string means a note
		if note == "1":
			# Get the given lane and add a note to it
			var lane: Node = get_child(lane_number - 1)
			
			# Verify the lane number is valid before trying to spawn the note
			if lane is Lane:
				lane.spawn_note()
		lane_number += 1


func spawn_notes_int(notes_binary: int) -> void:
	# Convert the number to a binary string to use for spawning notes on the highway
	var notes_string: String = String.num_int64(clampi(notes_binary, 0, 15), 2)
	while notes_string.length() < 4:
		notes_string = "0" + notes_string
	spawn_notes_string(notes_string)


func clear_notes() -> void:
	for child in get_children():
		if child is Lane:
			child.clear_notes()
