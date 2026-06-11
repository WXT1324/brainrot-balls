extends Node2D

@onready var stats = {"unarmed": [100,10]}

func _ready():
	for i in $contenders.get_children():
		if i == null: continue
		i.inital_direction += randf_range(-PI, PI)

func _process(delta):
	for i in $contenders.get_children():
		if i == null: continue
		stats[i.ball_name] = [i.hp, i.damage]
		
