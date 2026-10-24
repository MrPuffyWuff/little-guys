extends RigidBody2D

class_name Player

const SPEED = 100.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	
	var is_on_floor : bool = false
	
	for body in get_colliding_bodies():
		if body is TileMapLayer:
			is_on_floor = true
			if not GameState.cur_player:
				GameState.cur_player = self
			break
	if not is_on_floor:
		if GameState.cur_player == self:
			GameState.cur_player = null
		return
	
	if GameState.cur_player != self:
		return
	
	print(self.name)
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		linear_velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		linear_velocity.x = SPEED * direction
	else:
		linear_velocity.x = move_toward(linear_velocity.x, 0, SPEED)
