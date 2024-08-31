extends Area2D
class_name InteractionArea

# recomendo não mexer
# fiz do jeito mais merda possivel, mas funciona, isso é o que importa
@export var outline: MeshInstance2D

var interact: Callable = func():
	pass

func _on_body_entered(body: Node2D) -> void:
	InteractionManager._register_area(self)
	
	if outline != null:
		outline.visible = true

func _on_body_exited(body: Node2D) -> void:
	InteractionManager._unregister_area(self)
	
	if outline != null:
		outline.visible = false
