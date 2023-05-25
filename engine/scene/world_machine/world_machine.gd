extends Node

var next_scene
@onready var io = IO.new()
@onready var player_data = io.load_data()


func _ready():
	process_scene()


func change_scene(node):
#	get_tree().root.remove_child(get_tree().current_scene)
	get_tree().current_scene.queue_free()
	node = node.instantiate()
	get_tree().root.add_child(node)
	get_tree().current_scene = node
	process_scene()


func process_scene():
	if (
		"scene_type" in get_tree().current_scene
		and get_tree().current_scene.scene_type == "level"
	):
		$ui.visible = true
	else:
		$ui.visible = false


func save_player_data(form_data):
	io.user_name = form_data.user_name
	io.user_dob = form_data.user_dob
	io.player_name = form_data.player_name
	io.player_gender = form_data.player_gender
	io.player_skin_tone = form_data.player_skin_tone
	var res = io.save_data()
	if res == OK:
		player_data = io
	return res



