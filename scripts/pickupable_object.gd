class_name PickupableObject extends InteractableObject

func _ready() -> void:
	if interaction_prompt == "":
		interaction_prompt = "Pick up"
	super._ready()

func interact() -> void:
	queue_free()

func toggle_display_text() -> void:
	set_interaction_prompt(shake_effect + interaction_prompt + shake_end)
