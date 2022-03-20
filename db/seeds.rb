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

if User.count == 0
  User.create(
    email: "test@test.com",
    password: "test123"
  )
  puts "created a default user"
end

if Project.count == 0
  4.times do |i|
    Project.create(
      title: Faker::Movie.title,
      description: Faker::Lorem.paragraph_by_chars(number: 456, supplemental: false),
      start_date: Faker::Date.between(from: 1.months.ago, to: 2.days.from_now),
      due_date: Faker::Date.between(from: Date.today, to: 2.months.from_now),
      category_id: rand(1..6),
      user_id: 1,
      goal_amount: ("#{rand(1..9)}" + ("0"*rand(3..4))).to_i
    )
    puts "created a project"
  end
end