extends Line2D

@onready var hand: RigidBody2D = $"../Hand"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var mouse_position = hand.position
	self.clear_points()
	self.add_point(Vector2(0,0))
	self.add_point(Vector2(mouse_position.x / 2, (mouse_position.y / 2) + 15), 1)
	self.add_point(mouse_position)
