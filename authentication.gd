extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	Firebase.Auth.login_succeeded.connect(on_login_succeeded)
	Firebase.Auth.signup_succeeded.connect(on_signup_succeeded)
	Firebase.Auth.login_failed.connect(on_login_failed)
	Firebase.Auth.signup_failed.connect(on_signup_failed)
	
	if Firebase.Auth.check_auth_file():
		%StateLabel.text = "Logged in"
		Global.recover()
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame func process (delta):
	pass
func _on_login_button_pressed():
	var email = %EmailLineEdit.text
	var password = %PasswordLineEdit.text
	Global.email = %EmailLineEdit.text
	Firebase.Auth.login_with_email_and_password(email, password)
	Global.recover()
	%StateLabel.text = "Logging in"
func _on_signup_button_pressed():
	var email = %EmailLineEdit.text
	var password = %PasswordLineEdit.text
	Global.email = %EmailLineEdit.text
	Firebase.Auth.signup_with_email_and_password (email, password)
	%StateLabel.text = "Singing up"

func on_login_succeeded (auth):
	print(auth)
	%StateLabel.text = "Login success!"
	Firebase.Auth.save_auth(auth)
	Firebase.Auth.load_auth()
	
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func on_signup_succeeded (auth):
	print (auth)
	%StateLabel.text = "Sign up success! "
	Firebase.Auth.save_auth(auth)
	Firebase.Auth.load_auth()
	Global.email = %EmailLineEdit.text
	Global.save()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func on_login_failed (error_code, message):
	print(error_code)
	print (message)
	%StateLabel.text = "Login failed. Error: %s" % message
func on_signup_failed (error_code, message):
	print(error_code)
	print (message)

	%StateLabel.text = "Sign up failed. Error: %s" % message
