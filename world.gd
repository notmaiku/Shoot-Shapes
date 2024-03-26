extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	#spawn_enemy()
	pass

# Function to spawn an enemy near the current node position with some randomness
func spawn_enemy():
	var enemy_scene = preload("res://enemy_2.tscn") # Preload the enemy scene
	var enemy_instance = enemy_scene.instantiate()  # Instance the enemy scene
	var spawn_position = self.global_transform.origin  # Get the position of the node where the script is attached
	
	# Add some randomness to spawn position
	spawn_position.x = 21
	spawn_position.y = 0
	spawn_position.z = -31
	
	enemy_instance.global_transform.origin = spawn_position  # Set the spawn position of the enemy
	add_child(enemy_instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	spawn_enemy()
