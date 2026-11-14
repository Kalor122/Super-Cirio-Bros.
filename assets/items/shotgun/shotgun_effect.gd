extends PelletEffect

func _start():
	pellet.mult_damage(1.45)

func _update(delta):
	pellet.sub_damage(0.01 + (((PlayerStats.damage * PlayerStats.damage_mult) ** PlayerStats.damage_exp) / 100))
