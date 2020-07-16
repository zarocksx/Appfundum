extends Node

const API_KEY = "AIzaSyDSVyawCG-_Fl2-JflunVrZRnlbknAaHKY";
const PROJECT_ID = "appfundum-1";

const LOGIN_A := "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=%s" % API_KEY;
const FIRESTORE_URL := "https://firestore.googleapis.com/v1/projects/%s/databases/(default)/documents/" % PROJECT_ID;

var user_info = {};



func _ready():
	anonymous_register()

func get_http():
	var http_node
	http_node = HTTPRequest.new()
	http_node.set_name("httpFirebase")
	http_node.set_use_threads(true)
	http_node.connect("request_completed",self,"_request_completed")
	add_child(http_node)
	return http_node

func _get_user_info(result: Array):
	var result_body := JSON.parse(result[3].get_string_from_ascii()).result as Dictionary;
	return {
		"token": result_body.idToken,
		"id": result_body.localId
	};

func _get_request_headers():
	return PoolStringArray([
		"Content-Type: application/json",
		"Authorisation: Bearer %s" % user_info.token
	])

func anonymous_register():
	var http = get_http()
	http.request(LOGIN_A, ["Content-Length:0"], false, HTTPClient.METHOD_POST);
	var result = yield(http, "request_completed") as Array;
	if result[1] == 200:
		user_info = _get_user_info(result);
		_get_user_info(result);

func save_document(path: String, fields: Dictionary) :
	var document = {"fields" : fields};
	var body = to_json(document);
	var url = FIRESTORE_URL + path;
	print(get_http().request(url, _get_request_headers(), false, HTTPClient.METHOD_POST, body));

func save_analytics() :
	var fields = analytics.get_analytics_fields();
	var path = "analytics";
	var document = {"fields": fields};
	var body = to_json(document);
	var url = FIRESTORE_URL + path;
	print(fields)
	print("save response : %s",get_http().request(url, _get_request_headers(), false, HTTPClient.METHOD_POST, body));

func get_document(path: String) :
	var url = FIRESTORE_URL + path;
	print(get_http().request(url, _get_request_headers(), false, HTTPClient.METHOD_GET));

func update_document(path: String, fields:Dictionary):
	var document = { "fields" : fields };
	var body = to_json(document);
	var url = FIRESTORE_URL + path;
	print(get_http().request(url, _get_request_headers(), false, HTTPClient.METHOD_PATCH, body));
	pass;

func delete_document(path: String):
	var url = FIRESTORE_URL + path;
	print(get_http().request(url, _get_request_headers(), false, HTTPClient.METHOD_DELETE));
	pass;

func _request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray):
	match response_code:
		404:
			print("response error 404")
		200:
			print("response successfull")
	pass
