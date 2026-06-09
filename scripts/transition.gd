extends Node3D

@onready var rect_out = $CanvasLayer/RectOut
@onready var rect_in = $CanvasLayer/RectIn
@onready var text_container  = $CanvasLayer/TextContainer
@onready var anim_player  = $CanvasLayer/TextContainer/AnimationPlayer

func _ready():
	rect_out.visible = false
	rect_in.visible = false
	text_container.visible = false
	
func to_scene(scene_full_path: String, time: float) -> void:	
	await Transition.transition_out(time)
	await text_in_animation()
	get_tree().change_scene_to_file(scene_full_path)	
	await text_out_animation()
	await Transition.transition_in(time)
	
func text_in_animation() -> void:
	anim_player.play("text_in")
	anim_player.seek(0, true);
	text_container.visible = true
	await anim_player.animation_finished		
	
func text_out_animation() -> void:
	anim_player.play("text_out")
	anim_player.seek(0, true);
	await anim_player.animation_finished		
	text_container.visible = false
		
func transition_out(time: float) -> void:
	rect_out.visible = true
	rect_in.visible = false

	var material := rect_out.material as ShaderMaterial
	material.set_shader_parameter("t", 0.0)

	var tween = create_tween()
	tween.tween_method(
		func(value):
			material.set_shader_parameter("t", value),
		0.0,
		1.0,
		time
	)

	await tween.finished	
	
func transition_in(time: float) -> void:
	rect_in.visible = true
	rect_out.visible = false
	
	var material := rect_in.material as ShaderMaterial
	material.set_shader_parameter("t", 0.0)	
	
	var tween = create_tween()
	tween.tween_method(
		func(value):
			material.set_shader_parameter("t", value),
		0.0,
		1.0,
		time
	)

	await tween.finished	

	rect_in.visible = false
