require 'json'
require 'open-uri'

h = {}
i = 1
while i < 4 do
	url = "https://backend-challenge-fall-2017.herokuapp.com/orders.json?page=#{i}"
	h[i] = JSON.load(open(url))
	#create a new hash k-v pair for each page read
	i += 1
end

avail_no = h[1]["available_cookies"]
# store number of currently available cookeis in variable


def sort_filter(h)
#function returns sorted orders with unfulfilled cookie orders
	filtered = []
	h.each do |k, v|
		arr = v["orders"]
		arr.select! do |order|
		 order["fulfilled"] == false && order["products"].any? {|h| h["title"] == "Cookie"}
		 # select only unfulfilled orders with cookies
		end
		filtered += arr
		# put results into one array
	end
	filtered.sort_by! do |order|
		order["products"][1]["amount"]
	end
end

a2 = sort_filter(h)
unfulfilled = []

no, yea = a2.partition { |order| order["products"][1]["amount"] > 6}
unfulfilled << no[0]["id"]



yea.each do |order|
	if avail_no - order["products"][1]["amount"] >= 0
		avail_no -= order["products"][1]["amount"]
		order["fulfilled"] = true
	else
		unfulfilled<< order["id"]
	end
end

output = { "remaining_cookies": avail_no,
	"unfulfilled_orders": unfulfilled.reverse }.to_json

p output



