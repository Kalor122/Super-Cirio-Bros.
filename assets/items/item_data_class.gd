extends Resource
class_name ItemData

@export var id: int = 0
@export var item_sprite: CompressedTexture2D
@export var item_name: String
@export_multiline() var item_description: String
@export var rarity: int = 0
@export var is_active: bool = false
@export var active_charges: int = 1
@export var limit: int = -1
@export_file_path("*.tscn") var item_scene: String

func get_item_scene():
	var scene = load(item_scene) as PackedScene
	return scene.instantiate()
