extends Particles2D

func _process(delta):
	one_shot = false
	emitting = false
	if Input.is_action_pressed("ui_accept"):
		one_shot = true
		emitting = true