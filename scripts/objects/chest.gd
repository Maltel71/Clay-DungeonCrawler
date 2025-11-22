class_name Chest extends InteractableObject

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var is_open: bool

func Interact() -> void:
	if not is_open:
		is_open = true
		animation_player.play("open_lid")
