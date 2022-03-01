extends KinematicBody2D
class_name actor




const kunai = preload("res://kunai.tscn")
var velocity = Vector2(0, 0)
var coins = 0
const speed = 800
const gravity = 85 
const jumpforce = -2000
var isattacking = false
var directionofplayer = 1
var isshooting = false



func _physics_process(delta):
	if Input.is_action_pressed("right") and isattacking == false:
		velocity.x = speed
		if is_on_floor():
			$sensei.play("run")
		$sensei.flip_h = false
		directionofplayer = -1
		if sign($Position2D.position.x) == -1:
			$Position2D.position.x *= -1
		
	elif Input.is_action_pressed("left") and isattacking == false:
		velocity.x = -speed
		$sensei.play("run")
		$sensei.flip_h = true
		directionofplayer = 1
		if sign($Position2D.position.x) == 1:
			$Position2D.position.x *= -1
	else:
		if isattacking == false and not $sensei.animation == "throw" and is_on_floor() :
			$sensei.play("idle")
	

	if Input.is_action_just_pressed("attack") and not Input.is_action_just_pressed("shoot"):
		if is_on_floor():
			$sensei.play("attack")
			isattacking = true
			$attack/CollisionShape2D.disabled = false


	if not is_on_floor() :
		if Input.is_action_just_pressed("shoot"):
			$sensei.play("jump")
	
	velocity.y += gravity
	
	if Input.is_action_just_pressed("jump") :
		velocity.y = jumpforce
		$sensei.play("jump")
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	velocity.x = lerp(velocity.x, 0, 0.5)
	
	if Input.is_action_pressed("right"):
		get_node("attack").set_scale(Vector2(1, 1))
	elif Input.is_action_pressed("left"): 
		get_node("attack").set_scale(Vector2(-1, 1))
	#if is_on_floor()  :
		#rotation = get_floor_normal().angle() + PI/2

	if Input.is_action_just_pressed("shoot"):
		var kunaii = kunai.instance()
		get_parent().add_child(kunaii)
		if sign($Position2D.position.x) == 1:
			kunaii.set_kunai_direction(1)
		else:
			kunaii.set_kunai_direction(-1)
			
		kunaii.position = $Position2D.global_position
		
		$sensei.play("throw")
		isshooting = true
	
	
	
func ouch(var enemyposx):
	set_modulate(Color(1, 0.4, 0.4, 0.7))
	velocity.y = jumpforce * 0.5
	if position.x < enemyposx:
		velocity.x = -5000
	elif position.x > enemyposx:
		velocity.x = 5000
	
	Input.action_release("left")
	Input.action_release("right")
	
	$Timer.start()





func _on_fallzone_body_entered(body):
	get_tree().change_scene("res://gameover.tscn")



func _on_sensei_animation_finished():
	if $sensei.animation == "attack":
		$attack/CollisionShape2D.disabled = true
		isattacking = false
	if $sensei.animation == "shoot":
		$sensei.play("idle")
		isshooting = false
		
