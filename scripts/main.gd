extends Node

const HISCORE_FILE = 'user://hiscore_file'
# na minha maquina user é: /home/catalunha/.local/share/godot/app_userdata/spaceinvaders
var preload_name_selector = preload("res://scenes/name_selector.tscn")
var preload_game = preload("res://scenes/game.tscn")
var game
# 33 a 126
var password_file = [12,45,65,25,56,53,62,34,100,123,33,99,87,91]
var hiscores =[
	{gamer='AAA',score=400},
	{gamer='BBB',score=300},
	{gamer='CCC',score=200},
	{gamer='DDD',score=100},
	{gamer='EEE',score=60},
	{gamer='EEE',score=60},
	{gamer='EEE',score=60},
	{gamer='EEE',score=60},
	{gamer='EEE',score=60},
	{gamer='EEE',score=60}
]
var hiscore
func _ready():
	load_hiscore()
	get_node("hiscore").show_hiscores(hiscores)

func _on_Button_pressed():
	get_node("btn_new_game").hide()
	get_node("hiscore").hide()
	get_node("logo").hide()
	new_game()

func new_game():
	if game != null:
		game.queue_free()
	game = preload_game.instance()
	get_node("game_node").add_child(game)
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
		name_selector.queue_free()
		save_hiscore()

	get_node("logo").show()
	get_node("hiscore").show()
	get_node("hiscore").show_hiscores(hiscores)	
	get_node('btn_new_game').show()

func on_name_selector_name_selector_finished(value):
	var index = hiscores.find(hiscore)
	hiscores.insert(index,{gamer=value,score=game.data.score})
	hiscores.resize(10)


func on_victory():
	var data = game.data
	print('on_victory')
	new_game()
	game.data=data

func save_hiscore():
	var file = File.new()
	var result =file.open_encrypted_with_pass(HISCORE_FILE,file.WRITE,PoolByteArray(password_file).get_string_from_utf8())
	if result == OK:
		var store_hiscore = {hiscores=hiscores}
		file.store_string(JSON.print(store_hiscore))
		file.close()

func load_hiscore():
	var file = File.new()
	var result =file.open_encrypted_with_pass(HISCORE_FILE,file.READ,PoolByteArray(password_file).get_string_from_utf8())
	if result == OK:
		var text = file.get_as_text()
		var store_histore = JSON.parse(text)
		hiscores = store_histore.result.hiscores
