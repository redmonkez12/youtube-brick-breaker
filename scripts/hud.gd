extends Control

@onready var score_label: Label = $MarginContainer/ScoreLabel
@onready var hb_hearts: HBoxContainer = $MarginContainer/HbHearts

var _score: int = 0
var _hearts: Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_hearts = hb_hearts.get_children()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _enter_tree() -> void:
	SignalHub.on_hit_brick.connect(on_scored)
	SignalHub.on_reduce_lives.connect(on_reduce_lives)

func on_scored(points: int) -> void:
	_score += points
	score_label.text = "%05d" % _score

func on_reduce_lives(lives: int) -> void:
	for index in range(_hearts.size()):
		_hearts[index].visible = lives > index
