extends Item

func _on_collect():
	var order_1 := PelletOrder.new()
	var order_2 := PelletOrder.new()
	order_1.pellet_rotation = -10
	order_2.pellet_rotation = 10
	Globals.current_cirio.pellet_manager.add_pellet_order(order_1)
	Globals.current_cirio.pellet_manager.add_pellet_order(order_2)
	Globals.current_cirio.pellet_manager.add_effect_to_all_pellet_orders("uid://6gltccdln2nl")
	PlayerStats.pellet_speed_mult += 0.5
