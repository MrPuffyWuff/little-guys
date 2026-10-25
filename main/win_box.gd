extends Area2D

@export_file("*.tscn") var end_cutscene

var in_transition = false


func _on_body_entered(body: Node2D) -> void:
	if not in_transition and body is Player:
		in_transition = true
		
		var tween = $CanvasModulate.create_tween()
		tween.tween_property($CanvasModulate, "color", Color(0, 0, 0), 2.0)
		tween.play()
		
		await tween.finished
		
		get_tree().call_deferred("change_scene_to_file", end_cutscene)
