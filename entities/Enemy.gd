extends Area2D

# Declare member variables here.
const ADDED_SCORE = 1000
const RELOAD_TIME = 0.1
const BULLET_LASER = preload("res://Bullets/EnemyLaser1/Laser.tscn")
const PARTICLE_EXPLOSION = preload("res://graphic/particles/Enemy_explosion.tscn")
var hp = 200
var reloading = 0.0
var explode = true
signal enemy_destroyed

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("enemy")

func getHp():
	return self.hp

func setHp(hp):
	self.hp = hp

func explode():
	if explode:
		var particle = PARTICLE_EXPLOSION.instance()
		particle.global_position = global_position
		get_parent().add_child(particle)
		queue_free()
		emit_signal("enemy_destroyed")
		explode = false
	
func fire():
	if reloading <= 0.0:
		var bullet = BULLET_LASER.instance()
		bullet.global_position = global_position
		get_parent().add_child(bullet)
		reloading = RELOAD_TIME
		
func _process(delta):
	reloading -= delta
	if Input.is_key_pressed(KEY_ENTER):
		fire()
