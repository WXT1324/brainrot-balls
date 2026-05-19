extends RigidBody2D
class_name ball

@export var ball_name = "unarmed"

@export var hp = 100
@export var damage = 5 #unarmed balls deal damage on regular contact

var maxhp = hp

@onready var hp_bar = get_node("HP")
@onready var collide_sfx = get_node("collide")
@onready var hurt_sfx = get_node("hurt")
@onready var sprite = get_node("sprite")

@export var ball_speed = 200
@export var inital_direction = Vector2(1,-1)
@export var velocity = Vector2(ball_speed, ball_speed) * inital_direction

const collision_buffer = 0.1
var collision_timer = collision_buffer

func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		$collide.play()
		velocity = velocity.bounce(collision_info.get_normal())
		
	hp_bar.text = "[center]" + str(hp)
	print(collision_timer)
	if collision_timer > 0.0: collision_timer -= delta

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
		for i in range(state.get_contact_count()):
			var other: Object = state.get_contact_collider_object(i)
			if ball_name != "unarmed": continue
			if other is Node and other.is_in_group("ball"):
				if collision_timer <= 0.0: 
					_collision_specifics(other)
					collision_timer = collision_buffer

func _collision_specifics(other):
	pass
	
func _damage(amount):
	print(name, hp)
	hp -= amount
	hurt_sfx.play()
	
	sprite.modulate = Color(1.0, 0.0, 0.0, 1.0)
	Engine.time_scale = 0.025
	await get_tree().create_timer(0.01).timeout
	Engine.time_scale = 1.0
	sprite.modulate = Color(1.0, 1.0, 1.0, 1.0)
	
	if hp <= 0: _death()
	
func _death():
	var explosion = preload("res://battle/explosion.tscn").instantiate()
	get_parent().get_parent().add_child(explosion)
	explosion.global_position = global_position
	queue_free()
	
