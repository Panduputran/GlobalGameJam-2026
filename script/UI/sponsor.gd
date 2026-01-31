extends Control

@onready var overlay = $Overlay 
func _on_sponsored_button_pressed():
	overlay.visible = true 
func _on_back_button_pressed():
	overlay.visible = false
	 
