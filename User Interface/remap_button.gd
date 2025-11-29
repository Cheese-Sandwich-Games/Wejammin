extends Button


@export var remapping_action: String = ""

var remapping: bool = false


func _ready() -> void:
	pressed.connect(_on_pressed)
	text = remapping_action + " - " + InputMap.action_get_events(remapping_action).get(0).as_text()


func _on_pressed() -> void:
	remapping = true
	text = "Press new button"


func _input(event: InputEvent) -> void:
	if remapping:
		if event is InputEventKey:
			InputMap.action_erase_events(remapping_action)
			InputMap.action_add_event(remapping_action, event)
			
			text = remapping_action + " - " + event.as_text()
			
			remapping = false
