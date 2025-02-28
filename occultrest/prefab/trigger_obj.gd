extends Node3D

var area: Area3D 

@export var list_text: Array[String] = ["Не туда","Нет туда","Аааа."]
@export var list_id: Array[int] = [0, 1, 0]
@export var list_time: Array[int] = [2, 2, 2]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area = get_child(0)
	area.connect("body_entered", _on_area_3d_body_entered)
	area.connect("body_exited", _on_area_3d_body_exited)
	 
	pass # Replace with function body.

var lock = false
var buffer_player = null
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_here != null and not lock:
		lock = true
		self.hide()
		 
		buffer_player = player_here
		for item in list_text: 
			buffer_player.vsbl_musli(list_id[list_text.find(item)], item) 
			await get_tree().create_timer(list_time[list_text.find(item)]).timeout 
		await get_tree().create_timer(2).timeout 
		buffer_player.vsbl_musli(0, " ") 
		buffer_player.vsbl_musli(1, " ") 
		buffer_player.vsbl_musli(2, " ") 
		queue_free()
		  

var player_here: CharacterBody3D = null
func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is player:
		player_here = body 


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body is player:
		player_here = null 

 
