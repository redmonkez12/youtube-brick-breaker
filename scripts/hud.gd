extends Control

@onready var score_label: Label = $MarginContainer/ScoreLabel
@onready var hb_hearts: HBoxContainer = $MarginContainer/HbHearts
@onready var game_over_screen: ColorRect = $ColorRect

var _score: int = 0
var _hearts: Array
var _is_game_over: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_hearts = hb_hearts.get_children()
	game_over_screen.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _enter_tree() -> void:
	SignalHub.on_hit_brick.connect(on_scored)
	SignalHub.on_reduce_lives.connect(on_reduce_lives)
	SignalHub.on_game_over.connect(on_game_over)

func _input(event):
	if _is_game_over and event.is_action_pressed("Start"):
		restart_game()

func on_scored(points: int) -> void:
	_score += points
	score_label.text = "%05d" % _score

func on_reduce_lives(lives: int) -> void:
	for index in range(_hearts.size()):
		_hearts[index].visible = lives > index

func on_game_over() -> void:
	_is_game_over = true
	game_over_screen.visible = true

func restart_game() -> void:
	get_tree().reload_current_scene()
