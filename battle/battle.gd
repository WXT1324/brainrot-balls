extends Node2D

@onready var stats = {"unarmed": [100,10]}

func _process(delta):
	for i in $contenders.get_children():
		if i == null: continue
		stats[i.ball_name] = [i.hp, i.damage]
