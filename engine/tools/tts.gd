extends Node


# One-time steps.
# Pick a voice. Here, we arbitrarily pick the first English voice.
var voices = DisplayServer.tts_get_voices_for_language("en")
var voice_id = voices[0]

# Say "Hello, world!".
func _ready() -> void:
	DisplayServer.tts_speak("Hello, world!", voice_id)

	# Say a longer sentence, and then interrupt it.
	# Note that this method is asynchronous: execution proceeds to the next line immediately,
	# before the voice finishes speaking.
	var long_message = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur"
	DisplayServer.tts_speak(long_message, voice_id)

	# Immediately stop the current text mid-sentence and say goodbye instead.
	DisplayServer.tts_stop()
	DisplayServer.tts_speak("Goodbye!", voice_id)
