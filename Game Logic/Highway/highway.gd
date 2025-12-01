extends Node2D
class_name Highway


@onready var lanes = $Lanes


func _ready() -> void:
	Conductor.spawn_notes_string.connect(_on_notes_spawned)


func spawn_notes_string(notes_binary: String) -> void:
	var lane_number: int = 1
	for note in notes_binary:
		# A 1 on the binary string means a note
		if note == "1":
			# Get the given lane and add a note to it
			var lane: Node = lanes.get_child(lane_number - 1)
			
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
	for child in lanes.get_children():
		if child is Lane:
			child.clear_notes()


func _on_notes_spawned(notes_string: String) -> void:
	spawn_notes_string(notes_string)
