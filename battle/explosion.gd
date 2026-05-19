extends AnimatedSprite2D

func _ready():
	play("default")
	$explosion_sfx.play()
	await self.animation_finished
	queue_free()
