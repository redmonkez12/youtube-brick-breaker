extends Node

signal on_hit_brick(points: int)
signal on_reduce_lives(lives: int)
signal on_game_over()
signal on_reset_ball_and_paddle()

func emit_hit_brick(points: int) -> void:
	on_hit_brick.emit(points)

func emit_reduce_lives(lives: int) -> void:
	on_reduce_lives.emit(lives)

func emit_game_over() -> void:
	on_game_over.emit()

func emit_reset_ball_and_paddle() -> void:
	on_reset_ball_and_paddle.emit()
