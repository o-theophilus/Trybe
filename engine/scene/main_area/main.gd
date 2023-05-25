extends Node

var scene_type = "level"

func _ready():
	var player = find_children("","Player")[0]
	$cam_rig.cam_rotation.connect(player.set_cam_rotation)
	$player_coltrol.input_dir.connect(player.set_input_dir)
	$player_coltrol.is_running.connect(player.set_is_running)

	player.set_gender(world_machine.player_data.player_gender)
	player.set_skin_tone(world_machine.player_data.player_skin_tone)
