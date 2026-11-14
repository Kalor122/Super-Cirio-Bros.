extends Item

func _on_collect():
	PlayerStats.damage += 3.5
	PlayerStats.damage_mult += 2.5
	PlayerStats.pellet_lifespan += 0.75
	PlayerStats.pellet_speed_mult -= 0.45
	PlayerStats.fire_rate -= 0.55
