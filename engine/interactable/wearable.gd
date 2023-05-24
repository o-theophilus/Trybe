extends Collectable
class_name Wearable

@export_enum("top", "bottom", "shoe") var type:String = ""

func _ready():
	super()
	add_to_group("wearable")
	add_to_group(type)
