extends Control


@onready var ratings_label = $NinePatchRect/MarginContainer/VBoxContainer/RatingsLabel
@onready var score_label = $NinePatchRect/MarginContainer/VBoxContainer/ScoreLabel
@onready var combo_label = $NinePatchRect/MarginContainer/VBoxContainer/ComboLabel


func _ready() -> void:
	Globals.combo_changed.connect(_on_combo_changed)
	Globals.perfect_hit.connect(_on_note_hit)
	Globals.good_hit.connect(_on_note_hit)
	Globals.successful_toggle.connect(_on_successful_toggle)


func _on_combo_changed(new_combo: int) -> void:
	# Await 1 frame for the ratings to be properly updated and avoid inconsistent signal handling order
	await get_tree().process_frame
	
	combo_label.text = "Combo %s" % new_combo
	score_label.text = "Notes hit %s / %s" % [Globals.notes_hit, Globals.notes_hit + Globals.notes_missed]
	ratings_label.text = "Ratings %s" % Globals.calculate_ratings()


func _on_note_hit() -> void:
	await get_tree().process_frame
	
	score_label.text = "Notes hit %s / %s" % [Globals.notes_hit, Globals.notes_hit + Globals.notes_missed]
	ratings_label.text = "Ratings %s" % Globals.calculate_ratings()


func _on_successful_toggle() -> void:
	await get_tree().process_frame
	
	ratings_label.text = "Ratings %s" % Globals.calculate_ratings()
