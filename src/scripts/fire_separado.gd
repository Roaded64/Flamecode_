extends Node2D

@export var is_active = false
@export var fogoID: int

func _ready() -> void:
	if !is_active:
		$".".visible = false
	
	$AnimatedSprite2D.play("default")

func _process(delta: float) -> void:
	if is_active:
		$".".visible = true
	if !is_active:
		$".".visible = false
