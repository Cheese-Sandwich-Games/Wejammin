extends Node2D
class_name Lane


var music_note = preload("res://Game Logic/Highway/music_note.tscn")
var lane_id: int

@onready var current_notes = $Notes
@onready var note_origin = $NoteOrigin
@onready var note_destination = $NoteDestination
@onready var note_hit_area = $NoteHitArea


func _ready() -> void:
	# Get a reference to which lane this is
	lane_id = get_index() + 1


func _input(event: InputEvent) -> void:
	# Button assigned to this lane
	if event.is_action_pressed("lane_%s" % lane_id):
		# Get the note added first to this lane (if any exist)
		for note in current_notes.get_children():
			var overlapping_notes: Array = note_hit_area.get_overlapping_areas()
			
			# Check if the note has been hit or not and give score. Then remove the note
			if overlapping_notes.has(note):
				Globals.combo += 1
				Globals.notes_hit += 1
				print("Note hit")
			else:
				Globals.combo = 0
				Globals.notes_missed += 1
				print("Note missed")
			note.queue_free()


func spawn_note() -> void:
	# Add a note to this lane
	var note_instance = music_note.instantiate() as MusicNote
	current_notes.add_child(note_instance)
	
	# Give the note the destination point and move duration
	note_instance.initialize(note_destination.position, Settings.note_speed)


func clear_notes() -> void:
	for child in current_notes.get_children():
		child.queue_free()
