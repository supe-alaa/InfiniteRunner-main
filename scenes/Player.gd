extends CharacterBody3D


var positions = [-1,0,1]
var curPos = 1

var swipeLength = 100
var startSwipe: Vector2
var curSwipe: Vector2
var swiping = false

var threshold = 20
var swipeDir = 0

const JUMP_VEL = 4
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var player_state = "Normal"

var Control_Type = "Keyboard" # OR PHONE

var items = []
var uitems = []

func _ready():
	var char_type = str("res://chars/char",Global.current_skin,".tscn")
	$Char.add_child(load(char_type).instantiate())
	
	$AreaBoomer.monitoring = true
	await get_tree().create_timer(0.1).timeout
	$AreaBoomer.monitoring = false
	
	$"Char/Char/Fast Run/AnimationPlayer".play("mixamo_com")
	

var cur_pos = 1
func _physics_process(delta):

	
			
				
	
	if player_state == "Dieing": 

		$Char/Char/Jump.hide()
		$"Char/Char/Fast Run".hide()
	if player_state == "Normal":
		
		swipe()
		
		if Input.is_action_just_pressed("right") and position.z != 1:
			cur_pos += 1 

			$MoveAnimationPlayer.stop()
			$MoveAnimationPlayer.play("right")
			$MoveSfx.play()
		elif Input.is_action_just_pressed("left") and position.z != -1:

			cur_pos -= 1 
			$MoveAnimationPlayer.stop()
			$MoveAnimationPlayer.play("left")
			$MoveSfx.play()

		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y += JUMP_VEL
			$Char/Char/Jump.show()
			$"Char/Char/Fast Run".hide()
			$JumpSfx.play()
			$Char/Char/Jump/AnimationPlayer.play("mixamo_com")
			await $Char/Char/Jump/AnimationPlayer.animation_finished
			$Char/Char/Jump.hide()
			$"Char/Char/Fast Run".show()
			$"Char/Char/Fast Run/AnimationPlayer".play("mixamo_com")
		velocity.y += -gravity * delta
		move_and_slide()
	
		position.z = lerpf(position.z,positions[cur_pos],delta*30)


var swipe_start := Vector2.ZERO
var swipe_threshold := 50  # الحد الأدنى للسحب لتغيير المسار

func swipe():
	if Input.is_action_just_pressed("press"):
		if !swiping:
			swiping = true
			startSwipe = get_viewport().get_mouse_position()
			
	if Input.is_action_pressed("press"):
		if swiping:
			curSwipe = get_viewport().get_mouse_position()
			if startSwipe.distance_to(curSwipe) >= swipeLength:
				
				if abs(startSwipe.y-curSwipe.y) < threshold:
					if startSwipe.x-curSwipe.x < 0:
						if position.z != 1:
							cur_pos += 1 
							$MoveAnimationPlayer.stop()
							$MoveAnimationPlayer.play("right")
							$MoveSfx.play()
					else:
						if position.z != -1:
							cur_pos -= 1 
							$MoveAnimationPlayer.stop()
							$MoveAnimationPlayer.play("left")
							$MoveSfx.play()
				if abs(startSwipe.x-curSwipe.x) < threshold:
					if startSwipe.y-curSwipe.y > 0 and is_on_floor():
						velocity.y = JUMP_VEL
						
						$Char/Char/Jump.show()
						$"Char/Char/Fast Run".hide()
						$JumpSfx.play()
						$Char/Char/Jump/AnimationPlayer.play("mixamo_com")
						await $Char/Char/Jump/AnimationPlayer.animation_finished
						$Char/Char/Jump.hide()
						$"Char/Char/Fast Run".show()
						$"Char/Char/Fast Run/AnimationPlayer".play("mixamo_com")
						
				swiping = false
	else:
		swiping = false





@export var speed: float = 300.0

var moving_left := false
var moving_right := false





