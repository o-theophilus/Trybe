extends Character

@export_range(0, 1) var gender:float = 0.0
@export_range(0, 1) var skin_tone:float = 0.0

func _ready():
	super()
	set_gender(gender)
	set_skin_tone(skin_tone)
