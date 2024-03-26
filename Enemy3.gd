extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	var target = load("res://enemy.tscn")
	var target_copies = target.instantiate()
	add_child(target_copies)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
