extends Sprite3D

var max_hp: int:
	set(value):
		max_hp = value
		$SubViewport/TextureProgressBar.max_value = max_hp

var hp : int :
	set(value):
		hp = value
		$SubViewport/TextureProgressBar.value = hp
		
