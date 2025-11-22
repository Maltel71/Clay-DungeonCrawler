class_name Chest extends InteractableObject

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var is_open: bool

func interact() -> void:
	if not is_open:
		is_open = true
		animation_player.play("open_lid")
		toggle_display_text()

func toggle_display_text() -> void:
	if is_open:
		set_interaction_prompt("")
	else:
		set_interaction_prompt("E to open chest")
