extends Node


var payment
var connected = false
var premium = false


func _ready():
	print("start IAP service")
	if Engine.has_singleton("GodotGooglePlayBilling"):
		print("got payement singleton")
		payment = Engine.get_singleton("GodotGooglePlayBilling")

		# These are all signals supported by the API
		# You can drop some of these based on your needs
		payment.connect("connected", self, "_on_connected") # No params
		payment.connect("disconnected", self, "_on_disconnected") # No params
		payment.connect("connect_error", self, "_on_connect_error") # Response ID (int), Debug message (string)
		payment.connect("purchases_updated", self, "_on_purchases_updated") # Purchases (Dictionary[])
		payment.connect("purchase_error", self, "_on_purchase_error") # Response ID (int), Debug message (string)
		payment.connect("sku_details_query_completed", self, "_on_sku_details_query_completed") # SKUs (Dictionary[])
		payment.connect("sku_details_query_error", self, "_on_sku_details_query_error") # Response ID (int), Debug message (string), Queried SKUs (string[])
		payment.connect("purchase_acknowledged", self, "_on_purchase_acknowledged") # Purchase token (string)
		payment.connect("purchase_acknowledgement_error", self, "_on_purchase_acknowledgement_error") # Response ID (int), Debug message (string), Purchase token (string)

		payment.startConnection()
	else:
		printerr("Android IAP support is not enabled. Make sure you have enabled 'Custom Build' and the GodotGooglePlayBilling plugin in your Android export settings! IAP will not work.")


func _on_connected():
	print("---Connection")
	connected = true
	payment.querySkuDetails(["skins_bundle_1"], "inapp")


func _on_disconnected():
	connected = false
	print("---Disconnected")


func _on_connect_error(response_ID, debug_message):
	connected = false
	print("---Connection error")
	print("can't connect to google API for IAP. Response ID: ",response_ID,"| Debug message: ",debug_message)


func _on_purchases_updated(purchases):
	print("---Purchases updated")
	for purchase in purchases:
		if !purchase.is_acknowledged:
			payment.acknowledgePurchase(purchase.purchase_token)


func _on_purchase_error(_response_ID, _debug_message):
	print(_debug_message)
	AppfundumAchievement.show_current_achievement_item("Erreur","Erreur lors de la tentative d'achat.","error")


func _on_sku_details_query_completed(_sku_details):
	pass


func _on_sku_details_query_error(response_ID, debug_message, queried_skus):
	print("Error while trying to query sku details. Response ID: ",response_ID,"| Debug message: ",debug_message," | Queried Skus: ",queried_skus)


func _on_purchase_acknowledged(purchase_token):
	print("Purchase acknowledged:",purchase_token)
	pass


func _on_purchase_acknowledgement_error(response_ID, debug_message, purchase_token):
	print("Error while trying to acknowled. Response ID: ",response_ID,"| Debug message: ",debug_message," | Purchasetoken: ",purchase_token)
	pass

func buy(key = "skins_bundle_1"):
	if !connected :
		AppfundumAchievement.show_current_achievement_item("Erreur","Impossible de faire un achat sans être connecté","error")
	var query = payment.queryPurchases("inapp")
	print("---Try to buy")
	if query.status == OK:
		print("---Query purchase completed")
		for purchase in query.purchases:
			if purchase.sku == key:
				print("---Already buyed")
				Save.save('buy',"1")
				if !purchase.is_acknowledged:
					payment.acknowledgePurchase(purchase.purchase_token)
				return true
		print("--Start buy")
		print(payment.purchase(key))
		Save.save('buy',"1")
