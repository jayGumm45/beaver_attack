extends CanvasLayer

# Notifies `Main` node that the button has been pressed
signal start_game
	
	
func update_timer(timer):
	$TimerLabel.text = str(timer)
	


func _on_snack_button_pressed():
	$Snack_Screen/ColorRect.hide()
	$Snack_Screen/SnackButton.hide()
	start_game.emit()
	
