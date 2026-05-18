extends weapon_melee

func _collision_specifics(other):
	other._damage(damage) 
