extends VBoxContainer

const preload_score_item = preload("res://scenes/score_item.tscn")
const POSITIONS = ['1ST','2ND','3RD','4TH','5TH','6TH','7TH','8TH','9TH','10TH']
const COLORS = ['ff0000','ff7700','ffb900','fdff00','c7ff00','49ff00','00ff5d','00fff3','008dff','0700ff',]
func _ready():
	pass

func show_hiscores(hiscores):
	print('show_hiscores')
	for c in get_children():
		if c is HBoxContainer:
			c.queue_free()

	var head = preload_score_item.instance()
	head.pos = 'RANK'
	head.name = 'NAME'
	head.score = 'SCORE'
	add_child(head)
	
	var i=0
	for hs in hiscores:
		var score_item = preload_score_item.instance()
		score_item.pos = POSITIONS[i]
		score_item.gamer = hs.gamer
		score_item.score = hs.score
		score_item.color = Color(COLORS[i])
		add_child(score_item)
		var timer = get_node("timer")
		timer.start()
		yield(timer,"timeout")
		i+=1


func teste():
	for i in range(10):
		var score_item = preload_score_item.instance()
		score_item.pos = POSITIONS[i]
		score_item.score = i
		add_child(score_item)
		var timer = get_node("timer")
		timer.start()
		yield(timer,"timeout")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
