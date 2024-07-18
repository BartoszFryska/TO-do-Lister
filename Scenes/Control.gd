extends Control

var text1=preload("res://assets/OK.png")
var text2=preload("res://assets/DEL.png")

var isSelected = false

func _on_TextureButton_pressed():
	if $Bkg/VBoxContainer/HBoxContainer/LineEdit.text and not isSelected:
			add_item()
			$Bkg/VBoxContainer/HBoxContainer/LineEdit.clear()
	elif isSelected:
		remove_selected_item()
			
func add_item():
	$Bkg/VBoxContainer/ItemList.add_item ($Bkg/VBoxContainer/HBoxContainer/LineEdit.text,null,true) # adding a new item
	$Bkg/VBoxContainer/ItemList.set_item_metadata($Bkg/VBoxContainer/ItemList.get_item_count()-1,{"active":false}) # making added item not active (items number is one to last)
func remove_selected_item():
	var it=$Bkg/VBoxContainer/ItemList.get_selected_items[0]
	$Bkg/VBoxContainer/ItemList.remove_item(it)
	isSelected = false
	check_button()

func check_button():
	if isSelected:
		$Bkg/VBoxContainer/HBoxContainer/TextureButton.texture_normal=text2;
	else:
		$Bkg/VBoxContainer/HBoxContainer/TextureButton.texture_normal=text1;

func _on_LineEdit_text_entered(new_text):
	_on_TextureButton_pressed()

func _on_ItemList_item_selected(index):
	isSelected = true
	check_button()
	
func _on_LineEdit_text_changed(new_text):
	if $Bkg/VBoxContainer/ItemList.is_anything_selected():
		unselect_list()
		
func unselect_list():
	isSelected = false
	$Bkg/VBoxContainer/ItemList.unselect_all()
	check_button()

func _on_ItemList_nothing_selected():
	unselect_list()
	
func _onItemlist_item_activated(index):
	if $Bkg/VBoxContainer/ItemList.get_item_metadata(index)["active"]==false:
		$Bkg/VBoxContainer/ItemList.set_item_custom_bg_color(index.Color.darkgreen)
		$Bkg/VBoxContainer/ItemList.set_item_metadata(index,{"active":true})
	else:
		$Bkg/VBoxContainer/ItemList.set_item_custom_bg_color(index.Color(0,0,0,0))
		$Bkg/VBoxContainer/ItemList.set_item_metadata(index,{"active":false})


func _on_item_list_item_activated(index):
	pass # Replace with function body.


func _on_item_list_item_selected(index):
	pass # Replace with function body.
