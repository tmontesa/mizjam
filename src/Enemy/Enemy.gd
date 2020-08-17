extends KinematicBody2D

onready var stats = $Stats
var target = null
var speed = 70

var velocity = Vector2.ZERO
var direction = Vector2.ZERO

var is_moving

func _physics_process(delta: float) -> void:
	if (target != null):
		direction = (target.position - position).normalized()
	else:
		direction = Vector2.ZERO

	if (direction == Vector2.ZERO):
		var friction = stats.friction
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		is_moving = false
	else:
		var max_speed = stats.max_speed
		var acceleration = stats.acceleration
		velocity = velocity.move_toward(direction * max_speed, acceleration * delta)
		is_moving = true

	move_and_slide(velocity)

func _on_body_detected(body: Node) -> void:
	if (body.name == "Player"):
		target = body

func _on_body_undetected(body: Node) -> void:
	if (body == target):
		target = null
