extends Node3D

func _ready():
	spawn_enemy()
	pass

func spawn_enemy():
	var enemy_scene = preload("res://enemy_2.tscn") 
	var enemy_instance = enemy_scene.instantiate() 
	var spawn_position = self.global_transform.origin  
	
	spawn_position.x = 21
	spawn_position.y = 0
	spawn_position.z = -31
	
	enemy_instance.global_transform.origin = spawn_position  
	add_child(enemy_instance)

func _on_enemy_timer_timeout():
	spawn_enemy()
