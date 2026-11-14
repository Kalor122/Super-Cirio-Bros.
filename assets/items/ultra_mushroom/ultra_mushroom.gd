extends Item

func _on_collect():
	PlayerStats.damage_exp += 0.2
