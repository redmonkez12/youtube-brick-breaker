extends CharacterBody2D

const SPEED = 900.0
var start_position: Vector2

func _ready() -> void:
	start_position = position  # Remember starting position
	SignalHub.on_reset_ball_and_paddle.connect(reset_paddle)

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func reset_paddle() -> void:
	# Reset paddle to starting position
	position = start_position
	# Stop any movement
	velocity = Vector2.ZERO
