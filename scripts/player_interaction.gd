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
		display_text(text_to_display)
		return
	
	if active_object:
		if active_object.has_method("get_interaction_prompt"):
			text_to_display = active_object.get_interaction_prompt()
	
	display_text(text_to_display)

func display_text(text: String) -> void:
	label.text = text

func _on_interaction_pressed() -> void:
	if active_object:
		if active_object.has_method("interact"):
			active_object.interact()
