class_name Zombie
extends TextureRect

@onready var blood_splatter: TextureRect = $BloodSplatter
@onready var audio_zombie_spawn: AudioStreamPlayer = $AudioZombieSpawn
@onready var audio_zombie_attack: AudioStreamPlayer = $AudioZombieAttack
@onready var audio_zombie_dying: AudioStreamPlayer = $AudioZombieDying

var tween : Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	blood_splatter.visible = false
	audio_zombie_spawn.play()

func zombie_attack() -> void:
	tween = create_tween()
	var original_position = self.position
	print(original_position)
	tween.tween_property(self, "position", Vector2(- 50, original_position.y), 0.5)
	tween.tween_callback(audio_zombie_attack.play)
	tween.tween_property(self, "position", original_position, 0.5)

func remove_zombie() -> void:
	print("zombie destroyed!")
	blood_splatter.visible = true
	audio_zombie_dying.play()
	tween = create_tween()
	tween.tween_property(self, "modulate:a", 0, 1.0)
	tween.tween_callback(self.queue_free)
	
