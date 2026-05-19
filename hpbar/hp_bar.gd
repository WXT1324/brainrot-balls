extends Node2D

var hp = 100
var maxhp = hp

@export var selected_ball = "unarmed"
@onready var main = get_tree().get_first_node_in_group("main")

func _ready():
	await get_tree().process_frame
	maxhp = hp
	$name.text = "[wave]" + selected_ball


func _process(delta):
	if selected_ball != null:
		hp = main.stats[selected_ball][0]
		$damage.text = str(main.stats[selected_ball][1])
		$yellow.size.x = 65 * hp/maxhp
