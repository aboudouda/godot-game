# Laser.gd Enemy
extends Area2D

const DAMAGE = 2
const VELOCITY = Vector2(-700, 0)
const IMPACT1 = preload("res://graphic/particles/EnemyLaser1Impact1.tscn")
const IMPACT2 = preload("res://graphic/particles/EnemyLaser1Impact2.tscn")

func _process(delta):
	move(delta)
	removeWhenOffScreen()

func move(delta):
    global_position += VELOCITY * delta

func removeWhenOffScreen():
    if global_position.x < 0:
        queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Laser1_area_entered(area):
	if area.is_in_group("player"):
		if area.getCooldown() <= 0:
			$Laser1.queue_free()
			var impact = IMPACT1.instance()
			impact.global_position = global_position
			get_parent().add_child(impact)
			if area.getHp() > 0:
				area.setHp(area.getHp() - DAMAGE)
			else:
				area.explode()

func _on_Laser2_area_entered(area):
	if area.is_in_group("player"):
		if area.getCooldown() <= 0:
			$Laser2.queue_free()
			var impact = IMPACT2.instance()
			impact.global_position = global_position
			get_parent().add_child(impact)
			if area.getHp() > 0:
				area.take_damage(DAMAGE)
			else:
				area.explode()