extends CanvasLayer

var coins = 0

func _ready():
	$coins.text = String(coins)

func _physics_process(delta):
	if coins == 3:
		get_tree().change_scene("res://gameover.tscn")
	


func _on_coins_coin_collected():
	coins += 1
	_ready()
