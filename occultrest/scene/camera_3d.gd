extends Camera3D

@export var target: NodePath  # Цель (персонаж)
@export var distance: float = 10.0  # Расстояние до персонажа по горизонтали
@export var height: float = 5.0  # Высота камеры над персонажем
@export var smooth_speed: float = 0.1  # Плавность движения камеры

func _process(delta: float) -> void:
	if target:
		var target_node = get_node(target) as Node3D
		if target_node:
			# Желаемая позиция камеры
			var desired_position = target_node.global_transform.origin
			desired_position.y += height  # Поднимаем камеру на высоту
			desired_position.z -= distance  # Отодвигаем камеру назад

			# Плавное перемещение камеры
			global_transform.origin = global_transform.origin.lerp(desired_position, smooth_speed)
