extends Node


const API_KEY = "AIzaSyDSVyawCG-_Fl2-JflunVrZRnlbknAaHKY";
const PROJECT_ID = "appfundum-1";
const LOGIN_A := "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=%s" % API_KEY;
const FIRESTORE_URL := "https://firestore.googleapis.com/v1/projects/%s/databases/(default)/documents/" % PROJECT_ID;
const FIRESTORE_BASE_URL := "https://firestore.googleapis.com/v1/";

var no_call = false
var curent_analytics;
var user_info = {};


func _ready():
	if OS.is_debug_build() and no_call:
		return
	anonymous_register()


func get_http(funcSign:String = "_request_completed"):
	var http_node
	http_node = HTTPRequest.new()
	http_node.set_name("httpFirebase")
	http_node.set_use_threads(true)
	http_node.connect("request_completed",self,funcSign)
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
	if OS.is_debug_build() and no_call :
		return
	var http = get_http()
	http.request(LOGIN_A, ["Content-Length:0"], false, HTTPClient.METHOD_POST);
	var result = yield(http, "request_completed") as Array;
	if result[1] == 200:
		print("logged")
		user_info = _get_user_info(result);


func save_analytics():
	if OS.is_debug_build() and no_call:
		return
	var fields = analytics.get_analytics_fields();
	var path = "analytics";
	var document = {"fields": fields};
	var body = to_json(document);
	var url = FIRESTORE_URL + path;
	print("save : ",get_http("_save_complete").request(url, _get_request_headers(), false, HTTPClient.METHOD_POST, body ));


func update_analytics():
	if OS.is_debug_build() and no_call:
		return
	var fields = analytics.get_analytics_fields();
	var document = {"fields": fields};
	var body = to_json(document);
	var url = FIRESTORE_BASE_URL + analytics.curent_analytics;
	push_warning(analytics.curent_analytics)
	get_http().request(url, _get_request_headers(), false, HTTPClient.METHOD_PATCH, body);


func save_document(path: String, fields: Dictionary):
	if OS.is_debug_build() and no_call:
		return
	var document = {"fields" : fields};
	var body = to_json(document);
	var url = FIRESTORE_URL + path;
	push_warning(get_http().request(url, _get_request_headers(), false, HTTPClient.METHOD_POST, body));


func update_document(path: String, fields:Dictionary):
	if OS.is_debug_build() and no_call:
		return
	var document = { "fields" : fields };
	var body = to_json(document);
	var url = FIRESTORE_URL + path;
	push_warning(get_http().request(url, _get_request_headers(), false, HTTPClient.METHOD_PATCH, body));


func get_document(path: String):
	var url = FIRESTORE_URL + path;
	push_warning(get_http().request(url, _get_request_headers(), false, HTTPClient.METHOD_GET));


func delete_document(path: String):
	var url = FIRESTORE_URL + path;
	push_warning(get_http().request(url, _get_request_headers(), false, HTTPClient.METHOD_DELETE));


func _request_completed(_result: int, response_code: int, _headers: PoolStringArray, body: PoolByteArray):
	match response_code:
		404:
			push_warning("response error 404")
			push_warning(body.get_string_from_ascii())
		200:
			push_warning("response successfull")
		_:
			push_warning(body.get_string_from_ascii())


func _save_complete(_result: int, response_code: int, _headers: PoolStringArray, body: PoolByteArray):
	match response_code :
		404:
			push_error("response error 404")
			push_error(JSON.parse( body.get_string_from_ascii() ).result)
		200:
			push_warning("response successfull")
			analytics.curent_analytics = JSON.parse( body.get_string_from_ascii() ).result.name
		_:
			push_warning(body.get_string_from_ascii())
			push_warning(analytics.get_analytics_fields())