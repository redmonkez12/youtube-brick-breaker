extends Node2D

@onready var brickObject = preload("res://scenes/Brick.tscn")

var columns = 32
var rows = 7
var marginLeft = 50
var marginTop = 70

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setupLevel()
	
func setupLevel() -> void:
	var colors = getColors()
	
	for r in rows:
		for c in columns:
			var randomNumber = randi_range(0, 2)
			if randomNumber > 0:
				var newBrick = brickObject.instantiate()
				add_child(newBrick)
				newBrick.position = Vector2(marginLeft + (34 * c), marginTop + (34 * r))
				
				var sprite = newBrick.get_node("Sprite2D")
				if r <= 7:
					sprite.modulate = colors[0]
				if r < 5:
					sprite.modulate = colors[1]
				if r < 3:
					sprite.modulate = colors[2]
				if r <= 1:
					sprite.modulate = colors[3]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func getColors() -> Array:
	var colors = [
		Color(0.2, 0.8, 0.4, 1),
		Color(0.9, 0.3, 0.1, 1),
		Color(0.1, 0.4, 0.9, 1),
		Color(0.8, 0.2, 0.8, 1), 
	];
	
	return colors
