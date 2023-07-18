extends LineEdit

@onready var line_edit: LineEdit = get_node('/root/Node2D/CanvasLayerHUD/VBoxContainer/HBoxContainer/LineEditWidth')

# Called when the node enters the scene tree for the first time.
func _ready():
	# 不正确，需要等待下一帧
	# 对于一组节点，_ready 回调是按相反的顺序调用的，从子节点开始，向上移动到父节点。
	# 这意味着，当把一个节点添加到场景树中时，将使用下面的顺序进行回调：父节点的 _enter_tree、子节点的 _enter_tree、子节点的 _ready，最后是父节点的 _ready（对整个场景树进行递归）。
	print(self.global_position)

#	self.mouse_entered.connect(onMouseEntered)
#	self.mouse_exited.connect(onMouseExited)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	pass

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print('gui input:', event)
	#		accept_event() 
			# 使用父节点信号	
			#get_node('/root/Node2D').emit_signal('draw_point', event)
			# 事件坐林标是相对于控件原点的，所有要计算下
			# 此时的global_position 是准确的
			var x = line_edit.global_position.x + event.position.x
			var y = line_edit.global_position.y + event.position.y
			event.position = Vector2(x, y)
			get_node('/root/Node2D').emit_signal('draw_point', event)

#func onMouseEntered():
#	print('mouse entered:')
#	mouse_filter = Control.MOUSE_FILTER_IGNORE
#	var ev = InputEventMouseButton.new()
#	ev.button_index = 1
#	ev.pressed = true
#	Input.parse_input_event(ev)
	

#func onMouseExited():
#	print('mouse exited:')
#	mouse_filter = Control.MOUSE_FILTER_PASS
	
