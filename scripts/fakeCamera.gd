extends Camera3D


# Called when the node enters the scene tree for the first time.
func _ready():
	BusEvent.XRcameraPosition.connect(_on_pos_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_pos_changed(pos: Vector3, rot: Vector3):
	position.x = pos.x
	position.y = pos.y
	position.z = pos.z

	rotation.x = rot.x
	rotation.y = rot.y
	rotation.z = rot.z
