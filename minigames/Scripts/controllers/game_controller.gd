extends Node

@export var quiz: QuizTheme
@export var color_right: Color
@export var color_wrong: Color
@onready var question_text: Label = $content/Question_info/QuestionText

var buttons: Array[Button]
var index: int
var correct: int

func _ready() -> void:
	for button in $content/QuestionHolder.get_children():
		buttons.append(button)
		
func load_quiz() -> void:
	pass
