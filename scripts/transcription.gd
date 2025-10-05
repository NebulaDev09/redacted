extends Control

@onready var doc_text = $transcript
@onready var type_timer: Timer = $Timer

var full_text: String = ""
var visible_chars: int = 0
var typing_speed := 0.00000000001 # seconds per character
var overlay = ColorRect.new()

var translation = {
	'mudachi' : 'evil person',
	'durak': 'fool',
	'ponyatno': 'got it'
}

func _ready():
	# Add a timer node in your scene (TypeTimer) or create one here
	type_timer.wait_time = typing_speed
	#doc_text.text = "[center][b]CONFIDENTIAL[/b][/center]"
	
	# Example document text
	full_text = """
James: Hey, Azzy? Do you… feel any better?

Aster: Irrelevant. The hell do you want?

James: I just wanna talk about what happened, if I messed up somewhere, then I’m REALLY sorry, I swear, but-

Aster: I’ve had it up to HERE with this crap. Did I or did I not specifically ask you to NOT call me about this? Or did I not say it hard enough to get it through your thick skull?

James: I know you did, but still, I feel obligated to check up on you…

Aster: Is that so? Or is that just a preface to asking me about why I broke up with your sorry self?

James: I mean, I suppose so, but that doesn’t really change the fact th-

Aster: Always about James, is it not? Why did I, or hell, ANY person ever do something that pushes James away, or hurts his feelings, right? Inconceivable, utterly and truly, that. How dare anyone think for their own sake, and place James secondary in their mind? What kind of mudachi would do that, right?

James: If you could stop berating me for a moment, and maybe listen a little-

Aster: Oh I’ve BEEN listening. And I’m done. Utterly and totally. You genuine durak. Buffoon. Unless you want a repeat of what’s happened this time you better not call me again. Give me my time. If I feel like it, I’ll reach back out to you, ponyatno?

James: …alright. Be well, I suppose?

Aster: You’re not hearing it back.

*Call terminated*
"""
	
	#doc_text.bbcode_enabled = true
	doc_text.text = ""  # start empty
	visible_chars = 0
	doc_text.wrap_mode = true       # wraps text to avoid horizontal scroll
	doc_text.scroll_vertical = true   # vertical scroll
	doc_text.scroll_horizontal = false  # disable horizontal scroll
	
	type_timer.start()
	block_input()
	
func _process(delta: float) -> void:
	var selected = doc_text.get_selected_text()
	selected.strip_edges()
	for i in translation:
		if selected == i:
			var selection_start_line = doc_text.get_selection_from_line()
			var selection_start_column = doc_text.get_selection_from_column()
			var selection_end_line = doc_text.get_selection_to_line()
			var selection_end_column = doc_text.get_selection_to_column()
			doc_text.insert_text(translation[i],selection_start_line,selection_start_column)

func _on_timer_timeout() -> void:
	if visible_chars < full_text.length():
		visible_chars += 1
		doc_text.text = full_text.substr(0, visible_chars)
		doc_text.scroll_vertical = doc_text.get_line_count()
	else:
		overlay.queue_free()
		type_timer.stop()
	
func block_input():
	overlay.color = Color(0,0,0,0)
	overlay.size = get_viewport_rect().size
	overlay.mouse_filter = Control.MOUSE_FILTER_STOP
	add_child(overlay)
