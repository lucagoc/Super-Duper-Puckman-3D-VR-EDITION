extends XRCamera3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var pos = get_global_transform().origin 
	var rot = get_rotation()
	# get rotation of the body
	rot = rot + get_parent().get_rotation()
	BusEvent.XRcameraPosition.emit(pos, rot)
