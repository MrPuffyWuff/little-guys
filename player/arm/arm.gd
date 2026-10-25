extends RigidBody2D

class_name Arm

const MAX_STRENGTH : float = 5

@export var anchor : Player

var max_dist : float = 48
var max_dist_squared : float = max_dist**2

var min_dist : float = 16
var min_dist_squared : float = min_dist**2

const MC_BLUE_HAND = preload("uid://dl4ju3ryod4rg")
const MC_RED_HAND = preload("uid://xh1qxnw75dij")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameState.new_top_node.connect(change_hand_sprite)


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	
	if GameState.top_player:
		anchor = GameState.top_player
	
	var p = (get_global_mouse_position() - global_position) * 0.1
	var d = (get_global_mouse_position() - (global_position + linear_velocity * 0.3)) * 0.2
	
	var arm_vec : Vector2 = global_position - anchor.global_position
	
	$ArmLine.set_point_position(1, -arm_vec)
	
	var len_sq : float = arm_vec.length_squared()
	
	if len_sq == max_dist and arm_vec.dot(p+d) > 0:
		return
	
	var tot_impulse : Vector2 = (p + d).clamp(Vector2.ONE * -MAX_STRENGTH, Vector2.ONE * MAX_STRENGTH)
	apply_central_impulse(tot_impulse)
	
	if len_sq > max_dist_squared:
		global_position = arm_vec.normalized() * max_dist + anchor.global_position
		position -= linear_velocity * 0.01
		linear_velocity = Vector2.ZERO
	elif len_sq < min_dist_squared:
		global_position = arm_vec.normalized() * min_dist + anchor.global_position
		position -= linear_velocity * 0.01
		linear_velocity = Vector2.ZERO

func change_hand_sprite() -> void:
	if GameState.top_player == GameState.player_a:
		$AnimatedSprite2D.play("blue")
	else:
		$AnimatedSprite2D.play("red")
