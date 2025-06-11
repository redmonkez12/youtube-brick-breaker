extends Node

signal on_hit_brick(points: int)

signal on_reduce_lives(lives: int)

func emit_hit_brick(points: int) -> void:
	on_hit_brick.emit(points)

func emit_reduce_lives(lives: int) -> void:
	on_reduce_lives.emit(lives)
