extends Node2D
class_name Lane


var music_note = preload("res://Game Logic/Highway/music_note.tscn")

@onready var current_notes = $Notes
@onready var note_origin = $NoteOrigin
@onready var note_destination = $NoteDestination


func spawn_note() -> void:
	# Add a note to this lane
	var note_instance = music_note.instantiate()
	current_notes.add_child(note_instance)
