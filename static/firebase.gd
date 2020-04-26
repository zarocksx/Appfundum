extends Node

const API_KEY = "AIzaSyDSVyawCG-_Fl2-JflunVrZRnlbknAaHKY";
const PROJECT_ID = "appfundum-1";

const LOGIN_A := "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=%s" % API_KEY;
const FIRESTORE_URL := "https://firestore.googleapis.com/v1/projects/%s/databases/(default)/documents/" % PROJECT_ID;

onready var http = get_node('/root/Node2D/HTTPRequest');

var user_info = {};

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
	http.request(LOGIN_A, ["Content-Length:0"], false, HTTPClient.METHOD_POST);
	var result = yield(http, "request_completed") as Array;
	if result[1] == 200:
		user_info = _get_user_info(result);
		print(_get_user_info(result));
	pass;

func save_document(path: String, fields: Dictionary) :
	var document = { "fields": fields};
	var body = to_json(document);
	var url = FIRESTORE_URL + path;
	http.request(url, _get_request_headers(), false, HTTPClient.METHOD_POST, body);
	pass;

func get_document(path: String) :
	var url = FIRESTORE_URL + path;
	http.request(url, _get_request_headers(), false, HTTPClient.METHOD_GET);
	pass;

func update_document(path: String, fields:Dictionary):
	var document = { "fields": fields};
	var body = to_json(document);
	var url = FIRESTORE_URL + path;
	http.request(url, _get_request_headers(), false, HTTPClient.METHOD_PATCH, body);
	pass;

func delete_document(path: String):
	var url = FIRESTORE_URL + path;
	http.request(url, _get_request_headers(), false, HTTPClient.METHOD_DELETE);
	pass;
