extends CharacterBody2D

# Exported variables
@export var player_data : MainResource
@onready var player: StaticBody2D = $"../Player"
@onready var cpu: StaticBody2D = $"../CPU"

# Constants
const START_SPEED : int = 500
const ACCELERATION : int = 50
const VERTICAL_ANGLE_LIMIT  : float = 0.6

# Variables
var window_size : Vector2
var speed : int 
var direction : Vector2

# Initial setup
func _ready() -> void:
	window_size = get_viewport_rect().size


# Resets the ball to the center and sets a new random direction
func new_ball() -> void:
	# Set the ball position to the center horizontally, random vertically
	position.x = window_size.x / 2
	position.y = randf_range((window_size.y / 2) - 50, (window_size.y / 2) + 50)
	
	# Initialize speed and direction
	speed = START_SPEED
	direction = random_direction()


# Generate a random direction for the ball
func random_direction() -> Vector2:
	var x = [-1, 1].pick_random()
	var y = randf_range(-1, 1)
	return Vector2(x, y).normalized()


# Physics update - Ball movement and collision handling
func _physics_process(delta: float) -> void:
	var collision = move_and_collide(direction * speed * delta)
	if collision : 
		var collider = collision.get_collider()

		# Handle paddle collision
		if collider == player or collider == cpu:
			speed += ACCELERATION 
			direction = calculate_new_direction(collider)

		# Handle wall collision (bounce off the wall)
		else:
			direction = direction.bounce(collision.get_normal())

# Calculate the new direction based on the paddle collision
func calculate_new_direction(collider: Node2D) -> Vector2:
	# Get the vertical distance between the ball and the paddle
	var distance = position.y - collider.position.y
	
	# Flip the horizontal direction
	var x = -sign(direction.x)
	
	# Adjust vertical direction based on the distance, limited by VERTICAL_ANGLE_LIMIT
	var y = (distance / (collider.paddle_height / 2 )) * VERTICAL_ANGLE_LIMIT 

	return Vector2(x, y).normalized()
