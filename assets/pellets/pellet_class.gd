extends Entity
class_name Pellet

@export var data: PelletData
@export var collision: Area2D
@export var enemy_pellet: bool = false

var direction = Vector2.RIGHT
var parent: Node2D
var distance_from_parent: Vector2

var speed: float = 200.0
var damage := BigNumber.new()

var lifespan_time: float
var lifespan_timer := Timer.new()

func _ready() -> void:
	_set_size()
	speed *= PlayerStats.pellet_speed_mult
	lifespan_time = PlayerStats.pellet_lifespan
	add_child(lifespan_timer)
	lifespan_timer.timeout.connect(_lifespan_timer_out)
	lifespan_timer.start(lifespan_time)
	collision.body_entered.connect(_on_body_entered_collision)
	collision.body_exited.connect(_on_body_exited_collision)
	_start()

func _process(delta: float) -> void:
	if damage.is_less_than(0.01):
		queue_free()
	_update(delta)

func _physics_process(delta: float) -> void:
	_physics_update(delta)

func _set_size():
	scale.x = (damage.to_float() / 100) / 0.085
	scale.y = (damage.to_float() / 100) / 0.085
	
	if scale >= Vector2(5.5, 5.5):
		scale = Vector2(5.5, 5.5)

func _lifespan_timer_out():
	queue_free()

func set_damage(new_damage: Variant):
	damage.exponent = 0
	damage.mantissa = 0
	damage.plus_equals(new_damage)
	_set_size()

func add_damage(new_damage: Variant):
	damage.plus_equals(new_damage)
	_set_size()

func sub_damage(new_damage: Variant):
	damage.minus_equals(new_damage)
	_set_size()

func mult_damage(new_damage: Variant):
	damage.multiply_equals(new_damage)
	_set_size()

func div_damage(new_damage: Variant):
	damage.divide_equals(new_damage)
	_set_size()

func pow_damage(new_damage: Variant):
	damage.power_equals(new_damage)
	_set_size()

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
