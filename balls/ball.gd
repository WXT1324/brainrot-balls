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
@export var inital_direction = 0

var velocity = Vector2(cos(inital_direction),sin(inital_direction)) * ball_speed

const collision_buffer = 0.05
var collision_timer = collision_buffer

func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		var object = collision_info.get_collider()
		$collide.play()
		velocity = velocity.bounce(collision_info.get_normal())
		
		if collision_timer < 0.0: 
			if object is Node and object.is_in_group("ball"):
				_collision_specifics(object)
			collision_timer = collision_buffer
	
	collision_timer -= delta
	
	hp_bar.text = "[center]" + str(hp)


func _collision_specifics(other):
	pass
	
func _damage(amount):
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
	
