extends Resource
class_name SongData


@export var node_spawn_timing: Dictionary[int, String]
@export var bpm: int = 135

@export var arp_layer: AudioStream
@export var bass_layer: AudioStream
@export var drums_layer: AudioStream
@export var lead_layer: AudioStream
@export var pad_layer: AudioStream
