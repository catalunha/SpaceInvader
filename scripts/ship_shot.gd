extends Area2D

const VEL = 200
const DIR = Vector2(0,-1)

func _ready():
	add_to_group("group_shoot")



func _process(delta):
	translate(DIR*VEL*delta)
	if get_global_position().y < 5:
		queue_free()


func _on_ship_shot_area_entered(area):
	if area.has_method('destroy'):
		area.destroy(self)
	destroy(self)

func destroy(obj):
	queue_free()
