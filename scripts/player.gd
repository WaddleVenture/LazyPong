extends StaticBody2D
@onready var color_rect: ColorRect = $ColorRect
@export var player_data : MainResource 

var window_height : float 
var paddle_height : float


func _ready() -> void:
	window_height = get_viewport_rect().size.y
	paddle_height = color_rect.size.y

func _process(delta: float) -> void:
	
	# Paddle movements
	if Input.is_action_pressed("ui_up"):
		position.y -= player_data.paddle_speed * delta
	elif Input.is_action_pressed("ui_down"):
		position.y += player_data.paddle_speed * delta
	
	# Limit paddle movement to window, StaticBodies can't interract with each other
	position.y = clamp(position.y, paddle_height / 2, window_height - paddle_height / 2)
