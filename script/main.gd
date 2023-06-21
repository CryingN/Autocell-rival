extends Node2D

onready var tilemap = $TileMap
onready var lim_line = $Lim_line
onready var tween = $Tween
onready var colorrect = $ColorRect
onready var printf = $ColorRect/printf

# 计时器
var time
var time_end
# 地图(尺寸,矩阵)
var map_size:Vector2
var my_map
# 最小/最大摆放位置
var map_min:Vector2
var map_max:Vector2
# 判断是否移动,具体用来干嘛的我也忘记了
var move_camera:bool
# 鼠标基于节点的相对位置,挺重要的概念
var local:Vector2
# true开始-false暂停
var start:bool
# 临时用的一些判定
var can_move
var in_game
var add_cell
var my_level

# 判定范围
var limites = [-1,0,1]

func _ready():
	map_min = Vector2(0,0)
	map_max = Vector2(46,46)
	map_size = Vector2(80,60)
	move_camera = false
	local = get_local_mouse_position()
	read_matrix()
	start = true
	time = 0
	time_end = -1
	can_move = false
	printf.text = ""
	in_game = false
	add_cell = false
	pass

func _input(event):
	if can_move:
		if move_camera:
			position += get_local_mouse_position() - local
			pass
		if event is InputEventMouseButton and event.button_index == BUTTON_MASK_RIGHT:
			local = get_local_mouse_position()
			move_camera = not move_camera
			pass
		if event is InputEventMouseButton:
			if event.button_index == 4:
				local = get_local_mouse_position() - position
				position -= local * 0.05
				scale += Vector2(0.05, 0.05)
				pass
			elif event.button_index == 5:
				local = get_local_mouse_position() - position
				position += local * 0.05
				if scale.x > 0.6:
					scale -= Vector2(0.05, 0.05)
	if event is InputEventMouseButton and event.button_index == BUTTON_MASK_LEFT and add_cell:
		var x = int(get_local_mouse_position().x / 34)
		var y = int(get_local_mouse_position().y / 34)
		if x <= map_max.x and x >= map_min.x and y <= map_max.y and y >= map_min.y and not (Vector2(x,y) in Global.addcell_data):
			tilemap.set_cell(x,y,0)
		pass

func _physics_process(_delta):
	if start and not add_cell:
		time += 1
		update_matrix()
		if (tilemap.get_cell(8,23) != -1 and in_game and my_level == 1) or (time == time_end and in_game and my_level == 2):
			position = Vector2(0,0)
			scale = Vector2(1,1)
			colorrect.rect_scale.y = 1
			printf.text = "You lose"
			can_move = false
			in_game = false
			time_end = -1
		if (time == time_end and in_game and my_level == 1) or (tilemap.get_cell(69,23) != -1 and in_game and my_level == 2):
			position = Vector2(0,0)
			scale = Vector2(1,1)
			colorrect.rect_scale.y = 1
			printf.text = "You win"
			can_move = false
			in_game = false
			time_end = -1

func lim_the_line(line_min:Vector2, line_max:Vector2):
	lim_line.clear_points()
	lim_line.add_point(line_min * 34)
	lim_line.add_point(Vector2(line_min.x,line_max.y+1) * 34)
	lim_line.add_point((line_max+Vector2(1,1)) * 34)
	lim_line.add_point(Vector2(line_max.x+1,line_min.y) * 34)
	lim_line.add_point(line_min * 34)
	pass

func read_matrix():
	my_map = []
	for x in range(map_size.x):
		my_map.append([])
		for y in range(map_size.y):
			if tilemap.get_cell(x,y) == 0:
				my_map[x].append(1)
			elif tilemap.get_cell(x,y) == 1:
				my_map[x].append(-1)
			elif tilemap.get_cell(x,y) == -1:
				my_map[x].append(0)
	return my_map

func update_matrix():
	var update_my_map = []
	for x in range(map_size.x):
		update_my_map.append([])
		for y in range(map_size.y):
			update_my_map[x].append(update_cell(x,y))
	my_map = update_my_map
	pass

func update_cell(x,y):
	var num = 0
	var new_cell = my_map[x][y]
	if x == 0 or x == map_size.x-1 or y == 0 or y == map_size.y-1:
		num = 0
	else:
		for i in limites:
			for j in limites:
				if my_map[x+i][y+j] == 1:
					num += 1
				elif my_map[x+i][y+j] == -1:
					num -= 1
		num -= my_map[x][y]

	if (num <= -4) or (num in limites) or (num >= 4):
		new_cell = 0
		tilemap.set_cell(x,y,-1)
	elif num == 3:
		new_cell = 1
		tilemap.set_cell(x,y,0)
	elif num == -3:
		new_cell = -1
		tilemap.set_cell(x,y,1)
	return new_cell

func _on_AddCell_button_up():
	if add_cell:
		read_matrix()
	add_cell = not add_cell
	pass # Replace with function body.

func _on_level1_button_up():
	my_level = 1
	tween.interpolate_property(colorrect, "rect_scale:y",
		1, 0, 0.5,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	start = false
	tween.start()
	map_min = Vector2(18,18)
	map_max = Vector2(22,28)
	can_move =true
	tilemap.clear()
	for i in Global.main_osc(8,23):
		tilemap.set_cell(i[0],i[1],0)
	for i in Global.attack_bullet(72,21):
		tilemap.set_cell(i[0],i[1],1)
	for i in Global.attack_bullet(74,29):
		tilemap.set_cell(i[0],i[1],1)
	for i in Global.attack_bullet(71,9):
		tilemap.set_cell(i[0],i[1],1)
	for i in Global.attack_bullet(68,38):
		tilemap.set_cell(i[0],i[1],1)
	for i in Global.attack_bullet(65,31):
		tilemap.set_cell(i[0],i[1],1)
	read_matrix()
	time = 0
	time_end = 140
	in_game = true
	start = true
	lim_the_line(map_min,map_max)
	pass




func _on_level2_button_up():
	my_level = 2
	map_min = Vector2(0,0)
	map_max = Vector2(46,46)
	tween.interpolate_property(colorrect, "rect_scale:y",
		1, 0, 0.5,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	start = false
	tween.start()
	can_move =true
	tilemap.clear()
	for i in Global.main_osc(8,23):
		tilemap.set_cell(i[0],i[1],0)
	for i in Global.main_osc(69,23):
		tilemap.set_cell(i[0],i[1],1)
	for i in Global.Eater(55,20,-1):
		tilemap.set_cell(i[0],i[1],1)
	for i in Global.Eater(55,26,-1):
		tilemap.set_cell(i[0],i[1],1)
	read_matrix()
	time = 0
	time_end = 200
	in_game = true
	start = true
	lim_the_line(map_min,map_max)
	pass
