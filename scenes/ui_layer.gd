extends CanvasLayer


func _on_weed_status_change(node: Variant) -> void:
	$UI/MarginContainer/TextureProgressBar.max_value = node.max_hp
	$UI/MarginContainer/TextureProgressBar.value = node.hp
