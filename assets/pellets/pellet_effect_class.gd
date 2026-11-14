extends Node
class_name PelletEffect

var pellet: Pellet

func _ready() -> void:
	if get_parent() is Pellet:
		pellet = get_parent()
	pellet.collision.body_entered.connect(_on_body_entered_collision)
	pellet.collision.body_exited.connect(_on_body_exited_collision)
	_start()

func _process(delta: float) -> void:
	_update(delta)

func _physics_process(delta: float) -> void:
	_physics_update(delta)

func _start():
	pass

func _update(delta):
	pass

func _physics_update(delta):
	pass

func _on_body_entered_collision(body: Node2D):
	pass

func _on_body_exited_collision(body: Node2D):
	pass
