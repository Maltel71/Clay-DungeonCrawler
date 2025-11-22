class_name Torch extends InteractableObject
@onready var omni_light: OmniLight3D = $OmniLight3D
@onready var vfx_smoke: GPUParticles3D = $vfx_smoke_realistic_01

@export var turned_on: bool = true

func _ready() -> void:
	super._ready()

func interact() -> void:
	turned_on = !turned_on
	toggle_display_text()
	omni_light.visible = !omni_light.visible 
	vfx_smoke.emitting = !vfx_smoke.emitting

func toggle_display_text() -> void:
	if turned_on:
		set_interaction_prompt(shake_effect + "Extinguish flame" + shake_end)
	else:
		set_interaction_prompt(shake_effect + "Light fire" + shake_end)
