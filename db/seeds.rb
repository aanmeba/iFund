# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

categories = ["tech", "publishing", "craft", "art", "games", "emergency"]

if Category.count == 0
  categories.each do |c|
    Category.create(name: c)
    puts "created #{c} category"
  end
end

statues = ["ongoing", "upcoming", "passed"]

if Status.count == 0
  statues.each do |s|
    Status.create(name: s)
    puts "created #{s} status"
  end
end

if Project.count == 0
  
end