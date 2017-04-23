require "csv"
filepath    = 'shoes.csv'
csv_options = { col_sep: ',', headers: true, row_sep: :auto}
row_count = 0
# count how many total orders
average_total = 0
# runnign average
running_total = 0
# running average of total cost
CSV.foreach(filepath, csv_options) do |row|
	running_total += row["order_amount"].to_f
	average_total += row["order_amount"].to_f / row["total_items"].to_f
	row_count += 1
end

p wrong_aov = (running_total / row_count).round(2)
p aov = (average_total / row_count).round(2)