extends Node


var payment
var isPremium = false


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

func is_IAP_avalaible():
	return payment.isReady()

func buy(key = "skins_bundle_1"):
	var query = payment.queryPurchases("inapp") # Or "subs" for subscriptions
	print('---------------TENTATIVE D\'ACHAT-----------------')
	if query.status == OK:
		print('ok')
		for purchase in query.purchases:
			if purchase.sku == key:
				print('déjà acheté')
				return true
				if !purchase.is_acknowledged:
					print("is_acknowledged")
		print("achat")
		payment.purchase(key)
		

func _on_connected():
	print("check if player is premium")
	payment.querySkuDetails(["skins_bundle_1"], "inapp")

func _on_sku_details_query_completed(sku_details):
	print("_on_sku_details_query_completed")
	for query in sku_details:
		#print(query)
		pass
