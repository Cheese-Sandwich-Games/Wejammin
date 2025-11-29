extends Control


@onready var animated_sprite = $AnimatedSprite2D


func _ready() -> void:
	Globals.lane_action.connect(_on_lane_action)


func _on_lane_action(lane_id: int, note_hit: bool) -> void:
	var hit_or_miss = "miss"
	if note_hit:
		hit_or_miss = "hit"
	animated_sprite.play("%s_%s" % [hit_or_miss, lane_id])
