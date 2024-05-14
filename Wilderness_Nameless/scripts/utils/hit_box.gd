extends Area2D

@export var damage = 1
@onready var collision = $CollisionShape2D
@onready var disable_timer = $DisableHitBoxTimer

func tempdisable():
	collision.call_deferred("set", "disabled", true)
	disable_timer.start()

func _on_disable_hit_box_timer_timeout():
	collision.call_deferred("set", "disabled", false)
