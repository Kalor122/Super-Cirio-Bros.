extends PelletEffect

func _on_body_entered_collision(body: Node2D):
	if body is Pellet:
		if body.enemy_pellet:
			pellet.add_damage(0.20)
			print(body)
			body.queue_free()
