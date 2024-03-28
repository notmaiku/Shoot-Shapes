extends Button

func _ready():
	$"..".visible = false

func _pressed():
	get_tree().reload_current_scene()
