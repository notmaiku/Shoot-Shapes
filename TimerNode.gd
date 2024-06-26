extends Node

@onready var loop_timer = $LoopTimer
@onready var enemy_timer = $EnemyTimer
@onready var TIMER = $"../UI/Time"

var curr_enemy = 0.0
var curr_loop = 0.0
var timer_value = 1.0
var game_done = 20.0
var loop_time_go = true

	
func _ready():
	loop_timer.start()
	enemy_timer.start()

func _process(delta):
	if loop_time_go == true:
		curr_loop += delta
		curr_enemy += delta
	TIMER.text = str(curr_loop)
	if curr_enemy >= timer_value:
		curr_enemy = 0.0  
		enemy_timer.start()      
	if curr_loop >= game_done:
		loop_time_go = false
		$"../UI/Fin".visible = true
