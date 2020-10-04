extends Area2D

const PARTICLE_EXPLOSION = preload("res://graphic/particles/Enemy_explosion.tscn")
const STAGGER_EXPLOSION = preload("res://graphic/particles/Stagger.tscn")
var hp = 200
const COOLDOWN = 2.68
var cooldown = 0.0
signal hp_changed(hp)
signal initialize_lifebar(hp)
signal show_cooldown(cooldown)

func _ready():
	add_to_group("player")
	emit_signal("initialize_lifebar", hp)

func getCooldown():
	return cooldown

func getHp():
	return hp

func setHp(hp):
	self.hp = hp

func explode():
	var particle = PARTICLE_EXPLOSION.instance()
	particle.global_position = global_position
	get_parent().add_child(particle)

func _process(delta):
	cooldown -= delta
	emit_signal("hp_changed", hp)
	if hp <= 0:
		death()

func _on_Hurtbox_area_entered(area):
	if area.is_in_group("enemy"):
		if cooldown <= 0:
			take_damage(50)
			emit_signal("show_cooldown", COOLDOWN)
			cooldown = COOLDOWN
			var particle = STAGGER_EXPLOSION.instance()
			particle.global_position = position
			get_parent().add_child(particle)
			flicker_on_damage()

func flicker_on_damage():
	if cooldown > 0.0:
		for i in 8:
			get_parent().modulate.a = 0.5
			for i in 10:
				yield(get_tree(), "idle_frame")
			get_parent().modulate.a = 1.0
			for i in 10:
				yield(get_tree(), "idle_frame")
		print("finish")

func take_damage(dmg):
	if cooldown <= 0.0:
		setHp(getHp()-dmg)

func death():
	var particle = PARTICLE_EXPLOSION.instance()
	particle.global_position = global_position
	get_parent().add_child(particle)
	queue_free()
	get_tree().change_scene('res://menu/Gameover.tscn')