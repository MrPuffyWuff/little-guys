class_name Pickup
extends Area2D


@export var item_name: String
@export var item_sprite: Sprite2D
@export var hand_can_pickup: bool = true


# Add item to the GameState once the player interacts with the npc
func _on_body_entered(body: Node2D) -> void:
	if body is Player or body is Arm:
		SFX.play(SFX.Id.TICKET)
		GameState.current_items.append(item_name)
		set_deferred("monitoring", false)
		
		# Hide any item sprites that are shown
		if item_sprite:
			item_sprite.visible = false
