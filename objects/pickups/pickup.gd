class_name Pickup
extends Area2D


@export var item_name: String
@export var item_sprite: Sprite2D
@export var hand_can_pickup: bool = true

@export var bob_height: float = 2.0
@export var bob_duration: float = 0.5
var bob_tween: Tween

func _ready() -> void:
	bob()
	
func bob() -> void:
	bob_tween = get_tree().create_tween().set_loops(INF)
	
	bob_tween.set_trans(Tween.TRANS_SINE)
	bob_tween.set_ease(Tween.EASE_IN_OUT)
	
	bob_tween.tween_property(self, "position:y", bob_height, bob_duration).as_relative()
	bob_tween.tween_property(self, "position:y", -bob_height, bob_duration).as_relative()

# Add item to the GameState once the player interacts with the npc
func _on_body_entered(body: Node2D) -> void:
	if body is Player or body is Arm:
		bob_tween.kill()
		SFX.play(SFX.Id.TICKET)
		GameState.current_items.append(item_name)
		GameState.items_change.emit()
		set_deferred("monitoring", false)
		
		# Hide any item sprites that are shown
		if item_sprite:
			item_sprite.visible = false
