extends Node

@onready var active_item: Node = $ActiveItem

func add_active_item_charge(charge: int):
	if not active_item.get_children().is_empty():
		active_item.get_child(0).active_charges += charge
