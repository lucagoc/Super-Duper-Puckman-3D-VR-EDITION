extends Control

@export var ammo = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ammo = get_parent().get_parent().get_parent().get_node("Shoot").ammoleft
	$Label.text = str(ammo)
