extends Area2D
var ghosthealth = 4
var diretionofplayer = 1
var playerhealth = 5



func _on_attack_body_entered(body):
	ghosthealth -= 1
	
	if body.has_method("handlehit"):
		if ghosthealth == 0:
			body.handlehit()



