extends RigidBody2D
class_name weapon_melee

var damage = 10

const collision_buffer = 0.1
var collision_timer = collision_buffer

@export var melee_direction = 1
@export var weapon_rotation_velocity = 5.0

func _physics_process(delta):
	collision_timer -= delta
	
	angular_velocity = weapon_rotation_velocity * melee_direction
	
func _integrate_forces(state):
	for i in range(state.get_contact_count()):
		var other: Object = state.get_contact_collider_object(i)
		if other is Node and other.is_in_group("ball"):
			if collision_timer <= 0.0: 
				melee_direction = -melee_direction
				_collision_specifics(other)
				collision_timer = collision_buffer
	

func _collision_specifics(other):
	pass
