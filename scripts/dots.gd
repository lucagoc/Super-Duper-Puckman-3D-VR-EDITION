extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_area_entered(area):
	BusEvent.scoreAdd.emit(20)
	$AudioStreamPlayer3D.play()
	$MeshInstance3D.hide()


func _on_animation_player_animation_finished(anim_name):
	$AnimationPlayer.play("idle")
	


func _on_audio_stream_player_3d_finished():
	queue_free()
