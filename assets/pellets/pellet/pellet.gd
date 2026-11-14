extends Pellet

@onready var dmg_label: Label = $DmgLabel
@onready var aura: Sprite2D = $Aura

func _start():
	if not enemy_pellet:
		aura.modulate = Color(0.0, 0.65, 1.0, 0.706)
	else:
		aura.modulate = Color(1.0, 0.0, 0.0, 0.706)

func _physics_update(delta):
	velocity = direction * speed
	dmg_label.text = Globals.format(damage)
	if not enemy_pellet:
		aura.modulate = Color(0.0, 0.65, 1.0, 0.706)
	else:
		aura.modulate = Color(1.0, 0.0, 0.0, 0.706)
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	queue_free()
