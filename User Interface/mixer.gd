extends Control


@export var cheering_audio: AudioStream

@onready var bass_slider = $HBoxContainer/BassSlider
@onready var pad_slider = $HBoxContainer/PadSlider
@onready var arp_slider = $HBoxContainer/ArpSlider
@onready var lead_slider = $HBoxContainer/LeadSlider
@onready var bass_toggle_indicator = $HBoxContainer/BassSlider/ToggleIndicator
@onready var pad_toggle_indicator = $HBoxContainer/PadSlider/ToggleIndicator
@onready var arp_toggle_indicator = $HBoxContainer/ArpSlider/ToggleIndicator
@onready var lead_toggle_indicator = $HBoxContainer/LeadSlider/ToggleIndicator
@onready var layer_toggle_timer = $LayerToggleTimer


func _ready() -> void:
	Conductor.suggest_layer_toggle.connect(_on_suggest_layer_toggle)


func _on_suggest_layer_toggle(layer_to_toggle: int) -> void:
	# Layers are from 1 to 5. Bass, pad, arp, lead, drums
	var layers: Array[String] = ["", "bass", "pad", "arp", "lead", "drums"]
	print("Please toggle ", layers[layer_to_toggle])
	layer_toggle_timer.start()
	SoundEffectPlayer.play_sound(cheering_audio)
	match layer_to_toggle:
		1:
			bass_toggle_indicator.show()
		2:
			pad_toggle_indicator.show()
		3:
			arp_toggle_indicator.show()
		4:
			lead_toggle_indicator.show()
		5:
			print("No mixer button for drums added yet")


func _on_bass_slider_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			toggle_bass()


func _on_pad_slider_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			toggle_pad()


func _on_arp_slider_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			toggle_arp()


func _on_lead_slider_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			toggle_lead()


func toggle_bass() -> void:
	var new_status: bool = Conductor.toggle_bass()
	var slider_texture: AtlasTexture = bass_slider.texture
	if new_status:
		slider_texture.region.position.x = 0
	else:
		slider_texture.region.position.x = 150
	bass_toggle_indicator.hide()


func toggle_pad() -> void:
	var new_status: bool = Conductor.toggle_pad()
	var slider_texture: AtlasTexture = pad_slider.texture
	if new_status:
		slider_texture.region.position.x = 0
	else:
		slider_texture.region.position.x = 150
	pad_toggle_indicator.hide()


func toggle_arp() -> void:
	var new_status: bool = Conductor.toggle_arp()
	var slider_texture: AtlasTexture = arp_slider.texture
	if new_status:
		slider_texture.region.position.x = 0
	else:
		slider_texture.region.position.x = 150
	arp_toggle_indicator.hide()


func toggle_lead() -> void:
	var new_status: bool = Conductor.toggle_lead()
	var slider_texture: AtlasTexture = lead_slider.texture
	if new_status:
		slider_texture.region.position.x = 0
	else:
		slider_texture.region.position.x = 150
	lead_toggle_indicator.hide()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_arp"):
		toggle_arp()
	elif event.is_action_pressed("toggle_bass"):
		toggle_bass()
	elif event.is_action_pressed("toggle_pad"):
		toggle_pad()
	elif event.is_action_pressed("toggle_lead"):
		toggle_lead()


func _on_layer_toggle_timer_timeout() -> void:
	toggle_arp()
	arp_toggle_indicator.hide()
	toggle_pad()
	pad_toggle_indicator.hide()
	toggle_bass()
	bass_toggle_indicator.hide()
	toggle_lead()
	lead_toggle_indicator.hide()
