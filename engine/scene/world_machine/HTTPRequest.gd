extends HTTPRequest



func _ready():
	request_completed.connect(done)

	var error = request("https://httpbin.org/get")
	if error != OK:
		push_error("An error occurred in the HTTP request.")



	var body = JSON.stringify({"name": "Godette"})
	error = request("https://httpbin.org/post", [], HTTPClient.METHOD_POST, body)
	if error != OK:
		push_error("An error occurred in the HTTP request.")


func done(_result, _response_code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()

	print(response.headers["User-Agent"])
