extends Control



signal quit_game_pressed
signal start_game_pressed
signal settings_pressed
@export_group("Buttons")
@export var quit_button: Button
@export var start_game_button: Button
@export var settings_button: Button

func _ready():
	quit_button.pressed.connect(_on_quit_game_pressed)
	start_game_button.pressed.connect(_on_start_game_pressed)
	settings_button.pressed.connect(_on_settings_pressed)


func _on_quit_game_pressed():
	_on_any_button_pressed()
	quit_game_pressed.emit()
	
	
func _on_start_game_pressed():
	_on_any_button_pressed()
	start_game_pressed.emit()
	
	
func _on_settings_pressed():
	_on_any_button_pressed()
	settings_pressed.emit()
	
	
func _on_any_button_pressed():
	pass
