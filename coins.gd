extends Area2D

signal coin_collected

func _on_coins_body_entered(body):
	$AnimationPlayer.play("updown")
	emit_signal("coin_collected")
	$CollisionShape2D.disabled = true
	set_collision_mask_bit(0, false)
	

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
