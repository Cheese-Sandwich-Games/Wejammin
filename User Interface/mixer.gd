extends Control


@onready var bass_slider = $HBoxContainer/BassSlider
@onready var pad_slider = $HBoxContainer/PadSlider
@onready var arp_slider = $HBoxContainer/ArpSlider
@onready var lead_slider = $HBoxContainer/LeadSlider


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


func toggle_pad() -> void:
	var new_status: bool = Conductor.toggle_pad()
	var slider_texture: AtlasTexture = pad_slider.texture
	if new_status:
		slider_texture.region.position.x = 0
	else:
		slider_texture.region.position.x = 150


func toggle_arp() -> void:
	var new_status: bool = Conductor.toggle_arp()
	var slider_texture: AtlasTexture = arp_slider.texture
	if new_status:
		slider_texture.region.position.x = 0
	else:
		slider_texture.region.position.x = 150


func toggle_lead() -> void:
	var new_status: bool = Conductor.toggle_lead()
	var slider_texture: AtlasTexture = lead_slider.texture
	if new_status:
		slider_texture.region.position.x = 0
	else:
		slider_texture.region.position.x = 150


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_arp"):
		toggle_arp()
	elif event.is_action_pressed("toggle_bass"):
		toggle_bass()
	elif event.is_action_pressed("toggle_pad"):
		toggle_pad()
	elif event.is_action_pressed("toggle_lead"):
		toggle_lead()
