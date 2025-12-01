extends Node
# For globally accessable variable and functions


signal combo_changed
signal good_hit
signal perfect_hit
signal successful_toggle
signal lane_action

# Current music track statistics. Move this somewhere else if needed
var combo: int:
	set(new_value):
		if new_value > combo:
			highest_combo = new_value
		combo = new_value
		combo_changed.emit(new_value)
var highest_combo: int
var notes_hit: int
var notes_missed: int
var good_hits: int:
	set(new_value):
		if new_value > good_hits:
			good_hit.emit()
		good_hits = new_value
var perfect_hits: int:
	set(new_value):
		if new_value > perfect_hits:
			perfect_hit.emit()
		perfect_hits = new_value
var successful_toggles: int = 0:
	set(new_value):
		if new_value > successful_toggles:
			successful_toggle.emit()
		successful_toggles = new_value
var consecutive_misses: int = 0
var last_note_hit: bool = false
var last_lane_hit: int = 0:
	set(new_value):
		last_lane_hit = new_value
		lane_action.emit(new_value, last_note_hit)


func reset_score() -> void:
	combo = 0
	notes_hit = 0
	notes_missed = 0
	good_hits = 0
	perfect_hits = 0
	successful_toggles = 0


func calculate_ratings() -> int:
	return combo + perfect_hits * 2 + good_hits + successful_toggles * 20
