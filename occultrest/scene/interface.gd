extends CanvasLayer

@export var quest_name: Array[String] = ["...","Осмотреть откуда идёт свет","Иследовать","Собрать все записки.","Собрать ВСЕ записки."]

var quest_stroka: RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	quest_stroka = get_child(0).get_child(0).get_child(1).get_child(1)
	pass # Replace with function body.

func show_keyboard_info(id):
	match id:
		0:
			get_child(0).get_child(0).get_child(5).show()
		1:
			get_child(0).get_child(0).get_child(6).show()
			
func quest_set(id):
	quest_stroka.text = quest_name[id]
						
			

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
