extends CanvasLayer

# Notifies `Main` node that the button has been pressed
signal start_game

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
	
func show_game_over():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	await $MessageTimer.timeout
	
	if $MessageTimer.timeout:
		$Message.text = "You Ran Out Of Time!"
	else:
		$Message.text = "You Were Caught!"
	
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()
	
func update_timer(timer):
	$TimerLabel.text = str(timer)
	

func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()
	$Message.hide()

func _on_message_timer_timeout():
	$Message.hide()

func hide_message():
	$Message.hide()


func _on_snack_button_pressed():
	$Snack_Screen/ColorRect.hide()
	$Snack_Screen/SnackButton.hide()
	
