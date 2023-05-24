extends Node

signal input_dir
signal is_running


func _unhandled_input(_event):
	var input_dir_ = Input.get_vector("move_left", "move_right", "move_back", "move_forward")
	var is_running_ = Input.is_action_pressed("run")

	emit_signal("input_dir", input_dir_)
	emit_signal("is_running", is_running_)


#func _process(_delta):
#	var input_dir_ = Input.get_vector("move_left", "move_right", "move_back", "move_forward")
#	var is_running_ = Input.is_action_pressed("run")
#
#	emit_signal("input_dir", input_dir_)
#	emit_signal("is_running", is_running_)
