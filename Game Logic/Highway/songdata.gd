extends Resource
class_name SongData


## The lowest beat nodes can be spawned is above the note spawn beat offset
@export var node_spawn_timing: Dictionary[int, String]
## Layers are from 1 to 5. Bass, pad, arp, lead, drums
@export var layer_toggles: Dictionary[int, int]
@export var bpm: int = 135
@export var note_spawn_beat_offset: int = 8

@export var arp_layer: AudioStream
@export var bass_layer: AudioStream
@export var drums_layer: AudioStream
@export var lead_layer: AudioStream
@export var pad_layer: AudioStream
