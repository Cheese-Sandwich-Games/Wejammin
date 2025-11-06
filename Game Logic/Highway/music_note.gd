extends Node2D
class_name MusicNote


var move_tween: Tween

@onready var life_timer = $LifeTimer


func initialize(destination_point: Vector2, move_duration: float) -> void:
	# Create a movement tween to gradually move towards a position
	move_tween = create_tween()
	move_tween.tween_property(self, "position", destination_point, move_duration)
	
	# And a timer to destroy the note at the end
	life_timer.start(move_duration)


func _on_life_timer_timeout() -> void:
	# Destroy the note after it reaches the end of the lane
	Globals.combo = 0
	Globals.notes_missed += 1
	print("Note missed")
	queue_free()
