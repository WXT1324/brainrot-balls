extends Node2D

var hp = 100
var maxhp = hp

@export var selected_ball: Node

func _ready():
	await get_tree().process_frame
	maxhp = hp
	$name.text = "[wave]" + selected_ball.ball_name.to_upper()
	$damage.text = str(selected_ball.damage)

func _process(delta):
	if selected_ball != null:
		hp = selected_ball.hp
		$yellow.size.x = 65 * hp/maxhp
