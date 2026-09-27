extends Node

var timer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func game_over():
	$CountdownTimer.stop()
	$HUD.show_game_over()

func new_game():
	#$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	timer = 10
#	$Player.start($StartPosition.position)
	$CountdownTimer.start()
	
func _on_count_down_timeout():
	timer -= 1
	#$HUD.update_score(score)
