extends StaticBody2D

@onready var color_rect: ColorRect = $ColorRect
@onready var ball: CharacterBody2D = $"../Ball"
@export var cpu_data: MainResource 

var window_height: float
var paddle_height: float 


func _ready() -> void:
	window_height = get_viewport_rect().size.y
	paddle_height = color_rect.size.y


func _process(delta: float) -> void:
	# Get distance to ball
	var distance_to_ball = ball.position.y - position.y

	# Move the paddle depending of the position of the ball
	position.y += clamp(distance_to_ball, -cpu_data.paddle_speed * delta, cpu_data.paddle_speed * delta)

	# Limit paddle movement to window
	position.y = clamp(position.y, paddle_height / 2, window_height - paddle_height / 2)
