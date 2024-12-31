extends CharacterBody2D

var target_velocity_dir := Vector2(0,1)
var speed := 100
var size : String
var speed_resistance := 1
var speed_cutoff := 25
var life_time : float = 0.75
var appliedDamage : DmgPacket

func setTargetVelocityDir(inputVel : Vector2) -> void:
	target_velocity_dir = inputVel.normalized()

func addTargetVelocityDir(inputVel : Vector2) -> void:
	target_velocity_dir = target_velocity_dir.normalized() * speed
	target_velocity_dir += inputVel
func setSize(inputSize : String):
	size = inputSize
	$LargeArea.monitoring = false
	$LargeSprite.visible = false
	
	$MediumArea.monitoring  = false
	$MediumSprite.visible = false
	
	$SmallArea.monitoring  = false
	$SmallSprite.visible = false
	if size == "LARGE":
		$LargeArea.monitoring  = true
		$LargeSprite.visible = true
	elif size == "MEDIUM":
		$MediumArea.monitoring  = true
		$MediumSprite.visible = true
	elif size == "SMALL":
		$SmallArea.monitoring  = true
		$SmallSprite.visible = true

func start_life():
	$Lifespan.wait_time = life_time
	$Lifespan.start()

func _physics_process(delta: float) -> void:
	velocity = target_velocity_dir
	#Ball Resistance Code
	target_velocity_dir -= target_velocity_dir.normalized() * speed_resistance
	
	if velocity.length() < speed_cutoff:
		kill_self()
		print("To slow")
	move_and_slide()

func kill_self():
	queue_free()

func _on_area_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(appliedDamage)
	kill_self()


func _on_lifespan_timeout() -> void:
	kill_self()
