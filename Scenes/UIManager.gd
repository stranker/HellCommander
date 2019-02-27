extends CanvasLayer

var start_counter = false

func _ready():
	pass

func _process(delta):
	if start_counter:
		$StartCounter.text = "%2.2f" % get_parent().get_node("StartTimer").time_left

func stop_counter():
	start_counter = false
	$StartCounter.hide()

func _on_TestScene_count_start():
	start_counter = true
	$StartCounter.show()
	$StartCounter.text = str(get_parent().get_node("StartTimer").wait_time)
	pass # replace with function body
