extends Node
var preload_name_selector = preload("res://scenes/name_selector.tscn")
var preload_game = preload("res://scenes/game.tscn")
var game

var hiscores =[
	{name='AAA',score=400},
	{name='BBB',score=300},
	{name='CCC',score=200},
	{name='DDD',score=100},
	{name='EEE',score=60},
]
var hiscore
func _ready():
	pass

func _on_Button_pressed():
	get_node("btn_new_game").hide()
	new_game()

func new_game():
	if game != null:
		game.queue_free()
	game = preload_game.instance()
	add_child(game)
	game.connect("game_over",self,'on_game_over')
	game.connect("victory",self,'on_victory')

func on_game_over():
	hiscore = null
	for hs in hiscores:
		if game.data.score > hs.score:
			print(hs)
			hiscore = hs
			break 
	if hiscore != null:
		var name_selector = preload_name_selector.instance()
		add_child(name_selector)
		name_selector.connect("name_selector_finished",self,"on_name_selector_name_selector_finished")
		yield(name_selector,'name_selector_finished')
		print('name_selector_finished')
		name_selector.queue_free()

	get_node('btn_new_game').show()

func on_name_selector_name_selector_finished(value):
	print(hiscores)
	var index = hiscores.find(hiscore)
	hiscores.insert(index,{name=value,score=game.data.score})
	hiscores.resize(10)
	print(hiscores)

func on_victory():
	var data = game.data
	print('on_victory')
	new_game()
	game.data=data



