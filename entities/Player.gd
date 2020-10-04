# Player.gd
extends KinematicBody2D

const BULLET_LASER = preload("res://Bullets/PlayerLaser1/Laser.tscn")
const JETFIRE = preload("res://graphic/particles/Jetfire.tscn")
const PAUSESCREEN = preload("res://menu/PauseScreen.tscn")
const RELOAD_TIME = 0.1

var motion = Vector2()
export var speed = 600
var reloading = 0.0

func fire():
	if reloading <= 0.0:
		var bullet = BULLET_LASER.instance()
		get_parent().add_child(bullet)
		bullet.shoot_at_mouse(self.global_position)
		reloading = RELOAD_TIME

func get_input():
	motion = Vector2()
	if Input.is_action_pressed('ui_right'):
		motion.x += 1

	if Input.is_action_pressed('ui_left'):
		motion.x -= 1

	if Input.is_action_pressed('ui_up'):
		motion.y -= 3

	if Input.is_action_pressed('ui_down'):
		motion.y += 3

	motion = motion.normalized() * speed

	if Input.is_action_pressed("ui_accept"):
		fire()

func _physics_process(delta):
	get_input()
	motion = move_and_slide(motion)
	rotation = get_global_mouse_position().angle_to_point(position)

func _process(delta):
	reloading -= delta
	