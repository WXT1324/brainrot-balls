extends RigidBody2D
class_name ball

@export var ball_name = "unarmed"

@export var hp = 100
@export var damage = 5

var maxhp = hp

@onready var hp_bar = get_node("HP")
@onready var collide_sfx = get_node("collide")
@onready var hurt_sfx = get_node("hurt")
@onready var sprite = get_node("sprite")

@export var ball_speed = 200
@export var inital_direction = Vector2(1,-1)
@export var velocity = Vector2(ball_speed, ball_speed) * inital_direction

const collision_buffer = 0.05
var collision_timer = 0.05

func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		$collide.play()
		velocity = velocity.bounce(collision_info.get_normal())
		
	hp_bar.text = "[center]" + str(hp)
	
	if collision_timer > 0.0: collision_timer -= delta
	
	

func _collision_specifics(other):
	pass
	
func _damage(amount):
	print(name, hp)
	hp -= amount
	hurt_sfx.play()
	
	sprite.modulate = Color(1.0, 0.0, 0.0, 1.0)
	await get_tree().create_timer(0.1).timeout
	sprite.modulate = Color(1.0, 1.0, 1.0, 1.0)
	
	if hp <= 0: _death()
	
func _death():
	queue_free()
	
