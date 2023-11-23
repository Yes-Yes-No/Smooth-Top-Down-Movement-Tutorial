extends KinematicBody2D

export (int) var move_speed
export (int) var acceleration

export (PackedScene) var bullet_scene

var velocity = Vector2()

onready var pos = $Position2D
onready var timer = $Timer

func _physics_process(delta):
	
	var move_direction = get_move_direction()
	
	velocity = custom_lerp(velocity, move_direction.normalized() * move_speed, acceleration * delta)
	velocity = move_and_slide(velocity)
	
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("Shoot"):
		shoot()

func get_move_direction():
	return Vector2(
		int(Input.is_action_pressed("Right")) - int(Input.is_action_pressed("Left")),
		int(Input.is_action_pressed("Down")) - int(Input.is_action_pressed("Up")) 
	)

func custom_lerp(current, target, weight):
	return current.linear_interpolate(target, weight)

func shoot():
	if timer.is_stopped():
		var b = bullet_scene.instance()
		var shoot_dir = (get_global_mouse_position() - self.global_position).normalized()
		
		b.dir = shoot_dir
		b.global_position = pos.global_position
		
		get_tree().get_root().add_child(b)
		
		timer.start()



