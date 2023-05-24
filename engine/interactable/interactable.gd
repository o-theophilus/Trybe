extends Node3D
class_name Interactable

@export var highlight_glow:StandardMaterial3D
var highlight:StandardMaterial3D
var touching = false
var item:MeshInstance3D


func _ready():
	add_to_group("interactable")

	var sb = find_children("","StaticBody3D")[0]
	sb.touching_signal.connect(func():touching = true)

	item = find_children("","MeshInstance3D")[0]
	if highlight_glow:
		highlight = item.mesh["surface_0/material"].duplicate()
		highlight["next_pass"] = highlight_glow


func _process(_delta):
	item["surface_material_override/0"] = highlight if touching and highlight else null
	touching = false
