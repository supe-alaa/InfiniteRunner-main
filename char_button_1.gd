extends Button


# Called when the node enters the scene tree for the first time.

@onready var id = int(str(name)[10]) - 1
@onready var price = int(text)

func _ready():
	print(int(text))
	print(disabled)
	
	update_state()

@warning_ignore("unused_parameter")
func _process(delta):
	if !Global.Coins >= int(text):
		release_focus()
	#print(Global.current_skin)


func _on_pressed():
	if Global.Coins >= price and Global.skins[id] == false:
		Global.skins[id] = true
		Global.current_skin = id + 1
		disabled = false
		print("Bued")
		Global.Coins -= price
		Global.save()
	elif Global.skins[id] == true:
		Global.current_skin = id + 1
	else:
		release_focus()
	update_state()
	for a in $"..".get_children():
		a.update_state()
	pass # Replace with function body.

func update_state():
	if Global.skins[id] == true:
		disabled = false
		text = " READY!"
		if Global.current_skin == id + 1:
			grab_focus()
	else:
		if Global.Coins >= price :
			disabled = false
		else:
			disabled = true
