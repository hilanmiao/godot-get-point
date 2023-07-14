extends Node2D

var container_width = 2400
var container_height = 800

var line_edit_width
var line_edit_height
var line_edit_point

@onready var file_dialog : FileDialog = $FileDialog
@onready var button_file : Button = get_node('CanvasLayerHUD/ButtonFile')
@onready var texture_rect : TextureRect = $TextureRect

# Called when the node enters the scene tree for the first time.
func _ready():
		
	line_edit_width = get_node('CanvasLayerHUD/VBoxContainer/HBoxContainer/LineEditWidth')
	line_edit_height = get_node('CanvasLayerHUD/VBoxContainer/HBoxContainer2/LineEditHeight')
	line_edit_point = get_node('CanvasLayerHUD/HBoxContainer3/LineEditPoint')
	
	line_edit_width.text = str(container_width)
	line_edit_height.text = str(container_height)
	line_edit_point.text = '0,0'
	
	# 信号
	button_file.pressed.connect(onButtonPressed)
	
	file_dialog.visible = false
	file_dialog.title = '选择一张图片'
	file_dialog.filters = ['*.png, *.jpg, *.jpeg ; Supported Images']
	file_dialog.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	file_dialog.access = FileDialog.ACCESS_FILESYSTEM
	file_dialog.ok_button_text = '确认'
	file_dialog.cancel_button_text = '取消'
	
	# 信号
	file_dialog.file_selected.connect(onFileSelected)

#	texture_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventMouseButton:
#		print('mouse click/unclick at: ', event.position)
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print('left button was clicked at ', event.position)
			var x = event.position.x
			var y = event.position.y
			line_edit_point.text = str(int(x)) + ','+ str(int(y))
			
			# 创建小圆点
			var sprite = Sprite2D.new()
			var icon = preload("res://location.png")
			sprite.set_texture(icon)
			sprite.scale = Vector2(0.3, 0.3)
			sprite.position = event.position
			add_child(sprite)
			

func onButtonPressed():
	file_dialog.visible = true
	
func onFileSelected(path): 
	print(path)

#	texture_rect.custom_minimum_size =  Vector2(10, 10)
	texture_rect.size = Vector2(container_width, container_height)
	texture_rect.texture = load(path)
	
