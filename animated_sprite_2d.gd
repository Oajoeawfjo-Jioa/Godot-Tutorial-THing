extends RigidBody2D

@export var min_speed = 150.0
@export var max_speed = 250.0

# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	position.x = 0
	position.y = 0
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	
	print(mob_types)
	$AnimatedSprite2D.animation = mob_types[randi() % mob_types.size()]
	$AnimatedSprite2D.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	#free monster delete it when leaves the screen


	
