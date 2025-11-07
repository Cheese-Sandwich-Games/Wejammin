extends Node
# For globally accessable variable and functions


signal combo_changed
signal good_hit
signal perfect_hit

# Current music track statistics. Move this somewhere else if needed
var combo: int:
	set(new_value):
		combo = new_value
		combo_changed.emit(new_value)
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
