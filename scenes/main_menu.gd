extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	load_leaderboard()
	await get_tree().create_timer(2.5).timeout
	
	

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta):
	$Coins_Label.text = str(Global.Coins,"$")


func _on_play_pressed():
	Global.on_game = true
	ScenesTeleporter.teleport("res://scenes/main.tscn")


@onready var leaderboard_container = $LeaderBoard  # تأكد من تعديل المسار حسب شجرة العقد

func load_leaderboard() -> void:
	await SilentWolf.Scores.get_scores(5)
	# دالة توضيحية لمسح المحتوى الحالي إن وُجد
	var rank: int = 1
	await get_tree().create_timer(2).timeout
	
	$Label.hide()
	var list = []
	for score in SilentWolf.Scores.scores:
		var label = preload("res://scenes/rank_label.tscn").instantiate()
		label.text = "#"+str(rank) + " - " + score.player_name + " - " + str(score.score)
		leaderboard_container.add_child(label)
		rank += 1
		if list.has(score.player_name):
			label.queue_free()
			print("sd")
		else:
			list.append(score.player_name)
			print(list)
		
	
			
		
	


func _on_log_out_pressed():
	Firebase.Auth.logout()
	get_tree().change_scene_to_file("res://authentication.tscn")
	pass # Replace with function body.


func _on_shop_pressed():
	$Shop.show()
	pass # Replace with function body.


func _on_back_pressed():
	$Shop.hide()
	$Settings.hide()
	pass # Replace with function body.
