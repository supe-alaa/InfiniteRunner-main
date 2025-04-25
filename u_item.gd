extends Label


@export var item_type = "🛡"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var sec = 10

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	text = str(" ",item_type,"️    ",int(sec),"s      ")
	
	pass


func _on_timer_timeout():
	var itemos
	match item_type:
		"🛡":
			itemos = "shield"
		"🧲":
			itemos = "magnet"
	get_parent().get_parent().get_parent().get_node("Player").itemfinshed(itemos)
	queue_free()
	pass # Replace with function body.


func _on_timer_2_timeout():
	sec -= 1
	pass # Replace with function body.
