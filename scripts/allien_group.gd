extends Node2D

const VEL = Vector2(6,0)

var preload_allien_shot = preload("res://scenes/allien_shot.tscn")
var preload_allien_explosion = preload("res://scenes/alien_explosion.tscn")
var preload_mother_ship = preload("res://scenes/mother_ship.tscn")

var dir = 1

signal anemy_down(obj)
signal ready2
signal earth_dominated
signal victory

func _ready():
	#get_node("timer_shot").start()
	restart_timer_mother_ship()
	for alien in get_node("aliens").get_children():
		alien.hide()
		alien.connect('alien_destroyed',self,'on_alien_destroyed')
	for alien in get_node("aliens").get_children():
		get_node("timer_pause").start()
		yield(get_node("timer_pause"),'timeout')
		alien.show()
	emit_signal("ready2")
	start_all()
	
#func _process(delta):
#	pass

func shoot():
	get_node("alien_shot").play()
	var n_aliens = get_node('aliens').get_child_count()
	if n_aliens > 0:
		var alien = get_node('aliens').get_child(randi()%n_aliens)
		var shot = preload_allien_shot.instance()
		get_parent().add_child(shot)
		shot.set_global_position(alien.get_global_position())


func _on_timer_shot_timeout():
	get_node("timer_shot").set_wait_time(rand_range(0.5,2))
	shoot()


func _on_timer_move_timeout():
	get_node("aliens_move").play()
	var border  = false
	for alien in get_node("aliens").get_children():
		alien.next_frame()
		if alien.get_global_position().x > 170 and dir > 0:
			dir = -1
			border = true
		if alien.get_global_position().x < 10 and dir < 0:
			dir = 1
			border = true
		if alien.get_global_position().y > 288 :
			emit_signal('earth_dominated')
			
	if border:
		translate(Vector2(0,8))
		if get_node("timer_move").get_wait_time() > 0.11 :
			get_node("timer_move").set_wait_time(get_node("timer_move").get_wait_time()-0.1)
	else:
		translate(VEL*dir)

func on_alien_destroyed(alien):
	get_node("alien_explosion").play()
	emit_signal("anemy_down",alien)
	var alien_explosion = preload_allien_explosion.instance()
	get_parent().add_child(alien_explosion)
	alien_explosion.set_global_position(alien.get_global_position())
	if get_node("aliens").get_child_count() == 1:
		stop_all()
		emit_signal("victory")


func _on_timer_mother_ship_timeout():
	var mother_ship = preload_mother_ship.instance()
	mother_ship.connect('destroyed',self,'on_alien_destroyed')
	get_parent().add_child(mother_ship)
	restart_timer_mother_ship()
	
func restart_timer_mother_ship():
	get_node("timer_mother_ship").set_wait_time(rand_range(6,18))
	get_node("timer_mother_ship").start()


func stop_all():
	get_node("timer_mother_ship").stop()
	get_node("timer_move").stop()
	get_node("timer_shot").stop()

func start_all():
	get_node("timer_mother_ship").start()
	get_node("timer_move").start()
	get_node("timer_shot").start()
