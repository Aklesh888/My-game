extends KinematicBody2D


var velocity = Vector2.ZERO
export var direction = -1
export var detects_cliff = true
var directionofplayer = 1

var run_speed = 300
var player = null
onready var floorchecker = $floorchecker.position.x


func _ready():
	
	if direction == 1:
		$AnimatedSprite.flip_h = true
	$floorchecker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	
	$floorchecker.enabled = detects_cliff
	


func _physics_process(delta):
	
	if is_on_wall() or $floorchecker.is_colliding() and is_on_floor() and detects_cliff:
		direction *= -1 
		$AnimatedSprite.flip_h = false
		$floorchecker.position.x = $CollisionShape2D.shape.get_extents().x * direction
		

	velocity.y += 2
	velocity.x = direction * 100
	
	velocity = move_and_slide(velocity, Vector2.UP)
	get_floor_normal()
	if player:
		velocity = position.direction_to(player.position) * run_speed
		velocity = move_and_slide(velocity)
		


	

func _on_sieschecker_body_entered(body):
	body.ouch(position.x)
	


func _on_Timer_timeout():
	get_tree().change_scene("res://Level1.tscn")



func handlehit():
	queue_free()




func _on_attackarea_body_entered(body):
	player = body
	if body.position.x > $AnimatedSprite.position.x:
		$AnimatedSprite.flip_h = true


func _on_attackarea_body_exited(body):
	player = null
