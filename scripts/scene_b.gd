extends Node3D

func _on_btn_load_pressed() -> void:
	Transition.to_scene("res://scenes/scene_a.tscn", 1.0)
