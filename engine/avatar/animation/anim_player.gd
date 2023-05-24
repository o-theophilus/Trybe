@tool
extends AnimationPlayer


func _ready():
	var path = "res://avatar/animation/"
	var dir = DirAccess.open(path)
	var files = dir.get_files()

	for file in files:
		if file.get_extension() == "blend":
			var lib = load(path+file)
			if lib is AnimationLibrary:
				var name_ = lib.resource_path.split("/")[-1].split(".")[0]
				if not has_animation_library(name_):
					var _e = add_animation_library(name_, lib)

	for x in get_animation_list():
		get_animation(x).loop_mode = Animation.LOOP_LINEAR
