extends CharacterBody2D

@export var movement_speed := 30.0
@onready var enemy_sprite = $Cowboy_Weak_Sprite
@export var hp = 10

@onready var player = get_tree().get_first_node_in_group("player")

# Handles physics and enemy movement
func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction*movement_speed
	move_and_slide()
	play_animation(direction)
	
func play_animation(direction) -> void:
	enemy_sprite.play("walk")
	if direction.x > 0.1:
		enemy_sprite.flip_h = false
	elif direction.x < -0.1:
		enemy_sprite.flip_h =true
