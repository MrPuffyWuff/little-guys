extends RigidBody2D

const SPEED: float = 200.0
const MINIMUM_SPEED: float = 1.0

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	var mouse_position: Vector2 = get_local_mouse_position().limit_length(50)
	var distance = mouse_position.length()
	var direction = mouse_position.normalized()
	var magnitude = pow(distance / 10, 2)
	
	state.linear_velocity = SPEED * direction * magnitude
	
	if position.length() >= 180:
		position = Vector2(0,0)
		state.linear_velocity = Vector2(0,0)
		
	state.angular_velocity = 0
	rotation = 0
