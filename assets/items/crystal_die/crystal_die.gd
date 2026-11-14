extends Item

func _on_item_activation_pressed():
	var r
	match Globals.rng.randi_range(1, 2):
		1:
			r = "Rare"
		2:
			r = "Epic"
	
	for i in Globals.current_level.current_room.get_all_item_containers():
		i.set_item(Items.get_items_in_rarity(r).pick_random())
