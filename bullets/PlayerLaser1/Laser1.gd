extends Area2D

var hp = 100

# Called when the node enters the scene tree for the first time.
func getHp():
	return self.hp

func setHp(hp):
	self.hp += hp
