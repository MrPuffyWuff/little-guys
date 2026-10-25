extends CharacterBody2D

var colors: Array = [
	"blue",
	"green",
	"orange",
	"pink",
	"yellow",
]

const SPEED: int = 50
var x_direction = 1

var player_in_radius = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play(colors[randi_range(0,4)])
	$Alert.visible = false

func _physics_process(_delta: float) -> void:
	if is_on_wall():
		x_direction *= -1
		if x_direction == 1:
			$AnimatedSprite2D.flip_h = false
		else:
			$AnimatedSprite2D.flip_h = true
	
	velocity.x = SPEED * x_direction
	move_and_slide()
	
func _process(delta: float) -> void:
	if player_in_radius and GameState.fallen_over and $AlertTimer.is_stopped():
		$AlertTimer.start()
		$Alert.visible = true
	
	if not player_in_radius or not GameState.fallen_over:
		$AlertTimer.stop()
		$Alert.visible = false
	
	if $AlertTimer.time_left >= ($AlertTimer.wait_time / 5.0) * 4:
		$Alert.frame = 0
	elif $AlertTimer.time_left >= ($AlertTimer.wait_time / 5.0) * 3:
		$Alert.frame = 1
	elif $AlertTimer.time_left >= ($AlertTimer.wait_time / 5.0) * 2:
		$Alert.frame = 2
	elif $AlertTimer.time_left >= ($AlertTimer.wait_time / 5.0) * 1:
		$Alert.frame = 3
	elif $AlertTimer.time_left > ($AlertTimer.wait_time / 5.0) * 0:
		$Alert.frame = 4
		get_tree().change_scene_to_file("res://main/main.tscn")

func _on_detection_radius_body_entered(_body: Node2D) -> void:
	player_in_radius = true
	
func _on_detection_radius_body_exited(_body: Node2D) -> void:
	player_in_radius = false
