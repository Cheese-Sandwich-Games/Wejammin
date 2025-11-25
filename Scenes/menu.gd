extends Node2D


func _on_start_button_pressed() -> void:
	Conductor.play_song()
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
	
