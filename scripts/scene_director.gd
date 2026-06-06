extends Node2D

# === НАСТРОЙКИ — меняй под каждую сцену ===
@export var character_start_x: float = 100.0
@export var character_end_x: float = 1180.0
@export var walk_duration: float = 4.0
@export var frame_speed: float = 0.12
@export var total_frames: int = 8

var current_frame: int = 0
var frame_timer: float = 0.0
var walk_timer: float = 0.0
var is_walking: bool = true
var scene_time: float = 0.0

# Субтитры: [время_начала, время_конца, текст]
var subtitles = [
	[0.0,   2.5,  "Привет, мир"],
	[2.5,   5.0,  "Я иду по лесу..."],
	[5.0,   8.0,  "Как здесь красиво!"],
]

func _ready():
	$Character.position.x = character_start_x

func _process(delta):
	scene_time += delta

	# Анимация кадров персонажа
	if is_walking:
		frame_timer += delta
		if frame_timer >= frame_speed:
			frame_timer = 0.0
			current_frame = (current_frame + 1) % total_frames
			$Character.frame = current_frame

	# Движение персонажа слева направо
	if walk_timer < walk_duration:
		walk_timer += delta
		$Character.position.x = lerp(character_start_x, character_end_x, walk_timer / walk_duration)
	else:
		is_walking = false

	# Субтитры
	var found = false
	for sub in subtitles:
		if scene_time >= sub[0] and scene_time < sub[1]:
			$Subtitle.text = sub[2]
			found = true
			break
	if not found:
		$Subtitle.text = ""
