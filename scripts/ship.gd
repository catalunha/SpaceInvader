extends Area2D
var preload_ship_shot = preload("res://scenes/ship_shot.tscn")
const VEL = 100
var left
var right
var dir
var shoot
var previous_shoot = false
var count_shoot
var alive = true
signal destroyed(obj)
signal respawn(obj)

func _ready():
	hide()


func _process(delta):
	# +++ Movimenta a nave na esq e direita
	dir=0
	right = Input.is_action_pressed("ui_right")
	left = Input.is_action_pressed("ui_left")
	shoot = Input.is_action_pressed("ui_ship_shot_shoot")

	if right :
		dir += 1
	if left :
		dir -= 1

	translate(Vector2(1,0)*VEL*dir*delta)
	# ---
	
	# +++ Parar a nave na borda do game
	if get_global_position().x < 7 :
		set_global_position(Vector2(7,get_global_position().y))
	if get_global_position().x > (180-7) :
		set_global_position(Vector2((180-7),get_global_position().y))
	# ---
	
	# +++ Limitar o numero de tiros a apenas um por toque
	count_shoot = get_tree().get_nodes_in_group("group_shoot").size()
	if shoot and not previous_shoot and count_shoot==0:
		get_node("ship_shoot").play()
		var shot = preload_ship_shot.instance()
		get_parent().add_child(shot)
		shot.set_global_position(get_global_position())
	previous_shoot = shoot
	# ---
func start():
	show()
	set_process(true)

func disable():
	hide()
	set_process(false)
	alive = false

func destroy(obj):
	if alive:
		get_node("ship_explosion").play()
		alive = false
		set_process(false)
		emit_signal("destroyed")
		get_node("anim").play("default")
		yield(get_node("anim"),"animation_finished")
		emit_signal("respawn")
		set_process(true)
		alive = true
		get_node("sprite").set_frame(0)
