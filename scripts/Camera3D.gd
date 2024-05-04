extends Camera3D


# Called when the node enters the scene tree for the first time.
func _ready():
	BusEvent.cameraPosition.connect(_on_position_changed)
	print("Bus Connecté")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_position_changed(position: Vector3):
	var adjustedpos = position + Vector3(0, 10, 0)
	self.global_transform.origin = adjustedpos
