extends RigidBody2D

class_name Player

const SPEED = 75.0
const JUMP_STRENGTH = 400.0 * 75
@export var JUMP_COOLDOWN: float = 0.75
var JUMP_ON_COOLDOWN = false


func _ready() -> void:
	#await get_tree().process_frame
	#GameState.new_top_node.connect(_on_new_top_node)
	pass

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	
	var is_on_floor : bool = false
	
	for body in get_colliding_bodies():
		if body is TileMapLayer or (body.has_meta("is_floor") and body.get_meta("is_floor")):
			is_on_floor = true
			#if not GameState.bot_player:
				#GameState.bot_player = self
			break
	#if not is_on_floor:
		#if GameState.bot_player == self:
			#GameState.bot_player = null
	
	if GameState.top_player == GameState.player_a:
		$Body.rotation = lerp($Body.rotation, 0.0, state.step * 5.0)
	else:
		$Body.rotation = lerp($Body.rotation, PI, state.step * 5.0)
	
	if GameState.top_player:
		var angle : float = (GameState.top_player.position - GameState.bot_player.position).angle()
		var offset : float = abs(-PI/2 - angle)
		if offset > 0.5:
			$Body.play("worry")
			JUMP_COOLDOWN = 1.25
		else:
			$Body.play("default")
			JUMP_COOLDOWN = 0.75
	
	if GameState.bot_player != self:
		return
	
	#print(self.name)
	if is_on_floor and Input.is_action_just_pressed("player_jump"):
		if not JUMP_ON_COOLDOWN:
			apply_central_force(Vector2.UP * JUMP_STRENGTH)
			SFX.play(SFX.Id.JUMP)
			JUMP_ON_COOLDOWN = true
			print(JUMP_COOLDOWN)
			await get_tree().create_timer(JUMP_COOLDOWN).timeout
			JUMP_ON_COOLDOWN = false

	var direction := Input.get_axis("player_left", "player_right")
	if direction:
		linear_velocity.x = SPEED * direction
	else:
		linear_velocity.x = move_toward(linear_velocity.x, 0, SPEED)
	
	#print(linear_velocity.x)
