extends Node2D
class_name Lane


const NOTE_ERROR_MARGIN: float = 4.0
const NOTE_HANDLE_MARGIN: float = 20.0

var music_note = preload("res://Game Logic/Highway/music_note.tscn")
var lane_id: int

@onready var current_notes = $Notes
@onready var note_origin = $NoteOrigin
@onready var note_destination = $NoteDestination
@onready var note_hit_area = $NoteDestination/NoteHitArea
@onready var note_hit_animation = $NoteDestination/NoteHitArea/HitAnimation


func _ready() -> void:
	# Get a reference to which lane this is
	lane_id = get_index() + 1


func _input(event: InputEvent) -> void:
	# Button assigned to this lane
	if event.is_action_pressed("lane_%s" % lane_id):
		# Get the note added first to this lane (if any exist)
		for note in current_notes.get_children():
			if note is MusicNote:
				_handle_note_hit(note)
			break
		
		# Play a hit animation
		note_hit_animation.stop()
		note_hit_animation.play("hit")


func _handle_note_hit(note: MusicNote) -> void:
	var overlapping_notes: Array[Area2D] = note_hit_area.get_overlapping_areas()
	
	# Check if the note has been hit or not and update score and combo
	if overlapping_notes.has(note):
		if note.global_position.distance_to(note_hit_area.global_position) <= NOTE_ERROR_MARGIN:
			# Note has been perfectly hit
			note.handle(true, true)
		else:
			note.handle(true, false)
	else:
		if note.global_position.distance_to(note_hit_area.global_position) <= NOTE_HANDLE_MARGIN:
			# Note has been missed
			note.handle(false)


func spawn_note() -> void:
	# Add a note to this lane
	var note_instance = music_note.instantiate() as MusicNote
	current_notes.add_child(note_instance)
	
	# Give the note the destination point and move duration
	note_instance.initialize(note_destination.position, Settings.note_speed)


func clear_notes() -> void:
	for child in current_notes.get_children():
		child.queue_free()
