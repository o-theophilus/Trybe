extends Node

func _ready():
	$pause/pause.pressed.connect(pause)
	%resume.pressed.connect(pause.bind(false))
	process_mode = Node.PROCESS_MODE_ALWAYS


func _input(event: InputEvent):
	if event.is_action_pressed("ui_cancel") or event.is_action_pressed("pause"):
		pause(not get_tree().paused)


func pause(value=true):
	$pause.visible = not value
	$panel.visible = value
	get_tree().paused = value
