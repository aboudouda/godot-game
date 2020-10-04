extends Label

var score = 0

func _process(delta):
	set_text(str(score))

func getScore():
	return score

func setScore(score):
	self.score = score

func addScore(score):
	self.score += score

func _on_Enemy_enemy_destroyed():
	addScore(1000)

func _on_Enemy2_enemy_destroyed():
	addScore(1000)

func _on_Enemy3_enemy_destroyed():
	addScore(1000)
