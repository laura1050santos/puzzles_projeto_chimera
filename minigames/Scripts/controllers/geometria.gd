extends CanvasLayer

@onready var controler = preload("res://Scripts/controllers/Controller.gd").new()
@onready var button = $content/QuestionHolder/Button
@onready var button2 = $content/QuestionHolder/Button2
@onready var button3 = $content/QuestionHolder/Button3
@onready var button4 = $content/QuestionHolder/Button4
@onready var labelPergunta =$content/Question_info/QuestionText
var pergunta
var auxiliar
var resposta 
var botoes = []
var respostas=[]
var indice: int = 0
var pontos= 0

func _ready() -> void:
	randomize()
	auxiliar = controler.gerar_pergunta_por_tema(indice)
	pergunta = auxiliar[0]
	resposta = auxiliar[1]
	botoes.append(button)
	botoes.append(button2)
	botoes.append(button3)
	botoes.append(button4)

	for i in botoes.size():
		botoes[i].pressed.connect(func():
			_on_button_pressed(botoes[i])
		)
		gerar_botoes_resposta2(resposta)
		comecar_jogo()
		_on_button_pressed(resposta)

func comecar_jogo():
	labelPergunta.text = str(pergunta)
	for i in botoes.size():
		botoes[i].text= respostas[i]

func _on_button_pressed(resposta_player):
	if resposta_player.text == str(resposta):
		pontos+=0.5
		comecar_jogo()
	else:
		emit_signal("pontuacao",self, pontos)
		print("mandando sinal para o jogo")
		get_tree().quit()
		
	
func gerar_botoes_resposta2(resposta):
	var posicao = randi_range(0,3)
	for i in range(4):
		var aux = 0
		var valores_usados =[resposta]
		if posicao == i:
			botoes[i].text =str(resposta)
			aux = resposta
		else:
			while true:
				var diferenca = randi_range(-5,5)
				aux = resposta + diferenca
				if( diferenca == 0 and not aux in valores_usados):
					pass
				else: 
					break
			valores_usados.append(aux)
			botoes[i].text = str(aux)
	return botoes
