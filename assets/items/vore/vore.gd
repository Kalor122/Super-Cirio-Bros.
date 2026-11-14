extends Item

func _on_collect():
	Globals.current_cirio.pellet_manager.add_effect_to_all_pellet_orders("uid://bl78b3qmk8m7y")
