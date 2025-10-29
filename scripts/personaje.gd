extends CharacterBody2D

@export var speed: float = 200
var direction:Vector2 = Vector2.UP
var can_move:bool = false
var up_dir:Vector2 = Vector2.UP
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	animated_sprite_2d.flip_v = true
func _input(event: InputEvent) -> void:
	if can_move:
		if event.is_action_pressed("arriba"):
			direction = Vector2.UP
			can_move = false
			animated_sprite_2d.play("moving")
			animated_sprite_2d.flip_v = true
			rotation = 0
		if event.is_action_pressed("abajo"):
			direction = Vector2.DOWN 
			can_move = false
			animated_sprite_2d.play("moving")
			animated_sprite_2d.flip_v = false
			rotation = 0
		if event.is_action_pressed("derecha"):
			direction =  Vector2.RIGHT 
			can_move = false
			animated_sprite_2d.play("moving")
			animated_sprite_2d.flip_v = false
			rotation_degrees = -90
		if event.is_action_pressed("izquierda"):
			direction = Vector2.LEFT 
			can_move = false
			animated_sprite_2d.play("moving")
			animated_sprite_2d.flip_v = false
			rotation_degrees = 90
		
		
func _physics_process(delta):
	if direction != Vector2.ZERO:
		var collision = move_and_collide(direction * speed * delta)
		if collision:
			var collider = collision.get_collider()
			if collider is TileMapLayer:
				print("Colisionó con: ", collider.name, " - Grupos: ", collider.get_groups())
				if collider.is_in_group("Ground"):
					print("ha tocado ground")
					animated_sprite_2d.play("idle")
					var normal = collision.get_normal()
					if normal == -direction:
						can_move = true
						direction = Vector2.ZERO
				else:
					print("ha tocado pinchos")
					velocity = Vector2.ZERO
					animated_sprite_2d.play("death")
					await animated_sprite_2d.animation_finished
					GameplayManager.reset()
		else:
			move_and_collide(direction * speed * delta)
			
