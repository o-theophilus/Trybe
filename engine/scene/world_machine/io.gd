extends Resource
class_name IO

@export var data_check = false
@export var user_name:String = ""
@export var user_dob:String = "01/01/2010"
@export var player_name:String = ""
@export var player_gender:float = 0.0
@export var player_skin_tone:float = 0.0


func load_data(save_path="user://file_name.tres"):
	if ResourceLoader.exists(save_path):
		var player_data = ResourceLoader.load(save_path)
		if "data_check" in player_data:
			return player_data

	return self


func save_data(save_path="user://file_name.tres"):
	var result = ResourceSaver.save(self, save_path)
	assert(result == OK, "Not Saved")
	print("** SAVED **")
	return result
