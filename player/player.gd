extends RigidBody2D

class_name Player

const SPEED = 75.0
const JUMP_STRENGTH = 400.0 * 75

@onready var sprite_height = $Body.sprite_frames.get_frame_texture("default", $Body.frame).get_size().y
@onready var coll_pos = $CollisionShape2D.position
@onready var coll_target = coll_pos + Vector2(0, sprite_height * 3/4)
@onready var coll2_pos = $CollisionShape2D2.position
@onready var coll2_target = coll2_pos + Vector2(0, sprite_height * 3/4)


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
		
		# Only start realigning the collision shapes when the angle isn't too sharp
		# to avoid weird collision stuff
		if abs($Body.rotation - 0.0) <= PI / 2:
			$CollisionShape2D.position = lerp($CollisionShape2D.position, coll_pos, state.step * 5.0)
			$CollisionShape2D2.position = lerp($CollisionShape2D2.position, coll2_pos, state.step * 5.0)
	else:
		$Body.rotation = lerp($Body.rotation, PI, state.step * 5.0)
		
		if abs($Body.rotation - PI) <= PI / 2:
			$CollisionShape2D.position = lerp($CollisionShape2D.position, coll_target, state.step * 5.0)
			$CollisionShape2D2.position = lerp($CollisionShape2D2.position, coll2_target, state.step * 5.0)
	
	
	if GameState.bot_player != self:
		return
	
	#print(self.name)
	if is_on_floor and Input.is_action_just_pressed("player_jump"):
		apply_central_force(Vector2.UP * JUMP_STRENGTH)

	var direction := Input.get_axis("player_left", "player_right")
	if direction:
		linear_velocity.x = SPEED * direction
	else:
		linear_velocity.x = move_toward(linear_velocity.x, 0, SPEED)
	#print(linear_velocity.x)
