extends Node2D
class_name Room

@export var room_id: int = 0

@export var starting_room: bool = false
@export var camera_top_limit: int = -144
@export var camera_bottom_limit: int = -144
@export var camera_left_limit: int = -256
@export var camera_right_limit: int = -256
@export var exit_point: Marker2D
@export var room_trigger: Area2D

var level: Level
var distance_from_start: Vector2

func _ready():
	if get_tree().current_scene is Level:
		level = get_tree().current_scene
	room_trigger.body_entered.connect(_body_entered)

func _process(delta: float) -> void:
	distance_from_start = global_position - level.start_room.global_position
	
	if level.current_room == self:
		level.camera.limit_top = camera_top_limit + distance_from_start.y
		level.camera.limit_bottom = camera_bottom_limit + distance_from_start.y
		level.camera.limit_left = camera_left_limit + distance_from_start.x
		level.camera.limit_right = camera_right_limit + distance_from_start.x

func _body_entered(body: Node2D):
	level.current_room = self
	ItemMachine.add_active_item_charge(1)
	#level.camera.global_position = global_position

func get_all_item_containers(ignore_empty: bool = true):
	var list: Array[ItemContainer] = []
	for i in get_children():
		if ignore_empty:
			if i is ItemContainer:
				if i.item != null:
					list.append(i)
		else:
			if i is ItemContainer:
				list.append(i)
	return list
