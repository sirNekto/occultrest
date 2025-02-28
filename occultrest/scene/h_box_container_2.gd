extends HBoxContainer

var label_fps: Label

func _process(delta: float) -> void:
	# Получаем FPS
	var fps = round(Engine.get_frames_per_second())


	# Получаем используемую видеопамять (в мегабайтах)
	var video_memory = Performance.get_monitor(Performance.RENDER_VIDEO_MEM_USED) / 1024 / 1024

	# Обновляем текст Label
	label_fps.text = "FPS: %d\nVRAM: %.2f MB" % [fps, video_memory]
