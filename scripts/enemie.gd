tool
extends Area2D

export(int,"A","B","C") var enemie_type = 0 setget set_enemie_type
var score = 0
var frame = 0
signal alien_destroyed(obj)

var enemie_attribute = [
	{
		"texture": preload("res://sprites/InvaderA_sheet.png"),
		"score": 10
	},
	{
		"texture":preload("res://sprites/InvaderB_sheet.png"),
		"score":20
	},
	{
		"texture":preload("res://sprites/InvaderC_sheet.png"),
		"score":30
	}
]	

func _ready():
	pass

func _draw():
	var attribute = enemie_attribute[enemie_type]
	get_node("sprite").set_texture(attribute.texture)
	score = attribute.score

func set_enemie_type(value):
	enemie_type = value
	if is_inside_tree():
		update()



func destroy(obj):
	emit_signal("alien_destroyed",self)
	queue_free()

func next_frame():
	if frame == 0:
		frame = 1
	else:
		frame = 0
	get_node("sprite").set_frame(frame)

#func _process(delta):
#	pass


func _on_enemie_area_entered(area):
	if area.has_method('destroy'):
		area.destroy(self)
