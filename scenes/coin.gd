extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _on_body_entered(body):
	if body.name == "Player" :
		Global.Coins += 1
		Sfx.get_node("coin").play()
		$subway_surfers_coin.hide()
		$CollisionShape3D.disabled = true
		$CPUParticles3D.restart()
		await get_tree().create_timer(0.5).timeout
		queue_free()
	pass # Replace with function body.


func _on_area_entered(area):
	if area.name == "AreaMagnet":
		Global.Coins += 1
		Sfx.get_node("coin").play()
		$subway_surfers_coin.hide()
		$CollisionShape3D.disabled = true
		$CPUParticles3D.restart()
		queue_free()
	pass # Replace with function body.
