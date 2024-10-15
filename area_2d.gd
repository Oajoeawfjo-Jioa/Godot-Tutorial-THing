extends Area2D

signal hit

@export var speed = 400.0
var screen_size = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	print(screen_size)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
		
	if direction.length() > 1:
		direction = direction.normalized()
		
	if direction.length() > 0:
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
			
	position += direction * speed * delta
	
	# $ thing refers to nodes?
	
	if direction.x != 0:
		$AnimatedSprite2D.animation = "right"
		$AnimatedSprite2D.flip_h = direction.x < 0 
		$AnimatedSprite2D.flip_v = false
	elif direction.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = direction.y > 0 

		
	# clamp position of robot between 0 and screen_size
	
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	 # Replace with function body.

func start(x, y):
	position.x = x
	position.y = y
	show()
	$CollisionShape2D.disabled = false
	 

func _on_body_entered(body: Node2D) -> void:
	hide() 
	$CollisionShape2D.set_deferred("disabled", true) # wait for physics frame to end before doing it 
	emit_signal("hit")
