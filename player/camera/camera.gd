extends Camera2D

@export var node_a : Node2D
@export var node_b : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position = (node_a.global_position + node_b.global_position)/2
