extends CharacterBody2D

var colors: Array = [
	"blue",
	"green",
	"orange",
	"pink",
	"yellow",
]

var SPEED: int = 50
var x_direction = 1

var player_in_radius = false

var alert_level = 0:
	set(new_value):
		print(alert_level)
		alert_level = clampi(new_value, -1, 4)
		if alert_level == -1:
			$Alert.visible = false
		else:
			$Alert.visible = true
			$Alert.frame = clampi(alert_level, 0, 4)
		
		if alert_level == 4:
			get_tree().paused = true
			SFX.play(SFX.Id.LOSE)
			await get_tree().create_timer(4).timeout
			get_tree().paused = false
			get_tree().change_scene_to_file("res://main/main.tscn")

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
		print("hi")
		alert_level += 1
		SFX.play(SFX.Id.ALERT)
		SPEED = 0
		$AlertTimer.start()
	elif $AlertTimer.is_stopped():
		$AlertTimer.start()
		SPEED = 50
		alert_level -= 1
	
func _on_detection_radius_body_entered(_body: Node2D) -> void:
	player_in_radius = true
	
func _on_detection_radius_body_exited(_body: Node2D) -> void:
	player_in_radius = false
