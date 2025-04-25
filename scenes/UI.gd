extends CanvasLayer




var CurrentScore = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Coins_Label.text = str(Global.Coins)
	$Die/Coins_Label.text = str(Global.Coins)
	$Die/Score_Label.text = str(CurrentScore)
	$Score_Label.text = str(CurrentScore)
	pass


func _on_ad_pressed():
	$"../Player".live()
	$Die.hide()
	$ScoreTimer.start()
	pass # Replace with function body.


func _on_exit_pressed():
	
	if CurrentScore > Global.HighScore:
		Global.HighScore = CurrentScore
		Global.submit_score(Global.email,Global.HighScore)
	ScenesTeleporter.teleport("res://scenes/main_menu.tscn")
	
	pass # Replace with function body.

func Die():
	$Die/HignScore.visible = CurrentScore > Global.HighScore
	$AnimationPlayer.play("Die")
	$ScoreTimer.stop()


func _on_score_timer_timeout():
	CurrentScore += 1
	pass # Replace with function body.
