extends Panel

signal player_data_saved
var active_id

func _ready():
	%gender.value_changed.connect(%avatar_player.set_gender)
	%skin_tone.value_changed.connect(%avatar_player.set_skin_tone)

	%form/tabs/user.pressed.connect(show_panel.bind(%form/tabs/user.get_index()))
	%form/tabs/character.pressed.connect(show_panel.bind(%form/tabs/character.get_index()))
	%form/buttons/prev.pressed.connect(next.bind(false))
	%form/buttons/next.pressed.connect(next.bind())
	%form/buttons/save.pressed.connect(save)
	show_panel(0)
	load_player_data()



func show_panel(id):
	for panel in %form/panels.get_children():
		panel.visible = false
	%form/panels.get_child(id).visible = true
	active_id = id

	%form/buttons/prev.visible = true if id > 0 else false
	%form/buttons/next.visible = true if id + 1 < %form/panels.get_child_count() else false
	%form/buttons/save.visible = not %form/buttons/next.visible


func next(is_next=true):
	if is_next:
		if active_id + 1 < %form/panels.get_child_count():
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
	var res = world_machine.save_player_data(form_data)
	if res == OK:
		emit_signal("player_data_saved")


func load_player_data():
	var player_data = world_machine.player_data
	%user_name.text = player_data.user_name
	var dob = player_data.user_dob.split("/")
	%day.value = int(dob[0])
	%month.selected = int(dob[1]) - 1
	%year.value = int(dob[2])
	%player_name.text=player_data.player_name
	%gender.value=player_data.player_gender
	%skin_tone.value=player_data.player_skin_tone
	%avatar_player.set_gender(player_data.player_gender)
	%avatar_player.set_skin_tone(player_data.player_skin_tone)


