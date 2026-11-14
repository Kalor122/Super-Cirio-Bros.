extends Node
class_name PelletManager

var pellet_orders: Array[PelletOrder]
var global_pellet_effects: Array[String]

func _ready() -> void:
	if pellet_orders.is_empty():
		var po := PelletOrder.new()
		#po.pellet_effects.append("uid://b7fmtjwmcp3i7")
		pellet_orders.append(po)

func shoot(exit: Node2D, damage: Variant, is_enemy: bool = false) -> void:
	var dmg = BigNumber.new()
	dmg.mantissa = 0
	dmg.exponent = 0
	if damage is float:
		dmg.plus_equals(damage)
	elif damage is BigNumber:
		dmg.plus_equals(damage)
	
	for i in pellet_orders:
		var instance = i.pellet.instantiate()
		if instance is Pellet:
			instance.global_position = exit.global_position
			#instance.global_rotation = exit.global_rotation
			if i.pellet_rotation == 0.0:
				instance.direction = instance.direction.rotated(exit.global_rotation)
			else:
				instance.direction = instance.direction.rotated(deg_to_rad(exit.global_rotation_degrees + i.pellet_rotation))
			get_tree().current_scene.add_child(instance)
			instance.damage.exponent = 0
			instance.damage.mantissa = 0
			instance.damage.plus_equals(dmg)
			instance._set_size()
			for x in i.pellet_effects:
				instance.add_child(load(x).instantiate())
			for x in global_pellet_effects:
				instance.add_child(load(x).instantiate())
			instance.enemy_pellet = is_enemy

func get_pellet_orders() -> Array[PelletOrder]:
	return pellet_orders

func add_pellet_order(order: PelletOrder) -> void:
	pellet_orders.append(order)

func add_effect_to_all_pellet_orders(effect: String) -> void:
	global_pellet_effects.append(effect)

func add_effect_to_pellet_order(effect: String, order: int) -> void:
	pellet_orders[order].pellet_effects.append(effect)
