extends TextureRect


var bounce_tween: Tween


func _ready() -> void:
	Globals.good_hit.connect(_on_good_hit)
	Globals.perfect_hit.connect(_on_perfect_hit)


func show_hit(is_perfect: bool) -> void:
	if texture is AtlasTexture:
		if is_perfect:
			texture.region = Rect2(Vector2(texture.region.size.x, 0), texture.region.size)
		else:
			texture.region = Rect2(Vector2(0, 0), texture.region.size)
	
	# Add a little movement to the texture
	if bounce_tween is Tween:
		bounce_tween.kill()
	
	bounce_tween = create_tween().set_parallel()
	
	# Set starting values for animation
	var random_scale: float = randf_range(1.3, 1.4)
	scale = Vector2(random_scale, random_scale)
	rotation_degrees = randf_range(15, 15)
	modulate.a = 1.0
	
	bounce_tween.tween_property(self, "scale", Vector2(1, 1), 0.3)
	bounce_tween.tween_property(self, "rotation_degrees", 0, 0.3)
	bounce_tween.tween_property(self, "modulate", Color(1.0, 1.0, 1.0, 0), 0.5)


func _on_good_hit() -> void:
	show_hit(false)


func _on_perfect_hit() -> void:
	show_hit(true)
