extends AudioStreamPlayer


func _ready() -> void:
	play()


func play_sound(sfx: AudioStream) -> void:
	var playback = get_stream_playback()
	if playback is AudioStreamPlaybackPolyphonic:
		playback.play_stream(sfx, 0, 0, 1.0, 0, &"sfx")
