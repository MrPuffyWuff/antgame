extends CharacterBody2D

@export var speedMax := 200
@export var speedMin := -100
@export var acceleration := 1
@export var rotation_speed := 1.5

var speed := 0
var health := 10
var target_velocity : Vector2
var rotation_direction := 0.0

func take_damage(damageStats : DmgPacket):
	print("Ow")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	move_and_slide()
