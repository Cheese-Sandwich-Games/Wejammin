extends Control


@onready var ratings_label = $NinePatchRect/MarginContainer/VBoxContainer/RatingsLabel
@onready var score_label = $NinePatchRect/MarginContainer/VBoxContainer/ScoreLabel
@onready var combo_label = $NinePatchRect/MarginContainer/VBoxContainer/ComboLabel


func _ready() -> void:
	Globals.combo_changed.connect(_on_combo_changed)
	Globals.perfect_hit.connect(_on_note_hit)
	Globals.good_hit.connect(_on_note_hit)


func _on_combo_changed(new_combo: int) -> void:
	combo_label.text = "Combo %s" % new_combo
	ratings_label.text = "Ratings %s" % calculate_ratings()


func _on_note_hit() -> void:
	score_label.text = "Notes hit %s" % (Globals.notes_hit)
	ratings_label.text = "Ratings %s" % calculate_ratings()


func calculate_ratings() -> int:
	return Globals.combo + Globals.perfect_hits * 2 + Globals.good_hits
