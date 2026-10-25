class_name PickupDoor
extends Area2D


@export var needed_item_name: String
@export var item_sprite: Sprite2D
@export var collider: CollisionShape2D


func _on_body_entered(body: Node2D) -> void:
	if body is Player or body is Arm:
		# Allow passing through if the item was collected
		if needed_item_name in GameState.current_items:
			GameState.current_items.remove_at(GameState.current_items.find(needed_item_name))
			GameState.items_change.emit()
			item_sprite.self_modulate.a = 0.6
			SFX.play(SFX.Id.WIN)
			collider.set_deferred("disabled", true)
			set_deferred("monitoring", false)
