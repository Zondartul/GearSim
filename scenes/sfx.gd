extends Node

func play_sound_put_object():
	$audio_putt.pitch_scale = randf_range(0.8,1.2);
	$audio_putt.play();
