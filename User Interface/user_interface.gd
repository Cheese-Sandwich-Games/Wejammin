extends CanvasLayer


signal transition_finished

@onready var settings_window = $SettingsWindow
@onready var song_overview = $SongOverview
@onready var animation_player = $AnimationPlayer


func show_settings() -> void:
	settings_window.visible = !settings_window.visible


func show_song_overview() -> void:
	song_overview.show_results()


func play_transition() -> void:
	animation_player.play("transition")
	await animation_player.animation_finished
	transition_finished.emit()
