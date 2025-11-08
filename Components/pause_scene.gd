extends Node2D

@export var pause_menu :PauseMenu
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pause_component_game_paused():
	pause_menu.show()
	Globals.is_game_running = false

func _on_pause_component_game_unpaused():
	pause_menu.hide()
	Globals.is_game_running = true

func _on_pause_menu_continue_pressed():
	pause_menu.hide()
	Globals.is_game_running = true
