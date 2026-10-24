extends Node

var current_items: Array[String] = []
signal new_top_node

##Default Top
var player_a : Player
##Default Bot
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
func _process(delta: float) -> void:
	
	if abs(player_a.global_position.y - player_b.global_position.y) < 8:
		return
	
	if player_a.global_position.y > player_b.global_position.y:
		bot_player = player_a
	elif player_a.global_position.y < player_b.global_position.y:
		bot_player = player_b
	print('BOT:', bot_player.name if bot_player else 'null','TOP:', top_player.name if top_player else 'null')
