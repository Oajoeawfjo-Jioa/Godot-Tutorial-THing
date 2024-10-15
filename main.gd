extends Node

var score = 0


func _ready():
	randomize()
	
func new_game():
	score = 0
	get_tree().call_group("Mob", "queue_free")
	
	#screen_size = get_viewport_rect().size
	#scuffed but works ig
	$Area2D.start(480/2,720/2)
	$HUD.update_score(score)
	
	$HUD.show_message("Get ready...")
	
	#wait for startimer
	await get_tree().create_timer(2.0).timeout
	$ScoreTimer.start()
	$MobTimer.start()
	
func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	
func _on_mob_timer_timeout() -> void:
	#how do you do you like me and i like you
	var mob_scene = load("res://animated_sprite_2d.tscn").instantiate()
	
	#sets a random location for the mobs to spawn in$MobTimer
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
		
	#var mob := mob_scene as Node
	var mob = mob_scene
	add_child(mob)
	
	#set position of mob
	mob.position = mob_spawn_location.position
	
	#set rotation of mob to random rotation
	var direction = mob_spawn_location.rotation + PI / 2
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	#set magnitude of vector to a random number
	var velocity = Vector2(randf_range(mob.min_speed, mob.max_speed), 0)
	
	#give velocity a direction
	mob.linear_velocity = velocity.rotated(direction)
	

func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)


	
