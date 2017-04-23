require 'json'
require 'open-uri'

avail_no = 0
orders = []

page = 1
while true do
	url = "https://backend-challenge-fall-2017.herokuapp.com/orders.json?page=#{page}"
	data = JSON.load(open(url))
	avail_no = data["available_cookies"]
	# store number of available cookies in variable
	if data["orders"].empty?
		# break when there there are no more orders on page
		break
	end
	orders += data["orders"]
	page += 1
end

orders.select! do |order|
 	order["fulfilled"] == false && order["products"].any? {|h| h["title"] == "Cookie"}
 # select only unfulfilled orders with cookies
end

orders.sort! do |o1, o2|
	if o1["products"][1]["amount"] != o2["products"][1]["amount"]
		o2["products"][1]["amount"] <=> o1["products"][1]["amount"]
		# sort by number of cookies DESC
	else
		o1["id"] <=> o2["id"]
		# fall back to id sort ASC
	end
end

unfulfilled = []

no, yea = orders.partition { |order| order["products"][1]["amount"] > avail_no}
# split array into order too large to fill and order small enough to fill

no.each {|order| unfulfilled << order["id"] }
# record the id of the unfillable order

yea.each do |order|
	if avail_no - order["products"][1]["amount"] >= 0
		avail_no -= order["products"][1]["amount"]
		order["fulfilled"] = true
		# go through orders and return fulfilled for orders that can be fulfilled
	else
		unfulfilled<< order["id"]
		# push order id of unfillable  orders into unfillable
	end
end

output = { "remaining_cookies": avail_no,
	"unfulfilled_orders": unfulfilled.sort }.to_json
#return answer as json
p output


