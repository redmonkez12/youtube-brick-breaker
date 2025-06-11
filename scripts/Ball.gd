extends CharacterBody2D

var speed = 200.0
var dir = Vector2.DOWN
var is_active = true

var level = 3
@export var lives: int = 3
var start_position: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_position = position  # Remember starting position
	speed = speed + (20 * level)
	velocity = Vector2(speed * -1, speed)
	SignalHub.emit_reduce_lives(lives)
	SignalHub.on_reset_ball_and_paddle.connect(reset_ball)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if is_active:
		var collision = move_and_collide(velocity * delta)
		
		if collision:
			velocity = velocity.bounce(collision.get_normal())
			if collision.get_collider().has_method("hit"):
				collision.get_collider().hit()
				
		if velocity.y > 0 and velocity.y < 100:
			velocity.y = -200
			
		if velocity.x == 0:
			velocity.x = -200

func gameOver() -> void:
	SignalHub.emit_game_over()

func _on_deathzone_body_entered(body: Node2D) -> void:
	if body == self:
		is_active = false

		lives -= 1
		SignalHub.emit_reduce_lives(lives)
		
		if lives <= 0:
			gameOver()
		else:
			SignalHub.emit_reset_ball_and_paddle()
			await get_tree().create_timer(0.5).timeout
			is_active = true

func reset_ball() -> void:
	position = start_position
	velocity = Vector2(speed * -1, speed)

func reduce_lives(reduction: int) -> bool:
	lives -= reduction
	SignalHub.emit_reduce_lives(lives)
	if lives <= 0:
		set_physics_process(false)
		return true
		
	return false

func level_over() -> void:
	get_tree().paused = true
