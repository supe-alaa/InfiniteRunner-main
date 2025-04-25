extends Node3D



@onready var level = $"../"
var speed = 10
var stoping = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if stoping == true: return
	print(position.x)
	#speed += 0.001
	
	speed = get_parent().Street_Speed
	position.x -= speed * 0.0126
	if position.x < -83:
		
		queue_free()

func stop():
	speed = 0
	stoping = true


func live():
	speed = 10
	stoping = false
