extends AnimationTree

var input_dir = Vector2.ZERO
var is_running = false
var is_on_floor = true

func _process(_delta):
	if is_on_floor:
		if input_dir.length_squared() == 0:
			self["parameters/playback"].travel("idle")
		elif is_running:
			self["parameters/playback"].travel("run")
		else:
			self["parameters/playback"].travel("walk")
	else:
		self["parameters/playback"].travel("idle")
