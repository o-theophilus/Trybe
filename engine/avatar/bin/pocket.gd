@tool
extends Node

@export var _skeleton:Skeleton3D
@export var top:PackedScene
@export var bottom:PackedScene
@export var shoe:PackedScene

var mi:MeshInstance3D

var gender


func set_asset(item, type):
	if type in [0, "top"]: $top["mesh"] = item
	if type in [1, "bottom"]: $bottom["mesh"] = item
	if type in [2, "shoe"]: $shoe["mesh"] = item

func init_set(_node, node_name):
	if _node:
		var mesh = _node.instantiate()["mesh"]
		set_asset(mesh, node_name)
	else:
		set_asset(null, node_name)

	node_name = get_node(node_name)
	node_name["skeleton"] = node_name.get_path_to(_skeleton)

func _ready():
	init_set(top, "top")
	init_set(bottom, "bottom")
	init_set(shoe, "shoe")

func _process(_delta):
	if $top["mesh"]: $top["blend_shapes/female"] = gender
	if $bottom["mesh"]: $bottom["blend_shapes/female"] = gender
	if $shoe["mesh"]: $shoe["blend_shapes/female"]  = gender

