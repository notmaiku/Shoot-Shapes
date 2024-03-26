extends Node
@onready var timer = $Timer
var elapsed_time = 0.0
var timer_value = 5.0
@export var TIMER : Label
	
func _ready():
	timer.start()
	

func _process(delta):
	elapsed_time += delta
	TIMER.text = str(elapsed_time)
	if elapsed_time >= timer_value:
		print("5 seconds have passed!")
		elapsed_time = 0.0  
		timer.start()       
