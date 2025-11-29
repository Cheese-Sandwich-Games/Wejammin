extends HSlider


@export var bus_name: String = ""
@export var audio_cue: AudioStream

var bus_index: int


func _ready() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
	value_changed.connect(_on_value_changed)
	drag_ended.connect(_on_drag_ended)
	value = AudioServer.get_bus_volume_db(bus_index)


func _on_value_changed(new_value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(new_value))


func _on_drag_ended(_value_changed: bool) -> void:
	if audio_cue is AudioStream:
		SoundEffectPlayer.play_sound(audio_cue)
