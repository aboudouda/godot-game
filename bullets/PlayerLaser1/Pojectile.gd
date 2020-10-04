extends RigidBody2D

export var speed = 900.0

func shoot_at_mouse(start_pos):
	self.global_position = start_pos
	var direction = (get_global_mouse_position() - start_pos).normalized()
	self.linear_velocity = direction * speed
	rotation = get_global_mouse_position().angle_to_point(position)