extends Node

#--------File-------------------------------

var config = ConfigFile.new()


func save():
	config.set_value("Coins","a",Coins)
	config.set_value("email","a",email)

	config.save("res://savegame.cfg")
func recover():
	var err = config.load("res://savegame.cfg")
	if err == OK:
		Coins = config.get_value("Coins", "a")
		email = config.get_value("email", "a")
		
func clear_save():
	Coins = 0
	email = ""

	config.set_value("Coins","a",Coins)
	config.set_value("email","a",email)

	config.save("res://savegame.cfg")


#---------------Vars------------------------
#Main
var email = ""
var Coins = 400
var HighScore = 0

var on_game = true

var current_skin = 1 #1-2-3-4-5
var skins = [true,false,false,false,false] #1,2,3,4,5
#---SilentWolf-----

func _ready():
	print(email,HighScore)
	SilentWolf.configure({
		 "api_key": "q15hIYObf19Rh4A9OfhEM4ZgeaCVzSHt49zsN3Ng",   # استبدل هذا بقيمة API Key التي حصلت عليها
		 "game_id": "coustomer5game",     # استخدم معرف اللعبة الذي أنشأته
		 "game_version": "1.0",              # يمكنك تعديل رقم النسخة إذا أردت
		 "log_level": 1
	})



func submit_score(player_name: String, score: int) -> void:
	print(email,HighScore)
	# استخدام await انتظار الانتهاء من عملية الحفظ بشكل غير متزامن
	var score_id = await SilentWolf.Scores.save_score(player_name, score)
	print("تم إرسال النتيجة بنجاح، معرف النتيجة: " + str(score_id))
