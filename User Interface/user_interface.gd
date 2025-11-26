extends CanvasLayer


@onready var settings_window = $SettingsWindow
@onready var song_overview = $SongOverview


func show_settings() -> void:
	settings_window.visible = !settings_window.visible


func show_song_overview() -> void:
	song_overview.show_results()
