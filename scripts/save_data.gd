class_name SaveData extends Resource

@export var high_score_1: int = 0
@export var high_score_2: int = 0
@export var high_score_3: int = 0
@export var high_score_4: int = 0
@export var high_score_5: int = 0

const SAVE_PATH: String = "user://high_scores.tres"

func save() -> void:
	ResourceSaver.save(self, SAVE_PATH)
	
static func load_or_create() -> SaveData:
	var res:SaveData
	if FileAccess.file_exists(SAVE_PATH):
		res = load(SAVE_PATH) as SaveData
	else:
		res = SaveData.new()
	return res
