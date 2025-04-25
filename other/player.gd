extends CharacterBody3D


signal player_died


@onready var animation_player = $player_with_anim/AnimationPlayer
@onready var turn = $player_with_anim/turn

@onready var ray_cast = $RayCast3D


var positions = [-2.4,0,2.4]

var cur_pos = 1


var gravity = 64

var jump_vel = 16

var runn:bool = true


func _physics_process(delta):
	
	if runn and Global.game_on :
		runn = false
		animation_player.play("Armature_001|mixamo_com|Layer0")
		await animation_player.animation_finished
		runn = true
		
	
	
	if Input.is_action_just_pressed("left"):
		turn.play("turn_L")
		if cur_pos >= 1 :
			cur_pos -= 1 
	elif Input.is_action_just_pressed("right"):
		turn.play("turn_R")
		if cur_pos <= 1 :
			cur_pos += 1 
	
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = jump_vel 
		animation_player.play("Armature|mixamo_com|Layer0_001")
	
	
	velocity.y -= gravity*delta
	
	
	position.z = lerpf(position.z,positions[cur_pos],delta*30)
	
	$camera_cntroller.position = lerp($camera_cntroller.position, position,0.11)
	
	if ray_cast.is_colliding():
		player_died.emit()
		die()
	
	
	
	move_and_slide()
	

func die():
	ray_cast.enabled = false
	animation_player.play("Armature|mixamo_com|Layer0")
	Global.game_on = false
	#get_tree().reload_current_scene()
