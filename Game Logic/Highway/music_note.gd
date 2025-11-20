extends Node2D
class_name MusicNote


const MOVE_BUFFER: float = 0.06

var move_tween: Tween

@onready var life_timer = $LifeTimer


func initialize(destination_point: Vector2, move_duration: float) -> void:
	# Add a little buffer at the end where the note keeps going
	var move_duration_with_buffer = move_duration * (1 + MOVE_BUFFER)
	var destination_point_with_buffer = (destination_point - position) * (1 + MOVE_BUFFER)
	
	# Create a movement tween to gradually move towards a position
	move_tween = create_tween()
	move_tween.tween_property(self, "position", destination_point_with_buffer, move_duration_with_buffer)
	
	# And a timer to destroy the note at the end
	life_timer.start(move_duration_with_buffer)


func handle(is_hit: bool, is_perfect: bool = false) -> void:
	if is_hit:
		Globals.combo += 1
		Globals.notes_hit += 1
		if is_perfect:
			Globals.perfect_hits += 1
			print("Note perfect hit")
		else:
			Globals.good_hits += 1
			print("Note good hit")
	else:
		Globals.combo = 0
		Globals.notes_missed += 1
		print("Note missed")
	
	print("Combo: ", Globals.combo, " Notes hit: ", Globals.notes_hit, " Notes missed: ", Globals.notes_missed, " Perfect notes: ", Globals.perfect_hits, " Good notes: ", Globals.good_hits)
	
	# Delete a note that has been handled
	queue_free()


func _on_life_timer_timeout() -> void:
	# Destroy the note after it reaches the end of the lane
	handle(false)
