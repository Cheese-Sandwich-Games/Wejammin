extends Node2D
class_name PauseComponent
signal pause_pressed
signal game_paused
signal game_unpaused

@export var pause_menu :PauseMenu
# Called when the node enters the scene tree for the first time.
func _ready():
	pause_pressed.connect(_on_pause_pressed)
	if pause_menu:
		pause_menu.continue_pressed.connect(_on_continue_game_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _unhandled_input(event):
	if event.is_action_pressed("Pause"):
		pause_pressed.emit()


func _on_pause_pressed():
	if Engine.time_scale != 0.0 && Globals.is_game_running:
		pause_game()
	else:
		unpause_game()
		
		
		
func pause_game():
	Engine.time_scale = 0.0
	Globals.is_game_running = false
	game_paused.emit()
	if pause_menu:
		pause_menu.show()
func unpause_game():
	Engine.time_scale = 1.0
	Globals.is_game_running = true
	game_unpaused.emit()
	if pause_menu:
		pause_menu.hide()

func _on_continue_game_pressed():
	unpause_game()
