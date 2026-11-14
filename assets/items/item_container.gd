extends ItemContainer

@onready var sprite_2d: Sprite2D = $Sprite2D

var cirio_on = false
@onready var animation_player: AnimationPlayer = $Sprite2D/AnimationPlayer
@onready var anim_delay: Timer = $AnimDelay

func _start():
	anim_delay.start(randf_range(0.1, 1))

func _process(delta: float) -> void:
	if item:
		sprite_2d.texture = item.item_sprite
	else:
		sprite_2d.texture = null

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	cirio_on = true
	Items.item_description_show.emit(item)

func _on_area_2d_body_exited(body: Node2D) -> void:
	cirio_on = false
	Items.item_description_hide.emit()

func _input(event: InputEvent) -> void:
	if cirio_on:
		if Input.is_action_just_pressed("interact"):
			collect_item()

func _on_anim_delay_timeout() -> void:
	animation_player.play("new_animation")
