extends Control

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	BusEvent.scoreAdd.connect(_score_refresh)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Affichage des FPS sur la main gauche
	var fps = Engine.get_frames_per_second()
	var FPStext = "FPS :" + str(fps)
	$FPS.text = FPStext

func _score_refresh(scoreAdd: int):
	score += scoreAdd
	BusEvent.scoreTotal.emit(score)
	$Score.text = "Score :" + str(score)
