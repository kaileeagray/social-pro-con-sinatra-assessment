# # Create users
# 10.times do
#   first_name = Faker::Name.first_name
#   last_name = Faker::Name.last_name
#   user = User.create(
#     username: first_name + "-" + last_name,
#     email: Faker::Internet.safe_email(first_name + "." + last_name),
#     password: Faker::Internet.password
#   )
# end
#
# User.create(
#   username: "test",
#   email: "test@sample.com",
#   password: "test"
# )
#
# # Create lists
# 100.times do
#   list = List.create(title: Faker::Hipster.word, description: Faker::Hipster.sentence, user_id: Faker::Number.between(1, 11))
# end
#
# User.all.each do |user|
#   5.times do
#     list = List.create(title: Faker::Hipster.word, description: Faker::Hipster.sentence, user_id: user.id)
#   end
# end
#
# # Create pros/cons
# List.all.each do |list|
#   5.times do
#     pro = Pro.create(list_id: list.id, user_id: Faker::Number.between(1, 11), description: Faker::ChuckNorris.fact, rank: Faker::Number.between(1, 10))
#     con = Con.create(list_id: list.id, user_id: Faker::Number.between(1, 11), description: Faker::StarWars.quote, rank: Faker::Number.between(1, 10))
#     pro.save!
#     con.save!
#   end
# end
#
#
# 50.times do
#   pro = Pro.create(list_id: Faker::Number.between(1, 150), user_id: Faker::Number.between(1, 11), description: Faker::ChuckNorris.fact, rank: Faker::Number.between(1, 10))
#   con = Con.create(list_id: Faker::Number.between(1, 150), user_id: Faker::Number.between(1, 11), description: Faker::StarWars.quote, rank: Faker::Number.between(1, 10))
#   pro.save!
#   con.save!
# end

User.create(
  username: "test",
  email: "test@sample.com",
  password: "test"
)

User.create(
  username: "test2",
  email: "test2@sample.com",
  password: "test2"
)

User.all.each do |user|
  5.times do
    list = List.create(title: Faker::Hipster.word, description: Faker::Hipster.sentence, user_id: user.id)
  end
end

# Create pros/cons
List.all.each do |list|
  5.times do
    pro = Pro.create(list_id: list.id, user_id: Faker::Number.between(1, 11), description: Faker::ChuckNorris.fact, rank: Faker::Number.between(1, 10))
    con = Con.create(list_id: list.id, user_id: Faker::Number.between(1, 11), description: Faker::StarWars.quote, rank: Faker::Number.between(1, 10))
    pro.save!
    con.save!
  end
end
