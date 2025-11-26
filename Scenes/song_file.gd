extends TextureRect


@export var song_name: String = "Song name"
@export var song_data: SongData

@onready var name_label = $NameLabel


func _ready() -> void:
	name_label.text = song_name


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.double_click and event.button_index == MOUSE_BUTTON_LEFT:
			Conductor.play_song()
			get_tree().change_scene_to_file("res://Scenes/main.tscn")
