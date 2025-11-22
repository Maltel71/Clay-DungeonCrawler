class_name InteractableObject extends Node

@export var interaction_prompt: String

func interact() -> void:
	pass

func get_interaction_prompt() -> String:
	if not interaction_prompt:
		return ""
	
	return interaction_prompt

func set_interaction_prompt(value: String) -> void:
	interaction_prompt = value

func toggle_display_text() -> void:
	pass
