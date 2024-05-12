extends XRController3D

var done = false

# Called when the node enters the scene tree for the first time.
func _ready():
	BusEvent.nextDotPos.connect(_nextDotPos)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var pos = get_global_transform().origin
	BusEvent.cameraPosition.emit(pos)

func _nextDotPos(pos):
	if !done:
		done = true
	$NavigationAgent3D.target_position = pos
	


func _on_timer_timeout():
	if done:
		$NavigationAgent3D.get_next_path_position()
		
