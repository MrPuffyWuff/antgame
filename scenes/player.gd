extends CharacterBody2D

@export var speedMax := 200
@export var speedMin := -100
@export var acceleration := 100
@export var rotation_speed := 1.5

var speed := 0
var health := 10
var target_velocity : Vector2
var rotation_direction := 0.0

const CANNONBALL = preload("res://scenes/cannonball.tscn")
var leftCannonAble := true
var rightCannonAble := true

func get_input():
	rotation_direction = Input.get_axis("left", "right")
	speed += acceleration * Input.get_axis("down", "up")
	if speed > speedMax:
		speed = speedMax
	elif speed < speedMin:
		speed = speedMin
	checkGunKeys()

func summonProjectile(size : String, markerNode : Marker2D):
	var projectile = CANNONBALL.instantiate()
	projectile.setSize(size)
	projectile.position = markerNode.global_position
	projectile.setTargetVelocityDir(markerNode.global_position - $".".global_position)
	projectile.addTargetVelocityDir(target_velocity)
	get_parent().add_child(projectile)
	markerNode.get_child(0).start()

func checkGunKeys():
	if Input.is_action_pressed("shootLeft") && leftCannonAble:
		summonProjectile("SMALL", $Left)
		leftCannonAble = false
	if Input.is_action_pressed("shootRight") && rightCannonAble:
		summonProjectile("SMALL", $Right)
		rightCannonAble = false

func take_damage(amount):
	health -= amount
	print("Player took " + str(amount) + " damage")

func setTargetVelocity(delta : float):
	target_velocity = transform.y * speed
	#Method of adding wind
	#target_velocity += Vector2(50,50)

func _physics_process(delta: float):
	get_input()
	setTargetVelocity(delta)
	velocity = target_velocity
	rotation += rotation_direction * rotation_speed * delta
	move_and_slide()
	#debug()

func debug():
	print("--Player")
	print("Speed: " + str(speed))
	print("Acceleration: " + str(acceleration))
	print("Current Vector: " + str(velocity))

func _on_left_reload_timeout() -> void:
	leftCannonAble = true


func _on_right_reload_timeout() -> void:
	rightCannonAble = true
