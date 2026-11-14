extends CanvasLayer

@onready var active_item_texture_rect: TextureRect = $Control/VBoxContainer/ItemStock/TextureRect
@onready var progress_bar: ProgressBar = $Control/VBoxContainer/ProgressBar
@onready var active_item_texture_rect_2: TextureRect = $Control/VBoxContainer/ItemStock/TextureRect2

func _ready() -> void:
	GlobalSignals.active_item_got.connect(_active_item_got)
	GlobalSignals.active_item_charge_changed.connect(_active_item_charge_changed)

func _process(delta: float) -> void:
	if not ItemMachine.active_item.get_children().is_empty():
		active_item_texture_rect.texture = ItemMachine.active_item.get_child(0).data.item_sprite
		active_item_texture_rect_2.texture = ItemMachine.active_item.get_child(0).data.item_sprite
		
		progress_bar.show()
		progress_bar.min_value = 0
		progress_bar.max_value = ItemMachine.active_item.get_child(0).data.active_charges
	else:
		active_item_texture_rect.texture = null
		active_item_texture_rect_2.texture = null
		progress_bar.value = 0
		progress_bar.hide()

func _active_item_got(item: ItemData):
	progress_bar.value = item.active_charges

func _active_item_charge_changed(value: int):
	progress_bar.value = value
