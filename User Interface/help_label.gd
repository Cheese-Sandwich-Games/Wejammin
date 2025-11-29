extends Label


func _ready() -> void:
	text = "%s  %s   %s  %s" % [InputMap.action_get_events("lane_1").get(0).as_text(),
	InputMap.action_get_events("lane_2").get(0).as_text(),
	InputMap.action_get_events("lane_3").get(0).as_text(),
	InputMap.action_get_events("lane_4").get(0).as_text()]
