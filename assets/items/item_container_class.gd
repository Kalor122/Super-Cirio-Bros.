extends Entity
class_name ItemContainer

@export var item: ItemData
@export var roll_at_start: bool = true
@export var item_rarity: int = -1

func collect_item():
	if item:
		print(item.item_name)
		item.get_item_scene()._on_collect()
		if item.is_active == false:
			ItemMachine.add_child(item.get_item_scene())
			item = null
		elif item.is_active == true:
			if ItemMachine.active_item.get_children().is_empty():
				ItemMachine.active_item.add_child(item.get_item_scene())
				GlobalSignals.active_item_got.emit(item)
				item = null
			else:
				if ItemMachine.active_item.get_child(0).data.id != item.id:
					var new_item = ItemMachine.active_item.get_child(0).data
					for i in ItemMachine.active_item.get_children():
						i.queue_free()
					ItemMachine.active_item.add_child(item.get_item_scene())
					GlobalSignals.active_item_got.emit(item)
					item = new_item

func reroll_item(luck: float = PlayerStats.luck):
	item = Items.roll_item(luck)

func set_item(new_item: ItemData):
	item = new_item

func _ready():
	if roll_at_start:
		if item_rarity <= -1:
			reroll_item()
		else:
			item = Items.get_items_in_rarity(Globals.rarities.keys()[item_rarity]).pick_random()
	
	_start()

func _start():
	pass
