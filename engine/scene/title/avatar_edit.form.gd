extends VBoxContainer

signal submit

var active_id

func _ready():
	$tabs/user.pressed.connect(show_panel.bind($tabs/user.get_index()))
	$tabs/character.pressed.connect(show_panel.bind($tabs/character.get_index()))
	$buttons/prev.pressed.connect(next.bind(false))
	$buttons/next.pressed.connect(next.bind())
	$buttons/save.pressed.connect(save)
	show_panel(0)



func show_panel(id):
	for panel in $panels.get_children():
		panel.visible = false
	$panels.get_child(id).visible = true
	active_id = id

	$buttons/prev.visible = true if id > 0 else false
	$buttons/next.visible = true if id + 1 < $panels.get_child_count() else false
	$buttons/save.visible = not $buttons/next.visible


func next(is_next=true):
	if is_next:
		if active_id + 1 < $panels.get_child_count():
			show_panel(active_id + 1)
	elif active_id > 0:
		show_panel(active_id - 1)


func save():
	var form_data = {
		"user_name" = %user_name.text,
		"user_dob" = "{0}/{1}/{2}".format([ %day.value, %month.selected + 1, %year.value]),
		"player_name" = %player_name.text,
		"player_gender" = %gender.value,
		"player_skin_tone" = %skin_tone.value,
	}
	emit_signal("submit", form_data)
