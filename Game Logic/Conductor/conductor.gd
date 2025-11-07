extends AudioStreamPlayer
# Made with help of youtube tutorial "Complete Godot Rhythm Game Tutorial" by LegionGames


@export var song_data: SongData
@export var highway: Highway

var song_position: float = 0.0
var song_position_in_beats: int = 0
var sec_per_beat: float = 0.0

@onready var bass_layer = $BassLayer
@onready var drums_layer = $DrumsLayer
@onready var lead_layer = $LeadLayer
@onready var pad_layer = $PadLayer


func _ready() -> void:
	sec_per_beat = 60.0 / song_data.bpm
	Settings.note_speed = sec_per_beat * song_data.note_spawn_beat_offset
	
	play_song()


func play_song() -> void:
	# Use one of the layers (arp) to keep track of music progress here
	stream = song_data.arp_layer
	if not playing: play()
	
	# Play all other layers at the same time to have the music synced
	bass_layer.stream = song_data.bass_layer
	if not bass_layer.playing: bass_layer.play()
	
	drums_layer.stream = song_data.drums_layer
	if not drums_layer.playing: drums_layer.play()
	
	lead_layer.stream = song_data.lead_layer
	if not lead_layer.playing: lead_layer.play()
	
	pad_layer.stream = song_data.pad_layer
	if not pad_layer.playing: pad_layer.play()


func _physics_process(_delta: float) -> void:
	if playing:
		# Keep track of the songs position
		song_position = get_playback_position() + AudioServer.get_time_since_last_mix()
		song_position -= AudioServer.get_output_latency()
		var new_position_in_beats: int = floori(song_position / sec_per_beat)
		
		# When moving onto the next beat of the song spawn notes
		if new_position_in_beats != song_position_in_beats:
			song_position_in_beats = new_position_in_beats
			
			# Check the note spawn beat offset and spawn notes early to sync the time they need to be hit with the beat
			if song_data.node_spawn_timing.has(song_position_in_beats + song_data.note_spawn_beat_offset):
				highway.spawn_notes_string(song_data.node_spawn_timing.get(song_position_in_beats + song_data.note_spawn_beat_offset))


func _input(event: InputEvent) -> void:
	# Allow toggling on or off all the different layers of the song
	if event.is_action_pressed("toggle_arp"):
		toggle_audio_bus(1)
	elif event.is_action_pressed("toggle_bass"):
		toggle_audio_bus(2)
	elif event.is_action_pressed("toggle_drums"):
		toggle_audio_bus(3)
	elif event.is_action_pressed("toggle_lead"):
		toggle_audio_bus(4)
	elif event.is_action_pressed("toggle_pad"):
		toggle_audio_bus(5)


func toggle_audio_bus(bus_id: int) -> void:
	var current_mute_status: bool = AudioServer.is_bus_mute(bus_id)
	AudioServer.set_bus_mute(bus_id, !current_mute_status)
