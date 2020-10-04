extends HBoxContainer

var max_health = 20
var current_health = 0
var cooldown = 0

func _on_Hurtbox_hp_changed(hp):
	animate_value(current_health, hp)
	current_health = hp
	$Count/Number.text = "HP %s/%s" % [hp, max_health]

func _on_Hurtbox_initialize_lifebar(hp):
	max_health = hp
	current_health = hp
	$TextureProgress.value = current_health
	$TextureProgress.max_value = max_health
	
func set_count_text():
	$Count/Number.text = "HP %s/%s" % [current_health, max_health]
	
func animate_value(start, end):
	$Tween.interpolate_property($TextureProgress, "value", start, end, 0.6, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$Tween.interpolate_method(self, "set_count_text", start, end, 0.6, Tween.TRANS_EXPO, Tween.EASE_OUT)
	$Tween.start()
	if end < start:
		$AnimationPlayer.play("shake")

func flicker_on_damage():
	if cooldown > 0.0:
		for i in 8:
			$TextureProgress.modulate.a = 0.5
			for i in 10:
				yield(get_tree(), "idle_frame")
			$TextureProgress.modulate.a = 1.0
			for i in 10:
				yield(get_tree(), "idle_frame")
		print("finish")

func _on_Hurtbox_show_cooldown(cool):
	cooldown = cool
	flicker_on_damage()

func _process(delta):
	cooldown -= delta
	print(current_health)