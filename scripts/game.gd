extends Node

const extra_life_points = [100,200,400]

var data = {
	extra_life_index = 0,
	score = 0,
	lifes = 3
} setget set_data

signal game_over
signal victory

func _ready():
	update_score()
	get_node("allien_group").connect("anemy_down",self,"on_allien_group_anemy_down")
	get_node("allien_group").connect("ready2",self,'on_allien_group_ready2')
	get_node("allien_group").connect("earth_dominated",self,'on_allien_group_earth_dominated')
	get_node("allien_group").connect("victory",self,'on_allien_group_victory')
	get_node("ship").connect("destroyed",self,'on_ship_destroyed')
	get_node("ship").connect("respawn",self,'on_ship_respawn')

#func _process(delta):
#	pass

func on_allien_group_anemy_down(alien):
	data.score += alien.score
	if data.extra_life_index<extra_life_points.size() and data.score >= extra_life_points[data.extra_life_index]:
		data.lifes +=1
		update_lifes()
		data.extra_life_index += 1
	update_score()

func on_allien_group_ready2():
	get_node("ship").start()

func on_allien_group_earth_dominated():
	game_over()

func on_allien_group_victory():
	get_node("allien_group").stop_all()
	get_node("ship").disable()
	emit_signal("victory")

func update_score():
	get_node("HUD/score").set_text(str(data.score))

func update_lifes():
	get_node("HUD/life_draw").set_lifes(data.lifes)

func update_hud():
	update_score()
	update_lifes()

func on_ship_destroyed():
	get_node("allien_group").stop_all()
	data.lifes -= 1
	update_lifes()
	get_tree().call_group('alien_shot_group','destroy',self)

func on_ship_respawn():
		if data.lifes <= 0:
			game_over()
		else:
			get_node("allien_group").start_all()

func game_over():
	get_node("allien_group").stop_all()
	get_node("allien_group").hide()
	get_node("ship").disable()
	get_node("ship").queue_free()
	emit_signal("game_over")

func set_data(value):
	data = value
	update_hud()
