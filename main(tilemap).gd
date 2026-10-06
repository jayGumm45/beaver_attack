extends Node

var timer

signal lose

func game_over():
	$CountdownTimer.stop()
	$HUD.show_game_over()
	lose.emit()
	
	
func new_game():
	timer = 10
	$HUD.update_timer(timer)
	$HUD.show_message("Get Ready")
	await get_tree().create_timer(1.0).timeout
	$HUD.hide_message()
	$CountdownTimer.start()

func _on_countdown_timer_timeout():
	timer -= 1
	$HUD.update_timer(timer)
	if timer <=0:
		$CountdownTimer.stop()
		game_over()


func _on_win() -> void:
	$CountdownTimer.stop()
