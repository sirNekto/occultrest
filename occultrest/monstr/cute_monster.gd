extends CharacterBody3D

@export var player_path: NodePath  # Путь к игроку
@export var min_spawn_distance: float = 5.0  # Минимальное расстояние появления от игрока
@export var max_spawn_distance: float = 10.0  # Максимальное расстояние появления от игрока
@export var move_speed: float = 5.0  # Скорость движения
@export var min_spawn_time: float = 3.0  # Минимальное время до следующего появления
@export var max_spawn_time: float = 10.0  # Максимальное время до следующего появления

var player: Node3D  # Игрок
var is_active: bool = false  # Активен ли монстр
var timer: float = 0.0  # Таймер для появления
var target_position: Vector3  # Целевая позиция, мимо которой монстр пробегает
var area: Area3D
func _ready():
	# Получаем ссылку на игрока
	player = get_node(player_path)
	# Устанавливаем случайное время до первого появления
	timer = 45
	area.connect("body_entered", _body_entered)
	
func _body_entered(body):
	if body is player:
		get_tree().change_scene_to_file("res://prefab/main_menu_bad.tscn")

func _physics_process(delta: float) -> void:
	if is_active:
		# Двигаемся к целевой позиции
		var direction = (target_position - global_transform.origin).normalized()
		velocity = direction * move_speed
		move_and_slide()
		if velocity.length() > 0:
			var target_angle = atan2(velocity.x, velocity.z)
			rotation.y = lerp_angle(rotation.y, target_angle, 10.0 * delta)
		# Если монстр достиг целевой позиции, деактивируем его 
		if global_transform.origin.distance_to(target_position) < 32.1:
			is_active = false
			timer = randf_range(min_spawn_time, max_spawn_time)
			hide()
	else:
		# Обратный отсчёт до появления
		timer -= delta
		if timer <= 0:
			show()
			spawn_near_player()

func spawn_near_player():
	# Случайное расстояние от игрока
	var distance = randf_range(min_spawn_distance, max_spawn_distance)
	# Случайный угол вокруг игрока
	var angle = randf_range(0, 2 * PI)
	# Позиция появления
	var spawn_position = player.global_transform.origin + Vector3(cos(angle), 0, sin(angle)) * distance
	spawn_position.y = 0  # Оставляем монстра на земле

	# Перемещаем монстра в новую позицию
	global_transform.origin = spawn_position

	# Выбираем целевую позицию, мимо которой монстр пробежит
	var target_angle = randf_range(0, 2 * PI)
	target_position = player.global_transform.origin + Vector3(cos(target_angle), 0, sin(target_angle)) * distance
	target_position.y = 0  # Оставляем цель на земле

	# Активируем монстра
	is_active = true
