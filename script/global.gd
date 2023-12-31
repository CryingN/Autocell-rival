extends Node

var addcell_data = [
	Vector2(4,19),
	Vector2(4,20),
	Vector2(4,21),
	Vector2(4,22),
	Vector2(4,23),
	Vector2(4,24),
	Vector2(4,25),
	Vector2(4,26),
	Vector2(4,27),
	Vector2(5,19),
	Vector2(5,20),
	Vector2(5,21),
	Vector2(5,22),
	Vector2(5,23),
	Vector2(5,24),
	Vector2(5,25),
	Vector2(5,26),
	Vector2(5,27),
	Vector2(6,19),
	Vector2(6,20),
	Vector2(6,21),
	Vector2(6,22),
	Vector2(6,23),
	Vector2(6,24),
	Vector2(6,25),
	Vector2(6,26),
	Vector2(6,27),
	Vector2(7,19),
	Vector2(7,20),
	Vector2(7,21),
	Vector2(7,22),
	Vector2(7,23),
	Vector2(7,24),
	Vector2(7,25),
	Vector2(7,26),
	Vector2(7,27),
	Vector2(8,19),
	Vector2(8,20),
	Vector2(8,21),
	Vector2(8,22),
	Vector2(8,23),
	Vector2(8,24),
	Vector2(8,25),
	Vector2(8,26),
	Vector2(8,27),
	Vector2(9,19),
	Vector2(9,20),
	Vector2(9,21),
	Vector2(9,22),
	Vector2(9,23),
	Vector2(9,24),
	Vector2(9,25),
	Vector2(9,26),
	Vector2(9,27),
	Vector2(10,19),
	Vector2(10,20),
	Vector2(10,21),
	Vector2(10,22),
	Vector2(10,23),
	Vector2(10,24),
	Vector2(10,25),
	Vector2(10,26),
	Vector2(10,27),
	Vector2(11,19),
	Vector2(11,20),
	Vector2(11,21),
	Vector2(11,22),
	Vector2(11,23),
	Vector2(11,24),
	Vector2(11,25),
	Vector2(11,26),
	Vector2(11,27),
	Vector2(12,19),
	Vector2(12,20),
	Vector2(12,21),
	Vector2(12,22),
	Vector2(12,23),
	Vector2(12,24),
	Vector2(12,25),
	Vector2(12,26),
	Vector2(12,27)
]

func main_osc(x,y):
	return [
		Vector2(x-4,y-4),
		Vector2(x-3,y-4),
		Vector2(x-2,y-4),
		Vector2(x-1,y-4),
		Vector2(x,y-4),
		Vector2(x+1,y-4),
		Vector2(x-4,y-3),
		Vector2(x-3,y-3),
		Vector2(x-2,y-3),
		Vector2(x-1,y-3),
		Vector2(x,y-3),
		Vector2(x+1,y-3),
		
		Vector2(x-1,y+4),
		Vector2(x,y+4),
		Vector2(x+1,y+4),
		Vector2(x+2,y+4),
		Vector2(x+3,y+4),
		Vector2(x+4,y+4),
		Vector2(x-1,y+3),
		Vector2(x,y+3),
		Vector2(x+1,y+3),
		Vector2(x+2,y+3),
		Vector2(x+3,y+3),
		Vector2(x+4,y+3),
		
		Vector2(x+3,y-4),
		Vector2(x+3,y-3),
		Vector2(x+3,y-2),
		Vector2(x+3,y-1),
		Vector2(x+3,y),
		Vector2(x+3,y+1),
		Vector2(x+4,y-4),
		Vector2(x+4,y-3),
		Vector2(x+4,y-2),
		Vector2(x+4,y-1),
		Vector2(x+4,y),
		Vector2(x+4,y+1),
		
		Vector2(x-4,y-1),
		Vector2(x-4,y),
		Vector2(x-4,y+1),
		Vector2(x-4,y+2),
		Vector2(x-4,y+3),
		Vector2(x-4,y+4),
		Vector2(x-3,y-1),
		Vector2(x-3,y),
		Vector2(x-3,y+1),
		Vector2(x-3,y+2),
		Vector2(x-3,y+3),
		Vector2(x-3,y+4),
		]

func attack_glider(x,y):
	return [
		Vector2(x,y-1),
		Vector2(x-1,y),
		Vector2(x+1,y+1),
		Vector2(x+1,y),
		Vector2(x+1,y+1),
	]

func attack_bullet(x,y):
	return [
		Vector2(x-2,y-1),
		Vector2(x-1,y-1),
		Vector2(x,y-1),
		Vector2(x+1,y-1),
		Vector2(x+2,y),
		Vector2(x-2,y),
		Vector2(x-2,y+1),
		Vector2(x-1,y+2),
		Vector2(x+2,y+2),
	]
	
func Eater(x,y,direction):
	return [
		Vector2(x ,y - 1),
		Vector2(x + 1*direction,y - 1),
		Vector2(x - 1*direction,y),
		Vector2(x + 1*direction,y),
		Vector2(x - 1*direction,y + 1),
		Vector2(x - 2*direction,y + 2),
		Vector2(x - 1*direction,y + 2)
	]
func _ready():
	pass
