extends ball

func _collision_specifics(other):
	velocity += Vector2(ball_speed/8, ball_speed/8) * sign(velocity)
	damage += 2
	if other.is_in_group("melee"):
		other.get_parent()._damage(damage)
	else: 
		other._damage(damage)
