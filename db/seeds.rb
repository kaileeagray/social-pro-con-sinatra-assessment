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
#     pro = Pro.create(list_id: list.id, user_id: Faker::Number.between(1, 11), description: Faker::ChuckNorris.fact, weight: Faker::Number.between(1, 10))
#     con = Con.create(list_id: list.id, user_id: Faker::Number.between(1, 11), description: Faker::StarWars.quote, weight: Faker::Number.between(1, 10))
#     pro.save!
#     con.save!
#   end
# end


# user test3 will only have pro cons that test3 created
User.create(
  username: "test3",
  email: "test3@sample.com",
  password: "test3"
)

# with the random select of user_ids most of the pros/cons were from other users. So, add this seed to make sure the user has the largest number of pros/cons in their lists
# also force timestamps to increase variety on homepage

User.all.each do |user|
  5.times do
      list = List.create(title: Faker::Company.bs, description: Faker::Lorem.paragraph(2), user_id: user.id, created_at: Faker::Time.between(4.days.ago, Date.today, :midnight))
  end
  user.lists.each do |list|
    15.times do
      pro = Pro.create(list_id: list.id, user_id: user.id, description: Faker::Hacker.say_something_smart, weight: Faker::Number.between(1, 10))
      con = Con.create(list_id: list.id, user_id: user.id, description: Faker::StarWars.quote, weight: Faker::Number.between(1, 10))
      pro.save!
      con.save!
    end
  end
end
