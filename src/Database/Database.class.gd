class_name DB

# ======================================
# Vars
# ======================================

var resource_directory = ""
var _items = {}
var _item_ids = []
var _item_count = 0

# ======================================
# Overrides
# ======================================

func _init(resource_directory_: String):
	resource_directory = resource_directory_
	print("Creating database from: " + resource_directory)

	var directory = Directory.new()
	if (!directory.dir_exists(resource_directory)):
		print("Directory does not exist: " + resource_directory)
		return

	directory.open(resource_directory)
	directory.list_dir_begin()

	var filename = directory.get_next()
	var resource = null
	var name = ""

	while(filename):
		if !directory.current_is_dir():
			resource = load(resource_directory + "/" + filename)
			name = filename.get_basename()

			_item_ids.append(name)
			_items[name] = resource
			_item_count += 1
			print("Added to database: " + name)
		filename = directory.get_next()

	print("Done. Added " + str(_item_count) + " entries to database.\n")

# ======================================
# Methods
# ======================================

func get(item_name: String):
	return _items[item_name]

func get_by_index(item_id_index: int):
	return _items[_item_ids[item_id_index]]

func get_random():
	var item_id_index = Global.rng.randi_range(0, _item_count - 1)
	return get_by_index(item_id_index)

func get_count():
	return _item_count

