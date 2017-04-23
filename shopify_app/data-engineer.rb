require 'json'
require 'open-uri'

customers = JSON.load(open("https://gist.githubusercontent.com/udnay/d8e2ea75f2cfd7d75482f42549c31c59/raw/60da021e9f083f0c4bf0910f690baf5f38410bc6/customers.json"))

# first json file need to have only unique keys
orders = JSON.load(open("https://gist.githubusercontent.com/udnay/20603ff9956064c8d1f1abf7a5e6f5b2/raw/9e841b973a3d9d51940bdffe162c1400a9bac022/orders.json"))
order_key = "customer_id"

h = {}

customers.each do |customer|
	customer["customer_id"] = customer.delete("cid")
	#rename cid to match order_key
	h[customer[order_key]] = customer
	# key = cid, value = hash about customer
end

result = []

orders.each do |order|
	matching_customer = h[order[order_key]]
	# find from hash the cid = customer id  and store it in matching customer
	if matching_customer
	# if matching custoemr exists for order, merge the two hashes
		order.merge!(matching_customer)
		result << order
	end
end

def total_cost(arr, person)
	# total amount each person spent over all orders
	total = 0
	arr.each do |order|
		if order["name"] == person
			total += order["price"]
		end
	end
	total
end

result.count
# size of resulting array
total_barry_steve = total_cost(result, "Barry") + total_cost(result, "Steve")
 # sum price for barry and steve
