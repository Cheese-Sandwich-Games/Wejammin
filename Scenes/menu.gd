extends Node2D


func _on_settings_file_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.double_click and event.button_index == MOUSE_BUTTON_LEFT:
			UserInterface.show_settings()
