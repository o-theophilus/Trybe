extends Node3D

signal cam_rotation

@export var cam:Camera3D
@export var target:Node3D

@export_range(0, 1) var cam_damp = 0.5

@export_group("orbit", "orbit_")
@export var orbit_auto = false
@export var orbit_alt = true
@export var orbit_drag_mouse_left = false
@export_range(0, 2) var orbit_speed = 1.0
@export_subgroup("orbit pitch", "orbit_pitch_")
@export var orbit_pitch_max = -60.0
@export var orbit_pitch_min = 40.0
@export var orbit_pitch_default = -18.0
@export_group("pan", "pan_")
@export var pan_shift = true
@export var pan_drag_mouse_right = false
@export_range(0, 2) var pan_speed = 1.0
@export_subgroup("x", "pan_x_")
@export var pan_x_max = 0.5
@export var pan_x_min = -0.5
@export var pan_x_default = 0.0
@export_subgroup("y", "pan_y_")
@export var pan_y_max = 0.5
@export var pan_y_min = -0.5
@export var pan_y_default = 0.0
@export_group("zoom", "zoom_")
@export var zoom_ctrl = true
@export var zoom_scroll_mouse_wheel = false
@export_range(0, 2) var zoom_speed = 1.0
@export var zoom_max = 2.0
@export var zoom_min = 0.5
@export var zoom_default = 1.25

var move_delta = Vector2.ZERO
var is_autoing = false
var is_dragging = false
var is_panning = false
var is_zooming = false


func _ready():
	%rot_x.rotation_degrees.x = orbit_pitch_default
	%pos_xy.position.x = pan_x_default
	%pos_xy.position.y = pan_y_default
#	%pos_z.position.z = zoom_default
	%spring.spring_length = zoom_default


func _input(event):
	if event is InputEventMouseMotion:
		move_delta = event.relative

		if event.button_mask == 0 or event.button_mask == 1:
			is_autoing = true
		else:
			is_autoing = false
		if event.button_mask == 1:
			is_dragging = true
		else:
			is_dragging = false
		if event.button_mask == 2:
			is_panning = true
		else:
			is_panning = false


	if event is InputEventMouseButton and "button_index" in event:
		is_autoing = false # fix
		if event.button_index == 4:
			is_zooming = true
			move_delta = Vector2.DOWN
		if event.button_index == 5:
			is_zooming = true
			move_delta = Vector2.UP
	else:
		is_zooming = false



func _process(delta):
	global_position = target.global_position
	move_delta *= delta

	if (
		Input.is_key_pressed(KEY_ALT) and orbit_alt
		or (
			orbit_auto and is_autoing
			and not Input.is_key_pressed(KEY_SHIFT)
			and not Input.is_key_pressed(KEY_CTRL)
		)
		or (
			orbit_drag_mouse_left and is_dragging
			and not Input.is_key_pressed(KEY_SHIFT)
			and not Input.is_key_pressed(KEY_CTRL)
		)
	):
		orbit(move_delta)

	if (
		Input.is_key_pressed(KEY_SHIFT) and pan_shift
		or pan_drag_mouse_right and is_panning
	):
		pan(move_delta)

	if (
		Input.is_key_pressed(KEY_CTRL) and zoom_ctrl
		or zoom_scroll_mouse_wheel and is_zooming
	):
		zoom(move_delta)

	cam.global_position = cam.global_position.lerp(%pos_z.global_position, cam_damp * 30 * delta)
	cam.look_at(%rot_x.global_position, Vector3.UP)


func orbit(axis):
	axis *= orbit_speed * 20
	%rot_y.rotation_degrees.y -= axis.x
	%rot_x.rotation_degrees.x -= axis.y
	%rot_x.rotation_degrees.x = clamp(%rot_x.rotation_degrees.x, orbit_pitch_max, orbit_pitch_min)

	emit_signal("cam_rotation", %rot_y.global_rotation_degrees)

func pan(axis):
	axis *= pan_speed
	%pos_xy.position.x -= axis.x
	%pos_xy.position.y += axis.y
	%pos_xy.position.x = clamp(%pos_xy.position.x, pan_x_min, pan_x_max)
	%pos_xy.position.y = clamp(%pos_xy.position.y, pan_y_min, pan_y_max)

func zoom(axis):
	axis *= zoom_speed
	%spring.spring_length += axis.y
	%spring.spring_length = clamp(%spring.spring_length, zoom_min, zoom_max)




