extends Node

const API_KEY = "AIzaSyDSVyawCG-_Fl2-JflunVrZRnlbknAaHKY";
const PROJECT_ID = "appfundum-1";

const LOGIN_A = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=%s" % API_KEY;

var current_token = "";

var user_info = {};

func _get_token_id_anonymous(result: Array):
    print(result);
    return 1;

func anonymous_register(http: HTTPRequest):
    print(http.request(LOGIN_A, ["Content-Length:0"], false, HTTPClient.METHOD_POST));
    var result = yield(http, "request_completed") as Array;
    print(result);
    if result[1] == 200:
        current_token = _get_token_id_anonymous(result);

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