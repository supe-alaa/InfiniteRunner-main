extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _on_body_entered(body):
	if body.name == "Player" :
		Global.Coins += 1
		Sfx.get_node("coin").play()
		queue_free()
	pass # Replace with function body.


func _on_area_entered(area):
	if area.name == "AreaMagnet":
		Global.Coins += 1
		Sfx.get_node("coin").play()
		queue_free()
	pass # Replace with function body.
