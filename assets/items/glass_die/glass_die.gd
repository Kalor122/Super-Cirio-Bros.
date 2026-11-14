extends Item

func _on_item_activation_pressed():
	for i in Globals.current_level.current_room.get_all_item_containers(false):
		i.reroll_item()
	if Globals.advanced_chance(0.20, PlayerStats.luck, 0.0):
		queue_free()
