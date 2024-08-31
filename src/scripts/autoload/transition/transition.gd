extends CanvasLayer

@onready var anim_player = $AnimationPlayer
@onready var color = $ColorRect

func change_scene(target: String):
	color.visible = true
	anim_player.play("transition")
	
	await anim_player.animation_finished
	get_tree().change_scene_to_file(target)
	
	anim_player.play_backwards("transition")
	
	await anim_player.animation_finished
	color.visible = false
