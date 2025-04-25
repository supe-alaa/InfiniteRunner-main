extends Area3D


var time = randi_range(1,10)

func _ready():
	if time != 1:
		queue_free()
	pass

func _on_body_entered(body):
	if body.name == "Player":
		body.take_item("shield")
		queue_free()
	pass # Replace with function body.
