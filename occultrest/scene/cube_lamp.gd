extends MeshInstance3D

var area: Area3D


var area_qst1: Area3D
var area_qst2: Area3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area = get_child(1)
	area.connect("body_entered", _on_area_3d_body_entered)
	area.connect("body_exited", _on_area_3d_body_exited)
	
	area_qst1 = get_child(2).get_child(0)
	area_qst1.connect("body_entered", _on_area_qst1_entered) 
	
	area_qst2 = get_child(2).get_child(1)
	area_qst2.connect("body_entered", _on_area_qst2_entered) 
	pass # Replace with function body.

var buffer_player = null
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_here != null and Input.is_action_just_pressed("use") and visible:
		self.hide()
		player_here.lamp_get = true
		buffer_player = player_here
		buffer_player.vsbl_musli(0, " ") 
		buffer_player.vsbl_musli(1, "Умница")
		buffer_player.vsbl_musli(2, " ")
		await get_tree().create_timer(2).timeout
		buffer_player.vsbl_musli(1, " ")
		await get_tree().create_timer(2).timeout
		get_parent().get_child(2).get_child(0).show_keyboard_info(1)
		buffer_player.vsbl_musli(1, "Святи.")
		await get_tree().create_timer(5).timeout
		buffer_player.vsbl_musli(1, "Иследуй.")
		buffer_player.vsbl_musli(2, "Бег..")
		await get_tree().create_timer(0.7).timeout 
		buffer_player.vsbl_musli(2, " ")
		buffer_player.vsbl_musli(0, "Поздно.")
		await get_tree().create_timer(0.7).timeout
		buffer_player.vsbl_musli(0, " ")
		get_parent().get_child(2).get_child(0).quest_set(2)
		await  get_tree().create_timer(4).timeout
		buffer_player.vsbl_musli(1, " ")
		await  get_tree().create_timer(4).timeout
		buffer_player.vsbl_musli(1, "Двигай вперёд. Вверх.")
		await  get_tree().create_timer(4).timeout
		buffer_player.vsbl_musli(1, " ")
		queue_free()
		  

var player_here: CharacterBody3D = null
func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is player:
		player_here = body 


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body is player:
		player_here = null 


var lock1 = false
func _on_area_qst1_entered(body: Node3D) -> void:
	if lock1:
		return
	
	if body is player:
		lock1 = true
		body.vsbl_musli(0, "Изучи")
		get_parent().get_child(2).get_child(0).quest_set(1)
		body.vsbl_musli(2, "")
		pass

var lock2 = false
func _on_area_qst2_entered(body: Node3D) -> void:
	if lock2:
		return
		
	if body is player:
		lock2 = true
		body.vsbl_musli(0, "Не думай")
		await get_tree().create_timer(1).timeout
		body.vsbl_musli(1, "Возьми.")
		get_parent().get_child(2).get_child(0).show_keyboard_info(0)
		await get_tree().create_timer(2).timeout
		body.vsbl_musli(2, "Попробуй.")
		pass
