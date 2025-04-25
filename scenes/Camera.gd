extends Camera3D



@export var RS = 30
@export var SF = 5

var rng = RandomNumberGenerator.new()
var SS : float = 0.0

func apply_shake():
	SS = RS
	
func _process(delta):
	
	if SS > 0:
		SS = lerpf(SS,0,SF * delta)
		
		position = RO()/100
		
func RO() -> Vector3:
	return Vector3(rng.randf_range(-SS,SS),rng.randf_range(-SS,SS),rng.randf_range(-SS,SS))
	
