extends Control


@onready var request_label = $TextureRect/RequestLabel

var fade_tween: Tween


func _ready() -> void:
	Conductor.suggest_layer_toggle.connect(_on_suggest_layer_toggle)


func _on_suggest_layer_toggle(layer_to_toggle: int) -> void:
	# Layers are from 1 to 5. Bass, pad, arp, lead, drums
	var layers: Array[String] = ["", "bass", "pad", "arp", "lead", "drums"]
	request_label.text = "Please toggle %s" % layers[layer_to_toggle]
	
	# Add a fading message on the audience
	if fade_tween is Tween:
		fade_tween.kill()
	
	fade_tween = create_tween().set_parallel()
	
	# Set starting values for animation
	request_label.modulate = Color(1.0, 1.0, 1.0, 1.0)
	
	fade_tween.tween_property(request_label, "modulate", Color(1.0, 1.0, 1.0, 0), 5.0)
