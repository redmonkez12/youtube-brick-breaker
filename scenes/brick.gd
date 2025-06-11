extends RigidBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func hit() -> void:
	sprite_2d.visible = false
	SignalHub.emit_hit_brick(1)
	audio_stream_player_2d.play()

	await get_tree().create_timer(1).timeout
	queue_free()
