extends Control

var text1=preload("res://assets/OK.png")
var text2=preload("res://assets/DEL.png")

var isSelected = false

func _on_TextureButton_pressed():
	if $Panel/VBoxContainer/HBoxContainer/LineEdit.text and not isSelected:
			add_item()
			$Panel/VBoxContainer/HBoxContainer/LineEdit.clear()
	elif isSelected:
		remove_selected_item()
			
func add_item():
	$Panel/VBoxContainer/ItemList.add_item ($Panel/VBoxContainer/HBoxContainer/LineEdit.text,null,true) # adding a new item
	$Panel/VBoxContainer/ItemList.set_item_metadata($Panel/VBoxContainer/ItemList.get_item_count()-1,{"active":false}) # making added item not active (items number is one to last)
func remove_selected_item():
	var it=$Panel/VBoxContainer/ItemList.get_selected_items()
	for n in it.size():
		$Panel/VBoxContainer/ItemList.remove_item(it [n])
	isSelected = false
	check_button()

func check_button():
	if isSelected:
		$Panel/VBoxContainer/HBoxContainer/TextureButton.texture_normal=text2;
	else:
		$Panel/VBoxContainer/HBoxContainer/TextureButton.texture_normal=text1;

func _on_LineEdit_text_entered(new_text):
	_on_TextureButton_pressed()
		
func unselect_list():
	isSelected = false
	$Panel/VBoxContainer/ItemList.unselect_all()
	check_button()

func _on_ItemList_nothing_selected():
	unselect_list()
	

func _on_item_list_item_activated(index):
	if $Panel/VBoxContainer/ItemList.get_item_metadata(index)["active"]==false:
		$Panel/VBoxContainer/ItemList.set_item_custom_bg_color(index.Color.darkgreen)
		$Panel/VBoxContainer/ItemList.set_item_metadata(index,{"active":true})
	else:
		$Panel/VBoxContainer/ItemList.set_item_custom_bg_color(index.Color(0,0,0,0))
		$Panel/VBoxContainer/ItemList.set_item_metadata(index,{"active":false})


func _on_item_list_item_selected(index):
	isSelected = true
	check_button()


func _on_line_edit_text_changed(new_text):
	if $Panel/VBoxContainer/ItemList.is_anything_selected():
		unselect_list()
