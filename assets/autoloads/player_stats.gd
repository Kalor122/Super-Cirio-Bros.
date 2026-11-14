extends Node

signal stat_calculation

func _ready() -> void:
	stat_calculation.connect(_stat_calculation)
	Tick.timeout.connect(_tick_timeout)

var damage: float = 3.5:
	set(value):
		damage = value
		stat_calculation.emit()
var damage_mult: float = 1.0:
	set(value):
		damage_mult = value
		stat_calculation.emit()
var damage_exp: float = 1.0:
	set(value):
		damage_exp = value
		stat_calculation.emit()

var fire_rate: float = 1.35:
	set(value):
		fire_rate = value
		stat_calculation.emit()

var pellet_speed_mult: float = 1.0:
	set(value):
		pellet_speed_mult = value
		stat_calculation.emit()

var pellet_lifespan: float = 1.0:
	set(value):
		pellet_lifespan = value
		stat_calculation.emit()

var luck: float = 0.0:
	set(value):
		luck = value
		stat_calculation.emit()

func _stat_calculation():
	if pellet_speed_mult <= 0.01:
		pellet_speed_mult = 0.01
	if fire_rate <= 0.01:
		fire_rate = 0.01
	if pellet_lifespan <= 0.01:
		pellet_lifespan = 0.01
	if damage <= 0.01:
		pellet_lifespan = 0.01
	if damage_mult <= 0.01:
		pellet_lifespan = 0.01
	if damage_exp <= 0.01:
		pellet_lifespan = 0.01

func _tick_timeout():
	stat_calculation.emit()
