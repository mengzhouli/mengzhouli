# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
stuff = ["eat", "poo", "drink", "clean", "cook"]
tails = ["food", "poo", "water", "meats", "vodka"]
yes = [0, 1]

20.times do
  task = Task.new(
    name:   stuff.sample,
    detail: tails.sample,
    done:  yes.sample
  )
  task.save!
end
