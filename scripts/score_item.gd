extends HBoxContainer

var pos = '1ST' setget set_pos
var gamer = 'AAA' setget set_gamer
var score = '99999' setget set_score
var color  = Color(1,1,1,1) setget set_color

func set_pos(value):
	pos = value
	get_node("pos").set_text(str(value))

func set_gamer(value):
	gamer = value
	get_node("gamer").set_text(str(value))

func set_score(value):
	score = value
	get_node("score").set_text(str(value))

func set_color(value):
	color = value
	get_node("pos").set('custom_colors/font_color',color)
	get_node("gamer").set('custom_colors/font_color',color)
	get_node("score").set('custom_colors/font_color',color)


#func _ready():
#	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
