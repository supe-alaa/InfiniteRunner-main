extends Node3D


@onready var level = get_parent()#$"../"


func _process(delta):
	if Global.on_game:
		position.x -= level.obstacles_speed*delta
	if position.x < -50:
		level.spawnModule(position.x+(level.amnt*level.offset))
		print("ALAA")
		queue_free()
	
