extends Area2D
const VEL = 120
const DIR = Vector2(0,1)

func _ready():
	add_to_group('alien_shot_group')



func _process(delta):
	translate(DIR*VEL*delta)
	if get_global_position().y > 304:
		destroy(self)

func destroy(obj):
	queue_free()


func _on_allien_shot_area_entered(area):
	if area.has_method('destroy'):
		area.destroy(self)
		destroy(self)
