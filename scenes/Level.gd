extends Node3D





@export var pices:Array[PackedScene] 


var amnt = 5

var rng = RandomNumberGenerator.new()

var offset = 49.80


var obstacles_speed = 4.5


func _ready():
	for i in amnt :
		spawnModule(i*offset)
	pass

@warning_ignore("unused_parameter")
func _physics_process(delta):
	obstacles_speed += 0.00015

	pass

# الفنكشن المسؤولة عن إنشاء قطع جديدة
func spawnModule(n):
	rng.randomize()
	var num = rng.randi_range(0,pices.size()-1)
	var instance = pices[num].instantiate()
	instance.position.x = n
	add_child(instance)

