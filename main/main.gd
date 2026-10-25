extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameState.player_a = $Top
	GameState.player_b = $Bottom
	GameState.playing = true
