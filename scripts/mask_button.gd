extends TextureButton

func _ready() -> void:
	var click_mask := BitMap.new()
	click_mask.create_from_image_alpha(texture_normal.get_image())
	texture_click_mask = click_mask
