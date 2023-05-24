extends Control

signal saved_avatar

var scene_type = "screen"

@onready var io = IO.new()
@onready var load_data = io.load_data()
var one_time = true


func _ready():
	%gender.value_changed.connect(%avatar_player.set_gender)
	%skin_tone.value_changed.connect(%avatar_player.set_skin_tone)
	%form.submit.connect(save)


func _process(_delta):
	pass
	if one_time:
		one_time = false
		%user_name.text = load_data.user_name
		var dob = load_data.user_dob.split("/")
		%day.value = int(dob[0])
		%month.selected = int(dob[1]) - 1
		%year.value = int(dob[2])
		%player_name.text=load_data.player_name
		%gender.value=load_data.player_gender
		%skin_tone.value=load_data.player_skin_tone


func save(form_data):
	var pd = PlayerData.new()
	pd.user_name = form_data.user_name
	pd.user_dob = form_data.user_dob
	pd.player_name = form_data.player_name
	pd.player_gender = form_data.player_gender
	pd.player_skin_tone = form_data.player_skin_tone
	var res = io.save_data(pd)
	if res == OK:
		emit_signal("saved_avatar")

