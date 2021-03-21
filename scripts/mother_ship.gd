extends Area2D

signal destroyed(obj)

var score = 200

func _ready():
	get_node("mother_ship").play()
	get_node("anime").play("default")
	yield(get_node("anime"),"animation_finished")
	queue_free()

func destroy(obj):
	emit_signal('destroyed',self)
	queue_free()
