extends Camera2D
class_name RoomCamera

@export var cirio: Cirio

func _ready() -> void:
	cirio = Globals.current_cirio


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if cirio:
		global_position = cirio.global_position
