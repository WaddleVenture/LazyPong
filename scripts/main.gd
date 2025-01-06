extends Node2D
@onready var ball: CharacterBody2D = $Ball
@onready var player_score: Label = $HUD/PlayerScore
@onready var cpu_score: Label = $HUD/CPUScore
@onready var ball_timer: Timer = $BallTimer

var score := [0,0]


func _on_ball_timer_timeout() -> void:
	ball.new_ball()


func _on_score_left_body_entered(_body: Node2D) -> void:
	score[1] += 1
	cpu_score.text = str(score[1])
	ball_timer.start()


func _on_score_right_body_entered(_body: Node2D) -> void:
	score[0] += 1
	player_score.text = str(score[0])
	ball_timer.start()
