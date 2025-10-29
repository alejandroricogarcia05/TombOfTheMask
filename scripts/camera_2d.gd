extends Camera2D
@onready var character_body_2d: CharacterBody2D = $"../CharacterBody2D"

func _process(delta: float) -> void:
	position.y = character_body_2d.position.y
