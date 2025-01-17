extends Control

var score = 0
var counting = true
var time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	BusEvent.scoreAdd.connect(_score_refresh)
	BusEvent.theEnd.connect(_the_end)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Affichage des FPS sur la main gauche
	var fps = Engine.get_frames_per_second()
	var FPStext = "FPS : " + str(fps)
	$FPS.text = FPStext

func _score_refresh(scoreAdd: int):
	score += scoreAdd
	BusEvent.scoreTotal.emit(score)
	$Score.text = "Score : " + str(score)

func _the_end():
	counting = false


func _on_timer_2_timeout():
	if counting:
		time += 1
		var timetext = "TIMER : " + str(time)
		$Timer.text = timetext
