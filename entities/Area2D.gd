extends Area2D

const PARTICLE_EXPLOSION = preload("res://graphic/particles/Enemy_explosion.tscn")
var hp = 200

func getHp():
	return self.hp

func setHp(hp):
	self.hp = hp

func explode():
	var particle = PARTICLE_EXPLOSION.instance()
	particle.global_position = global_position
	get_parent().add_child(particle)
	queue_free()