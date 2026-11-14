extends Item

func _on_item_activation_pressed():
	for i in Globals.current_level.current_room.get_all_item_containers():
		i.reroll_item()