@warning_ignore("shadowed_global_identifier", "unused_parameter")
func death(str,rot):
	position.y = 0.141
	if str == "Wait for Rot": 
		$Camera/Camera.apply_shake()
		player_state = "Dieing"
		Global.on_game = false
		$"Char/Char/Fast Run".hide()
		
		$Char/Char/Jump.hide()
		$"Char/Char/Falling Back Death".show()
		$"Char/Char/Falling Back Death/AnimationPlayer".play("mixamo_com")
		await $"Char/Char/Falling Back Death/AnimationPlayer".animation_finished
		$Area.monitoring = false
		$"../UI".Die()

func live():
	$AreaBoomer.monitoring = true
	await get_tree().create_timer(0.1).timeout
	$AreaBoomer.monitoring = false
	
	collision_mask = 1
	$"Char/Char/Falling Back Death".hide()
	$Char/Char/Jump.hide()
	$"Char/Char/Fast Run".show()
	$"Char/Char/Fast Run/AnimationPlayer".play("mixamo_com")
	
	
	player_state = "Normal"
	Global.on_game = true
	position.y = 0.141

	$AnimationPlayer.play("liveing")
	
	await $AnimationPlayer.animation_finished
	collision_mask = 2
	$Area.monitoring = true


@warning_ignore("unused_parameter")
func _on_area_body_entered(body):
	if body.is_in_group("module"):
		
		
		for a in items: 
			if a == "shield":
				Sfx.get_node("harddamage").play()
				$Camera/Camera.apply_shake()
				$AreaBoomer.monitoring = true
				await get_tree().create_timer(0.1).timeout
				$AreaBoomer.monitoring = false
				print("AAAAA")
				print(items)
				
				itemfinshed("shield")
				
				return
		Sfx.get_node("harddamage").play()
		death("Wait for Rot",90)
	pass # Replace with function body.


func _on_area_boomer_body_entered(body):
	if body.is_in_group("module"):
		body.get_parent().queue_free()

	pass # Replace with function body.



func take_item(token_item):
	Sfx.get_node("powerup").play()
	for a in items: 
		if a == token_item: 
			print("SAD")
			return
	items.append(token_item)
	
	match token_item:
		"shield":
			var uitem = preload("res://u_item.tscn").instantiate()
			uitem.item_type = "🛡"
			check_shiled()
			$"../UI/Items".add_child(uitem)
			uitems.append(uitem)
			pass
		"magnet":
			var uitem = preload("res://u_item.tscn").instantiate()
			uitem.item_type = "🧲"
			check_magnet()
			$"../UI/Items".add_child(uitem)
			uitems.append(uitem)
			pass
	print("itemoded")
	pass


func itemfinshed(item_type):
	var indexo = 0
	for a in items:
		if a == item_type:
			items.remove_at(indexo)
			
			if a == "shield":
				for b in $"Char/Char/Fast Run/RootNode/Skeleton3D".get_children():
					b.material_overlay = null
				for b in $Char/Char/Jump/RootNode/Skeleton3D.get_children():
					b.material_overlay = null
			elif a == "magnet": 
				$AreaMagnet.collision_layer = 0
			uitems[indexo].queue_free()
			uitems.remove_at(indexo)
			
			return
		
		
		
		indexo += 1
	

func check_shiled():
	for a in items: 
		if a != "shield":
			for b in $"Char/Char/Fast Run/RootNode/Skeleton3D".get_children():
				b.material_overlay = null
			for b in $Char/Char/Jump/RootNode/Skeleton3D.get_children():
				b.material_overlay = null
		elif a == "shield": 
			for b in $"Char/Char/Fast Run/RootNode/Skeleton3D".get_children():
				b.material_overlay = preload("res://scenes/Shelid Outline.tres")
			for b in $Char/Char/Jump/RootNode/Skeleton3D.get_children():
				b.material_overlay = preload("res://scenes/Shelid Outline.tres")

func check_magnet():
	for a in items: 
		if a != "magnet":
			$AreaMagnet.collision_layer = 0
		elif a == "magnet": 
			$AreaMagnet.collision_layer = 1
