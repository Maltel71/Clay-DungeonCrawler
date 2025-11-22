@abstract class_name InteractableObject extends Node

@export var interaction_prompt: String
@export var shake_text_effect: bool = true

var shake_effect: String
var shake_end: String

@abstract func interact() -> void
@abstract func toggle_display_text() -> void

func _ready() -> void:
	if shake_text_effect:
		shake_effect = "[shake rate=20.0 level=5 connected=1]"
		shake_end = "[/shake]"
	else:
		shake_effect = ""
		shake_end = ""
	
	toggle_display_text()

func get_interaction_prompt() -> String:
	if not interaction_prompt:
		return ""
	
	return interaction_prompt

func set_interaction_prompt(value: String) -> void:
	interaction_prompt = value
