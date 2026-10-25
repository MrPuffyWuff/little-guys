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
	
	if $AlertTimer.time_left >= 2.0 and $AlertTimer.time_left <= 2.5:
		$Alert.frame = 0
		
	if $AlertTimer.time_left >= 1.5 and $AlertTimer.time_left <= 2.0:
		$Alert.frame = 1
		
	if $AlertTimer.time_left >= 1.0 and $AlertTimer.time_left <= 1.5:
		$Alert.frame = 2
		
	if $AlertTimer.time_left >= 0.5 and $AlertTimer.time_left <= 1.0:
		$Alert.frame = 3
		
	if $AlertTimer.time_left > 0.0 and $AlertTimer.time_left <= 0.5:
		$Alert.frame = 4
		print("OMG U GOT CAUGHT")

func _on_detection_radius_body_entered(_body: Node2D) -> void:
	player_in_radius = true
	
func _on_detection_radius_body_exited(_body: Node2D) -> void:
	player_in_radius = false
