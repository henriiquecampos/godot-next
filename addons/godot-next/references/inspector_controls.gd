extends Reference
class_name InspectorControls

const ADD_ICON = preload("res://addons/godot-next/icons/icon_add.svg")

class DropdownAppender extends HBoxContainer:
	
	func get_button() -> ToolButton:
		return get_node("ToolButton") as ToolButton
	
	func get_dropdown() -> OptionButton:
		return get_node("Dropdown") as OptionButton
	
	func get_selected_label() -> String:
		var dropdown := get_dropdown()
		var index := dropdown.get_selected_id()
		return dropdown.get_item_text(index)
	
	func get_selected_meta():
		return get_dropdown().get_selected_metadata()

static func new_button(p_label: String, p_object = null, p_callback: String = "") -> Button:
	var button = Button.new()
	button.text = p_label
	button.name = "Button"
	
	if p_object and p_callback:
		button.connect("pressed", p_object, p_callback)

	return button

static func new_tool_button(p_icon_name: String, p_object = null, p_callback: String = "") -> ToolButton:
	return null

static func new_dropdown(p_elements: Dictionary, p_object = null, p_callback: String = "") -> OptionButton:
	var dropdown := OptionButton.new()
	var index = 0
	for a_label in p_elements:
		dropdown.add_item(a_label, index)
		dropdown.set_item_metadata(index, p_elements[a_label])
		index += 1
	dropdown.name = "Dropdown"
	dropdown.size_flags_horizontal = HBoxContainer.SIZE_EXPAND_FILL
	
	if p_object and p_callback:
		dropdown.connect("item_selected", p_object, p_callback, [dropdown])
	
	return dropdown

static func new_dropdown_appender(p_elements: Dictionary, p_object = null, p_callback: String = "") -> DropdownAppender:
	var dropdown_appender := DropdownAppender.new()
	
	var dropdown := new_dropdown(p_elements)
	
	var tool_button = ToolButton.new()
	tool_button.name = "ToolButton"
	tool_button.icon = ADD_ICON
	
	dropdown_appender.add_child(dropdown)
	dropdown_appender.add_child(tool_button)
	
	if p_object and p_callback:
		tool_button.connect("pressed", p_object, p_callback, [dropdown_appender])
	
	return dropdown_appender