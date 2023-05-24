extends AnimationPlayer

var control
var player


func _ready():
	player = get_parent()
	control = player.get_node("control")

func _process(delta):
	if control.jump and player.is_on_floor():
		play("jump")
