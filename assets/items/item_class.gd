extends Node
class_name Item

@export var data: ItemData

var active_charges: int:
	set(value):
		active_charges = value
		if data.is_active:
			GlobalSignals.active_item_charge_changed.emit(value)

func _ready() -> void:
	active_charges = data.active_charges
	_start()

func _process(delta: float) -> void:
	if active_charges == data.active_charges:
		if Input.is_action_just_pressed("item_activation"):
			_on_item_activation_pressed()
			active_charges = 0
		if Input.is_action_just_released("item_activation"):
			_on_item_activation_released()
	
	if active_charges >= data.active_charges:
		active_charges = data.active_charges
	_update(delta)

func _physics_process(delta: float) -> void:
	_physics_update(delta)

func _on_collect():
	pass

func _on_item_activation_pressed():
	pass

func _on_item_activation_released():
	pass

func _start():
	pass

func _update(delta):
	pass

func _physics_update(delta):
	pass
