extends ball

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	for i in range(state.get_contact_count()):
		var other: Object = state.get_contact_collider_object(i)
		if other is Node and other.is_in_group("ball"):
			if collision_timer <= 0.0: 
				_collision_specifics(other)
				collision_timer = collision_buffer

func _collision_specifics(other):
	velocity += Vector2(ball_speed/8, ball_speed/8) * sign(velocity)
	damage += 2
	if other.is_in_group("melee"):
		other.get_parent()._damage(damage)
	else: 
		other._damage(damage)
