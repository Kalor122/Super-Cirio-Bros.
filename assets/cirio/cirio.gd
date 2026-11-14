extends Cirio

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var pellet_exit: PelletExit = $PelletExit
@onready var timer: Timer = $Timer

func _start():
	_stat_calculation()

func _physics_update(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = move_toward(velocity.x, speed * direction, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)
	
	_handle_jump()
	_handle_animation()
	move_and_slide()

func _handle_jump():
	if is_on_floor():
		current_jump = 0
	
	if current_jump < jump_count:
		if Input.is_action_just_pressed("jump"):
			velocity.y = jump_velocity
			current_jump += 1
		elif Input.is_action_just_released("jump") and velocity.y < jump_velocity / 2:
			velocity.y = jump_velocity / 2
	else:
		if Input.is_action_just_released("jump") and velocity.y < jump_velocity / 2:
			velocity.y = jump_velocity / 2

func _handle_animation():
	if direction < 0:
		animated_sprite_2d.flip_h = true
	elif direction > 0:
		animated_sprite_2d.flip_h = false
	
	if velocity.x != 0:
		animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("idle")
	
	if velocity.y != 0:
		animated_sprite_2d.play("jump")

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("shoot"):
		_shoot()
		timer.start()
	elif Input.is_action_just_released("shoot"):
		timer.stop()

func _on_timer_timeout() -> void:
	_shoot()

func _shoot():
	pellet_manager.shoot(pellet_exit, (PlayerStats.damage * PlayerStats.damage_mult) ** PlayerStats.damage_exp)

func _stat_calculation():
	timer.wait_time = 1 / PlayerStats.fire_rate
