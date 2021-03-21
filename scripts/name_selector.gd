extends Node
signal name_selector_finished(name)

const LETTERS = 'ABCDEFGHIJKLMNOPQRSTUVXWZ'

var index = 0
var letter = 0

func _ready():
	set_process_input(true)

func _input(event):
	var change_index = false
	if event.is_action_pressed('ui_up') and not event.is_echo():
		index += 1
		change_index=true
	if event.is_action_pressed('ui_down') and not event.is_echo():
		index -= 1
		change_index=true
	if index >= LETTERS.length():
		index = 0
	if change_index:
		get_node("container").get_child(letter).set_text(LETTERS[index])

	if event.is_action_pressed('ui_right') and not event.is_echo():
		get_node("container").get_child(letter).set_percent_visible(1)
		letter += 1
		if letter > 2:
			letter = 2
	if event.is_action_pressed('ui_left') and not event.is_echo():
		get_node("container").get_child(letter).set_percent_visible(1)
		letter -= 1
		if letter < 0:
			letter = 0
	if event.is_action_pressed('ui_accept') and not event.is_echo():
		var name = get_node("container").get_child(0).get_text()+get_node("container").get_child(1).get_text()+get_node("container").get_child(2).get_text()
		print(name)
		emit_signal("name_selector_finished",name)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_timer_timeout():
	if get_node("container").get_child(letter).get_percent_visible()==1:
		get_node("container").get_child(letter).set_percent_visible(0)
	else:
		get_node("container").get_child(letter).set_percent_visible(1)
		
