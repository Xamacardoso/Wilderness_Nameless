extends CharacterBody2D

@onready var player_sprite = $Player_Sprite

var SPEED = 40.0
var hp = 80

func _physics_process(_delta):
	movement()

## Handles player movement
func movement() -> void:
	# Picks the direction the player is pressing on the keiboard, and calculates where the player is going
	var x_movement = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y_movement = Input.get_action_strength("down") - Input.get_action_strength("up")
	var movementvector = Vector2(x_movement, y_movement)
	velocity = movementvector.normalized()*SPEED
	play_animation(x_movement, y_movement)
	move_and_slide()
	
	
## Handles movement animation
func play_animation(x_movement,y_movement) -> void:
	if velocity:
		if x_movement:
			player_sprite.play("walk_horizontal")
			player_sprite.flip_h = false if x_movement > 0 else true
		else:
			if y_movement:
				if y_movement > 0:
					player_sprite.play("walk_down")
				elif y_movement < 0:
					player_sprite.play("walk_up")
	else:
		player_sprite.play("idle")






func _on_hurt_box_hurt(damage):
	hp -= damage
	print(hp)
