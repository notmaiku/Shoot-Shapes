extends Node3D

func _ready():
	pass

func spawn_enemy():
	var enemy_scene = preload("res://enemy_2.tscn") 
	var enemy_instance = enemy_scene.instantiate() 
	var spawn_position = self.global_transform.origin  
	
	# Add some randomness to spawn position
	spawn_position.x = 18
	spawn_position.y = 0
	spawn_position.z = -31
	var rand_x = randf_range(-3, 3)
	var rand_y = randf_range(-3, 3)
	var rand_z = randf_range(-2, 2)
	
	spawn_position += Vector3(rand_x, rand_y, rand_z)  
	if rand_y + spawn_position.y <= -1 :
		spawn_position.y = 0
	
	enemy_instance.global_transform.origin = spawn_position 
	add_child(enemy_instance)

func _on_enemy_timer_timeout():
	spawn_enemy()
