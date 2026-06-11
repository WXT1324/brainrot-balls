extends ball

func _collision_specifics(other):
	velocity += Vector2(ball_speed/4, ball_speed/4) * sign(velocity)
	damage += 1
	other._damage(damage)
