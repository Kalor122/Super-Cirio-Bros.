extends Item

func _on_collect():
	PlayerStats.fire_rate -= 0.15
	if Globals.advanced_chance(0.35, -10):
		print("FIREEE")
