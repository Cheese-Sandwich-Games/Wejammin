extends Control
class_name PauseMenu

signal continue_pressed
signal button_pressed
signal settings_pressed
signal quit_game_pressed
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_superquit_pressed():
	button_pressed.emit()
	quit_game_pressed.emit()

func _on_settings_pressed():
	button_pressed.emit()
	settings_pressed.emit()


func _on_continue_pressed():
	button_pressed.emit()
	continue_pressed.emit()
