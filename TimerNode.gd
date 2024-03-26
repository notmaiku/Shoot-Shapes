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
		$"../UI/Fin".visible = true
		elapsed_time = 0.0  
		$"../UI/Time".visible = false
