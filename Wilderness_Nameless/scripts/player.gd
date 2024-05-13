extends CharacterBody2D

var SPEED = 40.0

func _physics_process(_delta):
	movement()

## Handles player movement
func movement() -> void:
	# Picks the direction the player is pressing on the keiboard, and calculates where the player is going
	var x_movement = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y_movement = Input.get_action_strength("down") - Input.get_action_strength("up")
	var movement = Vector2(x_movement, y_movement)
	velocity = movement.normalized()*SPEED
	move_and_slide()
