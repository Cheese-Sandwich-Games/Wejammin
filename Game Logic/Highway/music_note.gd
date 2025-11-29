extends Node2D
class_name MusicNote


const MOVE_BUFFER: float = 0.06

var move_tween: Tween
var is_hitted: bool = false

@onready var life_timer = $LifeTimer
@onready var perfect_hit_sound = $PerfectHitSound

@export var perfect_particle_emitter: GPUParticles2D
#@export var good_particle_emitter: GPUParticles2D

@export var sprite_ref: Sprite2D

@export var note_fail_audio: AudioStream
@export var boo_audio: AudioStream


func initialize(destination_point: Vector2, move_duration: float) -> void:
	# Add a little buffer at the end where the note keeps going
	var move_duration_with_buffer = move_duration * (1 + MOVE_BUFFER)
	var destination_point_with_buffer = (destination_point - position) * (1 + MOVE_BUFFER)
	
	# Create a movement tween to gradually move towards a position
	move_tween = create_tween()
	move_tween.tween_property(self, "position", destination_point_with_buffer, move_duration_with_buffer)
	
	# And a timer to destroy the note at the end
	life_timer.start(move_duration_with_buffer)


func handle(is_hit: bool, is_perfect: bool = false) -> void:
	if is_hit:
		Globals.combo += 1
		Globals.notes_hit += 1
		if is_perfect && !is_hitted:
			is_hitted = true
			Globals.perfect_hits += 1
			print("Note perfect hit")
			perfect_particle_emitter.emitting = true
			sprite_ref.hide()
			reparent(get_parent().get_parent())
			# Remove perfect hit sound for now
			#perfect_hit_sound.play()
			await perfect_particle_emitter.finished
		elif !is_hitted:
			is_hitted = true
			Globals.good_hits += 1
			print("Note good hit")
			#good_particle_emitter.emitting = true
			#sprite_ref.hide()
			#await good_particle_emitter.finished
	else:
		# When already on 0 combo play boo audio
		if Globals.combo == 0:
			SoundEffectPlayer.play_sound(boo_audio)
		Globals.combo = 0
		Globals.notes_missed += 1
		SoundEffectPlayer.play_sound(note_fail_audio)
		print("Note missed")

	print("Combo: ", Globals.combo, " Notes hit: ", Globals.notes_hit, " Notes missed: ", Globals.notes_missed, " Perfect notes: ", Globals.perfect_hits, " Good notes: ", Globals.good_hits)
	
	# Delete a note that has been handled
	queue_free()


func _on_life_timer_timeout() -> void:
	# Destroy the note after it reaches the end of the lane
	if is_hitted:
		return
	handle(false)
