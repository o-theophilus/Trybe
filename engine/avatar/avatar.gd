extends CharacterBody3D
class_name Character

signal gender_signal
signal skin_tone_signal

var cam_rotation = Vector3.ZERO
var is_running = false
var input_dir = Vector2.ZERO

var player:bool = false
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	pass


func _physics_process(delta):
	var speed = 200 if is_running else 100

	var movement = Vector3(input_dir.x, 0, -input_dir.y) * delta * speed
	movement = movement.rotated(Vector3.UP, deg_to_rad(cam_rotation.y))
	velocity = velocity.lerp(movement, 0.1)

	if velocity != Vector3.ZERO and is_on_floor():
		var lookdir = atan2(velocity.x, velocity.z)
		rotation.y = lerp_angle(rotation.y, lookdir, 0.1)

	if not is_on_floor():
		velocity.y -= gravity * 5 * delta

	move_and_slide()

	$anim_tree.is_on_floor = is_on_floor()
	$anim_tree.input_dir = input_dir
	$anim_tree.is_running = is_running


func set_input_dir(value):
	input_dir = value
func set_is_running(value):
	is_running = value
func set_cam_rotation(value):
	cam_rotation = value
func set_gender(value):
	$avatar/armature/GeneralSkeleton/body["blend_shapes/female"] = value
	$avatar/armature/GeneralSkeleton/body["instance_shader_parameters/gender"] = value
func set_skin_tone(value):
	$avatar/armature/GeneralSkeleton/body["instance_shader_parameters/tone"] = value
