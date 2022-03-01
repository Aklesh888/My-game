extends Area2D

const speed = 2000
var velocity = Vector2.ZERO
var direction = 1

func _ready():
	pass

func _physics_process(delta):
	velocity.x = speed * delta * direction
	translate(velocity)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func set_kunai_direction(dir):
	direction = dir
	if dir == -1:
		$sprite.flip_v = true


func _on_kunai_body_entered(body):
	Attack.ghosthealth -= 1
	print(Attack)
	queue_free()
	print(Attack.ghosthealth)
	if body.has_method("handlehit"):
		if Attack.ghosthealth == 0:
			body.handlehit()
			
