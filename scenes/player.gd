extends CharacterBody2D

@export var speedMax := 200
@export var speedMin := -100
@export var acceleration := 1
var speed := 0
@export var rotation_speed := 1.5

var rotation_direction := 0.0

func get_input():
	rotation_direction = Input.get_axis("left", "right")
	speed += acceleration * Input.get_axis("down", "up")
	if speed > speedMax:
		speed = speedMax
	elif speed < speedMin:
		speed = speedMin
	

func _physics_process(delta):
	get_input()
	velocity = transform.y * speed
	rotation += rotation_direction * rotation_speed * delta
	move_and_slide()
