extends PelletEffect

var spd_mult = 0.0

func _update(delta):
	pellet.speed = 150 * spd_mult
	spd_mult += 0.015
	pellet.sub_damage(0.05)
	
	if spd_mult >= 1:
		spd_mult = 1
