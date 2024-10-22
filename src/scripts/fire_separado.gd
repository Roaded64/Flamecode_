extends Node2D

@export var is_active = false
@export var fogoID: int

func _ready() -> void:
	if !is_active:
		$".".visible = false
		$StaticBody2D/CollisionShape2D.disabled = true
	
	$AnimatedSprite2D.play("default")

func _process(delta: float) -> void:
	if is_active: # burrice isso é pra quando estiver ativado
		$".".visible = true
		$StaticBody2D/CollisionShape2D.disabled = false
	if !is_active:
		$".".visible = false
		$StaticBody2D/CollisionShape2D.disabled = true 
