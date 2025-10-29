extends Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	animated_sprite_2d.play("idle")
	
func _on_body_entered(body: Node2D) -> void:
	if(body is CharacterBody2D):
		GameplayManager.add_points(5)
		$CollisionShape2D.set_deferred("disabled", true)
		animated_sprite_2d.play("obtained")
		await animated_sprite_2d.animation_finished
		queue_free()
