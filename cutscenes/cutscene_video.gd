extends VideoStreamPlayer


@export_file("*.tscn") var next_scene

func _ready() -> void:
	# This music automatically plays, not sure if it's needed for the cutscene
	Music.stop()


func _on_finished() -> void:
	# Restart the music if it's needed
	Music.play()
	GameState.playing = false
	get_tree().call_deferred("change_scene_to_file", next_scene)
