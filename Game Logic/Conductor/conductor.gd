extends AudioStreamPlayer
# Made with help of youtube tutorial "Complete Godot Rhythm Game Tutorial" by LegionGames


signal spawn_notes_string
signal suggest_layer_toggle

var song_data: SongData

var song_position: float = 0.0
var song_position_in_beats: int = 0
var sec_per_beat: float = 0.0

# Keep track of all the layers to change audio volume

var arp_muted: bool = false
var allow_arp_toggle: bool = false
var arp_tween: Tween
var arp_volume: float = 1.0:
	set(new_value):
		arp_volume = new_value
		set_audio_volume(1, new_value)

var bass_muted: bool = false
var allow_bass_toggle: bool = false
var bass_tween: Tween
var bass_volume: float = 1.0:
	set(new_value):
		arp_volume = new_value
		set_audio_volume(2, new_value)

var drums_muted: bool = false
var allow_drums_toggle: bool = false
var drums_tween: Tween
var drums_volume: float = 1.0:
	set(new_value):
		arp_volume = new_value
		set_audio_volume(3, new_value)

var lead_muted: bool = false
var allow_lead_toggle: bool = false
var lead_tween: Tween
var lead_volume: float = 1.0:
	set(new_value):
		arp_volume = new_value
		set_audio_volume(4, new_value)

var pad_muted: bool = false
var allow_pad_toggle: bool = false
var pad_tween: Tween
var pad_volume: float = 1.0:
	set(new_value):
		arp_volume = new_value
		set_audio_volume(5, new_value)

@onready var bass_layer = $BassLayer
@onready var drums_layer = $DrumsLayer
@onready var lead_layer = $LeadLayer
@onready var pad_layer = $PadLayer
@onready var layer_toggle_timer = $LayerToggleTimer


func _ready() -> void:
	finished.connect(_on_finished)


func play_song(new_song_data: SongData) -> void:
	if new_song_data is SongData:
		song_data = new_song_data
	else:
		return
	
	Globals.reset_score()
	
	sec_per_beat = 60.0 / song_data.bpm
	Settings.note_speed = sec_per_beat * song_data.note_spawn_beat_offset
	
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
			
			# Check if there should be a layer toggle
			if song_data.layer_toggles.has(song_position_in_beats):
				var layer_to_toggle: int = song_data.layer_toggles.get(song_position_in_beats)
				# Layers are from 1 to 5. Bass, pad, arp, lead, drums
				match layer_to_toggle:
					1:
						allow_bass_toggle = true
					2:
						allow_pad_toggle = true
					3:
						allow_arp_toggle = true
					4:
						allow_lead_toggle = true
					5:
						allow_drums_toggle = true
				suggest_layer_toggle.emit(layer_to_toggle)
				layer_toggle_timer.start()
			
			# Check the note spawn beat offset and spawn notes early to sync the time they need to be hit with the beat
			if song_data.node_spawn_timing.has(song_position_in_beats + song_data.note_spawn_beat_offset):
				spawn_notes_string.emit(song_data.node_spawn_timing.get(song_position_in_beats + song_data.note_spawn_beat_offset))


func toggle_bass(award_points: bool = true) -> bool:
	if not allow_bass_toggle:
		return bass_muted
	allow_bass_toggle = false
	
	if award_points:
		Globals.successful_toggles += 1
	
	bass_muted = !bass_muted
	
	if bass_tween is Tween:
		bass_tween.kill()
	bass_tween = create_tween()
	
	var target_volume: float = 0.0
	if !bass_muted:
		target_volume = 1.0
	
	bass_tween.tween_property(self, "bass_volume", target_volume, 1.0)
	
	return bass_muted


func toggle_pad(award_points: bool = true) -> bool:
	if not allow_pad_toggle:
		return pad_muted
	allow_pad_toggle = false
	
	if award_points:
		Globals.successful_toggles += 1
	
	pad_muted = !pad_muted
	
	if pad_tween is Tween:
		pad_tween.kill()
	pad_tween = create_tween()
	
	var target_volume: float = 0.0
	if !pad_muted:
		target_volume = 1.0
	
	pad_tween.tween_property(self, "pad_volume", target_volume, 1.0)
	
	return pad_muted


func toggle_arp(award_points: bool = true) -> bool:
	if not allow_arp_toggle:
		return arp_muted
	allow_arp_toggle = false
	
	if award_points:
		Globals.successful_toggles += 1
	
	arp_muted = !arp_muted
	
	# Tween the volume change with a duration of how long it takes for notes to spawn and reach the bottom
	if arp_tween is Tween:
		arp_tween.kill()
	arp_tween = create_tween()
	
	var target_volume: float = 0.0
	if !arp_muted:
		target_volume = 1.0
	
	arp_tween.tween_property(self, "arp_volume", target_volume, 1.0)
	
	return arp_muted


func toggle_lead(award_points: bool = true) -> bool:
	if not allow_lead_toggle:
		return lead_muted
	allow_lead_toggle = false
	
	if award_points:
		Globals.successful_toggles += 1
	
	lead_muted = !lead_muted
	
	if lead_tween is Tween:
		lead_tween.kill()
	lead_tween = create_tween()
	
	var target_volume: float = 0.0
	if !lead_muted:
		target_volume = 1.0
	
	lead_tween.tween_property(self, "lead_volume", target_volume, 1.0)
	
	return lead_muted


func set_audio_volume(bus_id: int, value: float) -> void:
	AudioServer.set_bus_volume_db(bus_id, linear_to_db(value))


func _on_layer_toggle_timer_timeout() -> void:
	if allow_arp_toggle:
		toggle_arp(false)
	if allow_bass_toggle:
		toggle_bass(false)
	if allow_pad_toggle:
		toggle_pad(false)
	if allow_lead_toggle:
		toggle_lead(false)
	if allow_drums_toggle:
		# No toggle in the game for drums at the moment
		allow_drums_toggle = false


func _on_finished() -> void:
	UserInterface.show_song_overview()
	#get_tree().change_scene_to_file("res://Scenes/menu.tscn")
