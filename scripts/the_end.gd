extends Node3D

var done = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# If there is no child node, create a new one
	if get_child_count() == 0 and !done:
		BusEvent.theEnd.emit()
		done = true
	elif get_child_count() < 10 and !done:
		# Get a random node from child nodes
		var random_node = get_child(randi() % get_child_count())
		# get position
		var pos = random_node.get_global_transform().origin
		BusEvent.nextDotPos.emit(pos)
