extends Node

var fallen_over: bool = false

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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if abs(player_a.global_position.y - player_b.global_position.y) <= 4:
		fallen_over = true
	else:
		fallen_over = false
	
	if abs(player_a.global_position.y - player_b.global_position.y) < 8:
		return
	
	if player_a.global_position.y > player_b.global_position.y:
		bot_player = player_a
	elif player_a.global_position.y < player_b.global_position.y:
		bot_player = player_b
	#print('BOT:', bot_player.name if bot_player else 'null','TOP:', top_player.name if top_player else 'null')
