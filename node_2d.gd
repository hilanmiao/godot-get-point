extends Node2D

# 定义变量
var container_width: int = 1920
var container_height: int = 1080

var line_edit_width : LineEdit
var line_edit_height : LineEdit
var line_edit_point : LineEdit

# 获取节点方式1
@onready var file_dialog : FileDialog = $FileDialog
@onready var button_file : Button = get_node('CanvasLayerHUD/ButtonFile')
@onready var texture_rect : TextureRect = $TextureRect
@onready var button_setting: Button = get_node('CanvasLayerHUD/ButtonSetting')

# 定义信号
signal draw_point(event)

# Called when the node enters the scene tree for the first time.
func _ready():
		
	# 获取节点方式2	
	line_edit_width = get_node('CanvasLayerHUD/VBoxContainer/HBoxContainer/LineEditWidth')
	line_edit_height = get_node('CanvasLayerHUD/VBoxContainer/HBoxContainer2/LineEditHeight')
	line_edit_point = get_node('CanvasLayerHUD/HBoxContainer3/LineEditPoint')
	
	line_edit_width.text = str(container_width)
	line_edit_height.text = str(container_height)
	line_edit_point.text = '0,0'
	
	# 设置窗口大小-信号
	button_setting.pressed.connect(onButtonSettingPressed)
	
	# 选择文件按钮-信号
	button_file.pressed.connect(onButtonFilePressed)

	# 文件选择对话框-配置
	file_dialog.visible = false
	file_dialog.title = '选择一张图片'
	file_dialog.filters = ['*.png, *.jpg, *.jpeg ; Supported Images']
	file_dialog.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	file_dialog.access = FileDialog.ACCESS_FILESYSTEM
	file_dialog.ok_button_text = '确认'
	file_dialog.cancel_button_text = '取消'
	
	# 文件选择对话框-信号
	file_dialog.file_selected.connect(onFileSelected)

#	texture_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE

	self.draw_point.connect(onDrawPoint)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass	

#func _input(event):
#	if event is InputEventMouseButton:
#		print('input:')
#		# 阻止事件的传播
#		get_tree().get_root().set_input_as_handled()

func _unhandled_input(event):
	# 鼠标按钮
	if event is InputEventMouseButton:
		print('unhandled input:', event)
#		print('mouse click/unclick at: ', event.position)
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
#			print('left button was clicked at ', event.position)
#			var x = event.position.x
#			var y = event.position.y
#			var location = str(int(x)) + ','+ str(int(y))
#			line_edit_point.text = location
#
#			# 创建小圆点 
#			var sprite = Sprite2D.new()
#			var icon = preload("res://location.png")
#			sprite.set_texture(icon)
#			sprite.scale = Vector2(0.3, 0.3)
#			sprite.position = event.position
#			add_child(sprite)
#
#			# 粘贴板
#			DisplayServer.clipboard_set(location)
			# 使用定义的方法
#			onDrawPoint(event)
			emit_signal('draw_point', event)
		
# 生成点标记		
func onDrawPoint(event):
	print('signal:', event)
	var x = event.position.x
	var y = event.position.y
	var location = str(int(x)) + ','+ str(int(y))
	line_edit_point.text = location
	
	# 创建小圆点 
	var sprite = Sprite2D.new()
	var icon = preload("res://location.png")
	sprite.set_texture(icon)
	sprite.scale = Vector2(0.5, 0.5)
	sprite.position = event.position
	print(sprite.get_rect())
	sprite.offset = Vector2(0, -64)
	add_child(sprite)
	
	# 粘贴板
	DisplayServer.clipboard_set(location)
				
				
func onButtonSettingPressed():
	# 设置窗口大小
	var size = Vector2i(int(line_edit_width.text), int(line_edit_height.text))
	DisplayServer.window_set_size(size)
	# 改变内容大小
	get_viewport().content_scale_size = size
	# 设置纹理大小
	texture_rect.size = size
	
	print(DisplayServer.window_get_size())
	print(get_viewport_rect().size)
	print(texture_rect.size)

# 信号-选择文件按钮-按下
func onButtonFilePressed():
	file_dialog.visible = true
	
# 信号-选择文件确认
func onFileSelected(path): 
	print(path)

#	texture_rect.custom_minimum_size =  Vector2(10, 10)
	texture_rect.size = Vector2(container_width, container_height)
	texture_rect.texture = load(path)


	
