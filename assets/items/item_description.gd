extends PanelContainer

@onready var texture_rect: TextureRect = $MarginContainer/VBoxContainer/HBoxContainer/TextureRect
@onready var name_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/NameLabel
@onready var rich_text_label: RichTextContiner = $MarginContainer/VBoxContainer/RichTextLabel
@onready var rarity_label: Label = $MarginContainer/VBoxContainer/HBoxContainer2/RarityLabel
@onready var color_rect: ColorRect = $MarginContainer/VBoxContainer/HBoxContainer2/RarityLabel/ColorRect
@onready var item_description: PanelContainer = $"."
@onready var rainbow: MarginContainer = $MarginContainer2
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var i_data: ItemData

func _ready() -> void:
	Items.item_description_show.connect(_item_description_show)
	Items.item_description_hide.connect(_item_description_hide)
	hide()

func _item_description_show(data: ItemData):
	i_data = data
	_set_info()
	animation_player.play("show")

func _item_description_hide():
	animation_player.play("hide")

func _set_info():
	if i_data:
		texture_rect.texture = i_data.item_sprite
		name_label.text = i_data.item_name
		rich_text_label.clear()
		rich_text_label.append_text(i_data.item_description)
		rarity_label.text = Globals.rarities.keys()[i_data.rarity]
		if i_data.rarity == 0:
			item_description.self_modulate = Color("64ff4dff")
			rarity_label.self_modulate = Color(0.393, 1.0, 0.3, 1.0)
			color_rect.material = null
			color_rect.hide()
			rainbow.hide()
		elif i_data.rarity == 1:
			item_description.self_modulate = Color("4dbbffff")
			rarity_label.self_modulate = Color(0.3, 0.732, 1.0, 1.0)
			color_rect.material = null
			color_rect.hide()
			rainbow.hide()
		elif i_data.rarity == 2:
			item_description.self_modulate = Color("6d4dffff")
			rarity_label.self_modulate = Color(0.428, 0.3, 1.0, 1.0)
			color_rect.material = null
			color_rect.hide()
			rainbow.hide()
		elif i_data.rarity == 3:
			item_description.self_modulate = Color("ff4d50ff")
			rarity_label.self_modulate = Color(1.0, 0.3, 0.312, 1.0)
			color_rect.material = null
			color_rect.hide()
			rainbow.hide()
		elif i_data.rarity == 4:
			item_description.self_modulate = Color(1.0, 1.0, 1.0, 1.0)
			rarity_label.self_modulate = Color(1.0, 1.0, 1.0, 1.0)
			var sh := ShaderMaterial.new()
			sh.shader = load("uid://248k74bv46yk")
			sh.set_shader_parameter("strength", 0.7)
			sh.set_shader_parameter("angle", 0)
			color_rect.material = sh
			color_rect.show()
			rainbow.show()
