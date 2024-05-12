extends CharacterBody3D

@export var speed = 7
@export var accel = 10
@export var isDead = false
@export var followPlayer = false
@export var active = false

var target = Vector3(0, 0, 0)
var random_target = Vector3(0, 1, -19)

@onready var nav_agent := $NavigationAgent3D as NavigationAgent3D

# Called when the node enters the scene tree for the first time.
func _ready():
	BusEvent.cameraPosition.connect(_refresh_target)
	BusEvent.scoreTotal.connect(_on_score_changed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if active:
		var dir = nav_agent.get_next_path_position() - global_position
		dir = dir.normalized()
	
		velocity = velocity.lerp(dir*speed, accel*delta)
		move_and_slide()

func _refresh_target(targetPos: Vector3):
	speed = 7
	if(not isDead and followPlayer):
		#print("pasmort")
		target = targetPos
		$MainMeshInstance3D.show()
		$PlayerDeathArea/CollisionShape3D.disabled = false
	elif(not isDead and !followPlayer):
		target = random_target
		$MainMeshInstance3D.show()
		$PlayerDeathArea/CollisionShape3D.disabled = false
	else:
		#print("mort")
		target = random_target
		$MainMeshInstance3D.hide()
		speed = 10
		$PlayerDeathArea/CollisionShape3D.disabled = true
		target = Vector3(0, 1, -19)

func makepath():
	nav_agent.target_position = target

func _on_path_refresh_timeout(): 
	makepath()

func _on_bullet_area_area_entered(area):
	isDead = true
	followPlayer = false


func _on_detection_area_area_entered(area):
	followPlayer = true


func _on_detection_area_area_exited(area):
	followPlayer = false


func _on_navigation_agent_3d_navigation_finished():
	_get_random_position()

func _get_random_position():
	var zt = randi()%36 - 26
	var yt = 1
	var xt = randi()%60 - 12
	
	random_target = Vector3(xt, yt, zt)


func _on_delay_timeout():
	active = true


func _on_audio_stream_player_3d_finished():
	$AudioStreamPlayer3D.play()

func _on_score_changed(score: int):
	$AudioStreamPlayer3D.pitch_scale = 1 + score/4000.0
