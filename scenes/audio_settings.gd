extends PanelContainer

@onready var music_volume_slider: HSlider = $MarginContainer/VBoxContainer/HBoxContainer/MusicVolumeSlider
@onready var sfx_volume_slider: HSlider = $MarginContainer/VBoxContainer/HBoxContainer3/SFXVolumeSlider
@onready var audio_test_sound: AudioStreamPlayer = $AudioTestSound


func _on_music_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(value))


func _on_sfx_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(value))


func _on_sfx_volume_slider_drag_ended(value_changed: bool) -> void:
	audio_test_sound.play()


func _on_button_pressed() -> void:
	visible = false
