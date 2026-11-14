extends Item

func _on_collect():
	PlayerStats.damage_mult += 1.5
	PlayerStats.fire_rate += 5
	PlayerStats.pellet_lifespan += 5
	PlayerStats.luck += 35
	Globals.current_cirio.pellet_manager.add_effect_to_all_pellet_orders("uid://b7fmtjwmcp3i7")
