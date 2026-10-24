extends RigidBody2D

class_name Player

const SPEED = 50.0
const JUMP_VELOCITY = -500.0


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	
	var is_on_floor : bool = false
	
	for body in get_colliding_bodies():
		if body is TileMapLayer or (body.has_meta("is_floor") and body.get_meta("is_floor")):
			is_on_floor = true
			if not GameState.bot_player:
				GameState.bot_player = self
			break
	if not is_on_floor:
		if GameState.bot_player == self:
			GameState.bot_player = null
	
	if GameState.bot_player != self:
		return
	
	#print(self.name)
	
	if is_on_floor and Input.is_action_just_pressed("player_jump"):
		linear_velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("player_left", "player_right")
	if direction:
		linear_velocity.x = SPEED * direction
	else:
		linear_velocity.x = move_toward(linear_velocity.x, 0, SPEED)
	#print(linear_velocity.x)
	
