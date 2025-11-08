extends Node2D

@export var pause_menu :PauseMenu
# Called when the node enters the scene tree for the first time.
func _ready():
	if pause_menu:
		pause_menu.quit_game_pressed.connect(_on_superquit_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_superquit_pressed():
	get_tree().quit()
