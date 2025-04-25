extends Node3D


var time = randi_range(1,2)

func _ready():
	$MeshInstance3D.hide()
	if time == 1:
		add_child(preload("res://Items/magnet_item.tscn").instantiate())
	elif time == 2:
		add_child(preload("res://Items/shield_item.tscn").instantiate())
	pass
