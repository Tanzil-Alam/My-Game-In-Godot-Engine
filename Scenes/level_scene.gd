extends Node2D

@onready var garlic_container: HBoxContainer = $GarlicContainer
@onready var garlic: TextureRect = $GarlicContainer/Garlic
@onready var garlic_2: TextureRect = $GarlicContainer/Garlic2
@onready var garlic_3: TextureRect = $GarlicContainer/Garlic3
@onready var garlic_4: TextureRect = $GarlicContainer/Garlic4
@onready var garlic_5: TextureRect = $GarlicContainer/Garlic5

@onready var level: RichTextLabel = $Level
@onready var timer: RichTextLabel = $Timer

var time: float = 0.0

func _ready() -> void:
	await Timer(5.0)
	
	if Global.minigames_done < 2:
		Global.minigames_done += 1
		get_tree().change_scene_to_file("res://Scenes/minigame_" + str(Global.minigames_done) + ".tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/title_scene.tscn")

func _process(delta: float) -> void:
	match Global.lives:
		4:
			garlic.hide()
		3:
			garlic.hide()
			garlic_2.hide()
		2:
			garlic.hide()
			garlic_2.hide()
			garlic_3.hide()
		1:
			garlic.hide()
			garlic_2.hide()
			garlic_3.hide()
			garlic_4.hide()
		0:
			garlic_container.hide()
			get_tree().change_scene_to_file("res://Scenes/death_screen.tscn")
	
	timer.text = str(snapped(time, 0.1))
	level.text = "Level " + str(Global.minigames_done + 1)

func Timer(start_time: float) -> void:
	time = start_time
	while time > 0.0:
		await wait(0.1)
		time -= 0.1

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
