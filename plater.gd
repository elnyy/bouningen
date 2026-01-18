extends Area2D

@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		$Control/AnimatedSprite2D.flip_h = false
	elif Input.is_action_pressed("move_left"):
		velocity.x -= 1
		$Control/AnimatedSprite2D.flip_h = true

	if velocity.length() > 0:
		$Control/AnimatedSprite2D.play()
		velocity = velocity.normalized() * speed
		position += velocity * delta
		position = position.clamp(Vector2.ZERO, screen_size)
	else:
		$Control/AnimatedSprite2D.stop()
