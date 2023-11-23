extends Area2D

var dir = Vector2.RIGHT
var speed = 350

func _process(delta):
	translate(dir.normalized() * speed * delta)

