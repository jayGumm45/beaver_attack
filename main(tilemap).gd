extends Node

var timer
# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func game_over():
	$CountdownTimer.stop()

func new_game():
	timer = 10
#	$Player.start($StartPosition.position)
	$CountdownTimer.start()
	
func _on_count_down_timeout():
	timer -= 1
