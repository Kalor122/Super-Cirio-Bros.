extends Marker2D
class_name PelletExit

@export var look_at_mouse: bool = true

func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
