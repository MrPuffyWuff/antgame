extends CharacterBody2D

var target_velocity := Vector2(0,1)
var speed = 10
var size = "LARGE"

func setTargetVelocity(inputVel : Vector2) -> void:
	target_velocity = inputVel.normalized()
	target_velocity *= speed

func setSize(inputSize : String):
	size = inputSize
	print(size)
	if size == "LARGE":
		$LargeCollision.visible = true
		$LargeSprite.visible = true
		$MediumCollision.visible = false
		$MediumSprite.visible = false
	elif size == "MEDIUM":
		$LargeCollision.visible = false
		$LargeSprite.visible = false
		$MediumCollision.visible = true
		$MediumSprite.visible = true

func _physics_process(delta: float) -> void:
	velocity = target_velocity
	move_and_collide(velocity)
