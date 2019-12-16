extends Node

const API_KEY = "AIzaSyDSVyawCG-_Fl2-JflunVrZRnlbknAaHKY";
const PROJECT_ID = "appfundum-1";

var user_info = {};

""""
func save_question(path: String, fields: Dictionary, http: HTTPRequest) :
    var document = { "fields": fields};
    var body = to_json(document);
    var url = FIRESTORE_URL + path;
    http.request(url, _get_request_headers(), false, HTTPClient.METHOD_POST, body);
    pass;

func get_document(path: String, http: HTTPRequest) :
    var url = FIRESTORE_URL + path;
    http.request(url, _get_request_headers(), false, HTTPClient.METHOD_GET);
    pass;

func update_document(path: String, http: HTTPRequest):
    var document = { "fields": fields};
    var body = to_json(document);
    var url = FIRESTORE_URL + path;
    http.request(url, _get_request_headers(), false, HTTPClient.METHOD_PATCH, body);
    pass;

func delete_document(path: String, http: HTTPRequest):
    var url = FIRESTORE_URL + path;
    http.request(url, _get_request_headers(), false, HTTPClient.METHOD_DELETE);
"""