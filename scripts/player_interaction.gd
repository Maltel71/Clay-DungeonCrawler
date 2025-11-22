extends RayCast3D

@onready var label: Label = %Label
@onready var player: CharacterBody3D = $"../.."

var active_object: Node3D
var text_to_display: String

func _ready() -> void:
	player.interaction_pressed.connect(_on_interaction_pressed)

func _process(delta: float) -> void:
	active_object = get_collider()
	
	if not is_colliding():
		text_to_display = ""
		active_object = null
		DisplayText(text_to_display)
		return
	
	if active_object:
		if active_object.has_method("GetInteractionPrompt"):
			text_to_display = "E to " + active_object.GetInteractionPrompt()
	
	DisplayText(text_to_display)

func DisplayText(text: String) -> void:
	label.text = text

func _on_interaction_pressed() -> void:
	if active_object:
		if active_object.has_method("Interact"):
			active_object.Interact()
