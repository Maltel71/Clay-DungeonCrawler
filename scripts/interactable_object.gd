class_name InteractableObject extends Node

@export var interaction_prompt: String

func Interact() -> void:
	pass

func GetInteractionPrompt() -> String:
	if not interaction_prompt:
		return ""
	
	return interaction_prompt
