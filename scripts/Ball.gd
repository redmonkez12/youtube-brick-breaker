extends CharacterBody2D

var speed = 200.0
var dir = Vector2.DOWN
var is_active = true

var level = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speed = speed + (20 * level)
	velocity = Vector2(speed * -1, speed)


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
			velocity.x - 200
