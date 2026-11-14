extends Item

func _on_collect():
	PlayerStats.damage += 0.50
	PlayerStats.fire_rate += 0.15
