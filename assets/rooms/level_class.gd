extends Node2D
class_name Level

@export var zone: Zone
@export var cursor: Marker2D
@export var camera: RoomCamera
@export var background: PackedScene

var current_room: Room
var start_room: Room
var level_length: int = 50

func _generate_rooms():
	var sr = load(zone.starting_room).instantiate() as Room
	add_child(sr)
	start_room = sr
	current_room = sr
	cursor.global_position = sr.exit_point.global_position + Vector2(256, 0)
	for i in range(level_length - 1):
		var r
		r = load(zone.rooms[Globals.rng.randi_range(0, zone.rooms.size() - 1)]).instantiate() as Room
		add_child(r)
		r.global_position = cursor.global_position
		cursor.global_position = r.exit_point.global_position + Vector2(256, 0)
	

func _ready():
	Globals.current_level = self
	zone = load("uid://bhknlrbawc0yb")
	add_child(background.instantiate())
	_generate_rooms()

func _process(delta: float) -> void:
	camera.cirio = Globals.current_cirio
