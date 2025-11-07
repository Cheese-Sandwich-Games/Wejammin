extends AudioStreamPlayer
# Made with help of youtube tutorial "Complete Godot Rhythm Game Tutorial" by LegionGames


@export var song_data: SongData
@export var highway: Highway

var song_position: float = 0.0
var song_position_in_beats: int = 0
var sec_per_beat: float = 0.0

# Keep track of all the layers to change audio volume

var arp_muted: bool = false
var arp_tween: Tween
var arp_volume: float = 1.0:
	set(new_value):
		arp_volume = new_value
		set_audio_volume(1, new_value)

var bass_muted: bool = false
var bass_tween: Tween
var bass_volume: float = 1.0:
	set(new_value):
		arp_volume = new_value
		set_audio_volume(2, new_value)

var drums_muted: bool = false
var drums_tween: Tween
var drums_volume: float = 1.0:
	set(new_value):
		arp_volume = new_value
		set_audio_volume(3, new_value)

var lead_muted: bool = false
var lead_tween: Tween
var lead_volume: float = 1.0:
	set(new_value):
		arp_volume = new_value
		set_audio_volume(4, new_value)

var pad_muted: bool = false
var pad_tween: Tween
var pad_volume: float = 1.0:
	set(new_value):
		arp_volume = new_value
		set_audio_volume(5, new_value)

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
		arp_muted = !arp_muted
		
		# Tween the volume change with a duration of how long it takes for notes to spawn and reach the bottom
		if arp_tween is Tween:
			arp_tween.kill()
		arp_tween = create_tween()
		
		var target_volume: float = 0.0
		if !arp_muted:
			target_volume = 1.0
		
		arp_tween.tween_property(self, "arp_volume", target_volume, Settings.note_speed)
	elif event.is_action_pressed("toggle_bass"):
		bass_muted = !bass_muted
		
		if bass_tween is Tween:
			bass_tween.kill()
		bass_tween = create_tween()
		
		var target_volume: float = 0.0
		if !bass_muted:
			target_volume = 1.0
		
		bass_tween.tween_property(self, "bass_volume", target_volume, Settings.note_speed)
	elif event.is_action_pressed("toggle_drums"):
		drums_muted = !drums_muted
		
		if drums_tween is Tween:
			drums_tween.kill()
		drums_tween = create_tween()
		
		var target_volume: float = 0.0
		if !drums_muted:
			target_volume = 1.0
		
		drums_tween.tween_property(self, "drums_volume", target_volume, Settings.note_speed)
	elif event.is_action_pressed("toggle_lead"):
		lead_muted = !lead_muted
		
		if lead_tween is Tween:
			lead_tween.kill()
		lead_tween = create_tween()
		
		var target_volume: float = 0.0
		if !lead_muted:
			target_volume = 1.0
		
		lead_tween.tween_property(self, "lead_volume", target_volume, Settings.note_speed)
	elif event.is_action_pressed("toggle_pad"):
		pad_muted = !pad_muted
		
		if pad_tween is Tween:
			pad_tween.kill()
		pad_tween = create_tween()
		
		var target_volume: float = 0.0
		if !pad_muted:
			target_volume = 1.0
		
		pad_tween.tween_property(self, "pad_volume", target_volume, Settings.note_speed)


func set_audio_volume(bus_id: int, value: float) -> void:
	AudioServer.set_bus_volume_db(bus_id, linear_to_db(value))
