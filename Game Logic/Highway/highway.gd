extends Node2D
class_name Highway


@export var spawn_data: CurveTexture


func spawn_note(lane_number: int) -> void:
	# Get the given lane and add a note to it
	var lane: Node = get_child(lane_number - 1)
	
	# Verify the lane number is valid before trying to spawn the note
	if lane is Lane:
		lane.spawn_note()
