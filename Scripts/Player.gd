extends KinematicBody2D

export (int) var move_speed
export (int) var acceleration

var velocity = Vector2()

func _physics_process(delta):
	
	var move_direction = get_move_direction()
	
	velocity = custom_lerp(velocity, move_direction.normalized() * move_speed, acceleration * delta)
	velocity = move_and_slide(velocity)
	
	look_at(get_global_mouse_position())

func get_move_direction():
	return Vector2(
		int(Input.is_action_pressed("Right")) - int(Input.is_action_pressed("Left")),
		int(Input.is_action_pressed("Down")) - int(Input.is_action_pressed("Up")) 
	)

func custom_lerp(current, target, weight):
	return current.linear_interpolate(target, weight)
