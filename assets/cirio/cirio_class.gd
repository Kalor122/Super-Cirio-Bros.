extends Entity
class_name Cirio

@export var data: CirioData
@export var pellet_manager: PelletManager

var speed: float
var direction: float
var acceleration: float
var friction: float

var jump_count: int
var current_jump = 0
var jump_velocity: float

func _ready():
	speed = data.speed
	acceleration = data.acceleration
	friction = data.friction
	jump_velocity = data.jump_velocity
	jump_count = data.jump_count
	PlayerStats.stat_calculation.connect(_stat_calculation)
	_start()

func _process(delta: float) -> void:
	Globals.current_cirio = self
	_update(delta)

func _physics_process(delta: float) -> void:
	_physics_update(delta)

func _start():
	pass

func _update(delta):
	pass

func _physics_update(delta):
	pass

func _stat_calculation():
	pass
