extends Node
class_name GhostComponent

var parent: Node2D

@export var rate: float = 0.05
@export var fade_duration_scale: float = 5
@export var shader: ShaderMaterial

const GHOST_THING = preload("uid://dior12b5osyn3")

func _ready() -> void:
	parent = get_parent()
	var t = Timer.new()
	add_child(t)
	t.start(rate)
	t.timeout.connect(_timeout)

func _timeout():
	if parent is Sprite2D:
		var s = GHOST_THING.instantiate()
		s.material = shader
		s.global_position = parent.global_position
		s.global_rotation = parent.global_rotation
		s.global_scale = parent.global_scale
		s.global_skew = parent.global_skew
		get_tree().current_scene.add_child(s)
		s.animation_player.speed_scale = fade_duration_scale
		s.texture = parent.texture
