extends CharacterBody3D
class_name player
 
var lamp_use = false
@export var lamp_get = false
var anim: AnimationPlayer
var sound: AudioStreamPlayer
func _ready() -> void:
	anim = get_child(1)
	anim.play("idle")
	sound = get_child(4)
	 

@export var jump_force: float = 10.0  # Сила прыжка
@export var gravity: float = -24.8  # Гравитация

var velocity_y: float = 0.0  # Вертикальная скорость
@export var speed: float = 5.0  # Скорость движения
@export var rotation_speed: float = 10.0  # Скорость поворота

func _physics_process(delta: float) -> void:
	
	# Применяем гравитацию
	if not is_on_floor():
		velocity_y += get_gravity().y * delta
	else:
		velocity_y = 0.0

	var direction = Vector3.ZERO  # Направление движения
	
	if lamp_use:
		get_child(3).get_child(0).show()
	
	if Input.is_action_just_pressed("light") and not lamp_use and direction == Vector3.ZERO and lamp_get:
		lamp_use = true
	elif Input.is_action_just_pressed("light") and lamp_use and direction == Vector3.ZERO and lamp_get:
		lamp_use = false

	# Управление с клавиатуры (WASD)
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
	if Input.is_action_pressed("move_backward"):
		direction.z += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_right"):
		direction.x += 1

	# Нормализуем вектор направления, чтобы избежать ускорения при движении по диагонали
	direction = direction.normalized() 
	if direction != Vector3.ZERO:
		if not lamp_use:
			anim.play("walk")
		else:
			get_child(3).get_child(0).show()
			anim.play("walk_lamp")
	# Двигаем персонажа
		velocity = direction * speed

		# Поворачиваем персонажа в сторону движения
		var target_angle = atan2(direction.x, direction.z)  # Угол поворота
		var current_angle = rotation.y  # Текущий угол поворота
		rotation.y = lerp_angle(current_angle, target_angle, rotation_speed * delta)
	else: 
		if not lamp_use:
			get_child(3).get_child(0).hide()
			anim.play("idle")
		else:
			anim.play("idle_lamp")
		velocity = Vector3.ZERO
		
	if direction != Vector3.ZERO:
		if not sound.playing:
			sound.play()
	else:
		sound.stop() 
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity_y = jump_force

	# Применяем вертикальную скорость
	velocity.y = velocity_y
	
	# Применяем движение
	move_and_slide()

@export var stranger_mudlr: Node3D
func vsbl_musli(id, _text):
	match  id:
		0:
			stranger_mudlr.get_child(1).text = _text
		1:
			stranger_mudlr.get_child(2).text = _text
		2:
			stranger_mudlr.get_child(0).text = _text
