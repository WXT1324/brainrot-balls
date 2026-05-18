extends RigidBody2D
class_name weapon_melee

@onready var damage = get_parent().damage

const collision_buffer = 0.05
var collision_timer = 0.05

var hit_direction = 1

func _physics_process(delta):
	if collision_timer > 0.0: collision_timer -= delta

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	
	angular_velocity = 5 * hit_direction
	
	for i in range(state.get_contact_count()):
		var other: Object = state.get_contact_collider_object(i)
		if other is Node and other.is_in_group("ball"):
			if collision_timer <= 0.0: 
				hit_direction = -hit_direction
				_collision_specifics(other)
				collision_timer = collision_buffer

func _collision_specifics(other):
	pass
