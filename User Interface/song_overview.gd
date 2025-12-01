extends Control


@onready var score_label = $MarginContainer/VBoxContainer/ScoreLabel
@onready var highest_combo_label = $MarginContainer/VBoxContainer/HighestComboLabel
@onready var notes_hit_label = $MarginContainer/VBoxContainer/NotesHitLabel
@onready var perfect_hits_label = $MarginContainer/VBoxContainer/PerfectHitsLabel
@onready var successful_toggles_label = $MarginContainer/VBoxContainer/SuccessfulTogglesLabel


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
	hide()


func show_results() -> void:
	score_label.text = "Rating: %s" % Globals.calculate_ratings()
	highest_combo_label.text = "Highest Combo: %s" % Globals.highest_combo
	notes_hit_label.text = "Notes hit: %s/%s" % [Globals.good_hits + Globals.perfect_hits, Globals.good_hits + Globals.perfect_hits + Globals.notes_missed]
	perfect_hits_label.text = "Perfect Hits: %s" % Globals.perfect_hits
	successful_toggles_label.text = "Followed audience %s times!" % Globals.successful_toggles
	show()
