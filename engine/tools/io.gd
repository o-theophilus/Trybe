extends Resource
class_name IO


func load_data(save_path="user://file_name.tres"):
	if ResourceLoader.exists(save_path):
		return ResourceLoader.load(save_path)
#		return load(save_path)
	return null


func save_data(data, save_path="user://file_name.tres"):
	var result = ResourceSaver.save(data, save_path)
	assert(result == OK, "Not Saved")
	print("** SAVED **")
	return result
