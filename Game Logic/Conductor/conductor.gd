extends AudioStreamPlayer
# Made with help of youtube tutorial "Complete Godot Rhythm Game Tutorial" by LegionGames


@export var song_data: SongData
@export var highway: Highway

var song_position: float = 0.0
var song_position_in_beats: int = 0
var sec_per_beat: float = 0.0


func _ready() -> void:
	sec_per_beat = 60.0 / song_data.bpm
	Settings.note_speed = sec_per_beat * 4
	
	play_song()


func play_song() -> void:
	stream = song_data.arp_layer
	if !playing: play()


func _physics_process(_delta: float) -> void:
	if playing:
		# Keep track of the songs position
		song_position = get_playback_position() + AudioServer.get_time_since_last_mix()
		song_position -= AudioServer.get_output_latency()
		var new_position_in_beats: int = int(floor(song_position / sec_per_beat))
		
		# When moving onto the next beat of the song emit a signal to spawn notes
		if new_position_in_beats != song_position_in_beats:
			song_position_in_beats = new_position_in_beats
			
			if song_data.node_spawn_timing.has(song_position_in_beats):
				highway.spawn_notes_string(song_data.node_spawn_timing.get(song_position_in_beats))
