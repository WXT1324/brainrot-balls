extends Camera2D


func _ready():
	_shake(5)

func _shake(amount):
	while amount >= 0.0:
		offset.x = randf_range(-amount,amount)
		offset.y = randf_range(-amount,amount)
		amount -= 0.1

func _physics_process(delta):
	pass
