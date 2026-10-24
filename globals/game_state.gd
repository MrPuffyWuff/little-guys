extends Node

var cur_player : Player = null
var current_items: Array[String] = []
signal new_top_node

var player_a : Player
var player_b : Player

var top_player : Player = null
var bot_player : Player = null:
	set(value):
		bot_player = value
		if bot_player == null:
			return
		elif bot_player == player_a:
			top_player = player_b
		else:
			top_player = player_a
		new_top_node.emit()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#print('BOT:', bot_player.name if bot_player else 'null','TOP:', top_player.name if top_player else 'null')
