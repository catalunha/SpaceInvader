extends Node

const extra_life_points = [100,200,400]
var extra_life_index = 0

var score = 0
var lifes = 3

func _ready():
	update_score()
	get_node("allien_group").connect("anemy_down",self,"on_allien_group_anemy_down")
	get_node("allien_group").connect("ready2",self,'on_allien_group_ready2')
	get_node("allien_group").connect("earth_dominated",self,'on_allien_group_earth_dominated')
	get_node("allien_group").connect("victory",self,'on_allien_group_victory')
	get_node("ship").connect("destroyed",self,'on_ship_destroyed')
	get_node("ship").connect("respawn",self,'on_ship_respawn')

func on_allien_group_anemy_down(alien):
	score += alien.score
	if extra_life_index<extra_life_points.size() and score >= extra_life_points[extra_life_index]:
		lifes +=1
		get_node("HUD/life_draw").set_lifes(lifes)
		extra_life_index += 1
	update_score()

func on_allien_group_ready2():
	get_node("ship").start()

func on_allien_group_earth_dominated():
	game_over()

func on_allien_group_victory():
	print('on_allien_group_victory')
	
func update_score():
	get_node("HUD/score").set_text(str(score))

func on_ship_destroyed():
	get_node("allien_group").stop_all()
	lifes -= 1
	get_node("HUD/life_draw").set_lifes(lifes)
	get_tree().call_group('alien_shot_group','destroy',self)

func on_ship_respawn():
		if lifes <= 0:
			game_over()
		else:
			get_node("allien_group").start_all()
			

func game_over():
	get_node("allien_group").stop_all()
	get_node("ship").disable()

#func _process(delta):
#	pass
