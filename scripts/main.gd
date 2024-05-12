extends Node3D

var xr_interface: XRInterface
# Called when the node enters the scene tree for the first time.
func _ready():
	xr_interface = XRServer.find_interface("OpenXR")
	
	if xr_interface and xr_interface.is_initialized():
		print("OpenXR initialised successfully")
		
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		
		get_viewport().use_xr = true
	else:
		print("OpenXR not initialised, error")
	
	BusEvent.scoreTotal.connect(_on_score_changed)
	BusEvent.theEnd.connect(_the_end)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_score_changed(score: int):
	$MusicPlayer.pitch_scale = 1 + score/4000.0

func _on_music_player_finished():
	var music = load("res://assets/musics/main_loop.wav")
	$MusicPlayer.stream = music
	$MusicPlayer.play()

func _the_end():
	$XROrigin3D.position = Vector3(-3, 1, -120)
