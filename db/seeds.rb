# Create users
10.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  user = User.create(
    username: first_name + "-" + last_name,
    email: Faker::Internet.safe_email(first_name + "." + last_name),
    password: Faker::Internet.password
  )
end

# Create choices
100.times do
  choice = Choice.create(title: Faker::Hipster.word, description: Faker::Hipster.sentence, user_id: Faker::Number.between(1, 11))
end

User.all.each do |user|
  choice = Choice.create(title: Faker::Hipster.word, description: Faker::Hipster.sentence, user_id: user.id)
end

# Create pros/cons
Choice.all.each do |choice|
  pro = Pro.create(choice_id: choice.id, user_id: Faker::Number.between(1, 11), description: Faker::ChuckNorris.fact, rank: Faker::Number.between(1, 100))
  con = Con.create(choice_id: choice.id, user_id: Faker::Number.between(1, 11), description: Faker::StarWars.quote, rank: Faker::Number.between(1, 100))
  pro.save!
  con.save!
  pro = Pro.create(choice_id: choice.id, user_id: Faker::Number.between(1, 11), description: Faker::ChuckNorris.fact, rank: Faker::Number.between(1, 100))
  con = Con.create(choice_id: choice.id, user_id: Faker::Number.between(1, 11), description: Faker::StarWars.quote, rank: Faker::Number.between(1, 100))
  pro.save!
  con.save!
end


50.times do
  pro = Pro.create(choice_id: Faker::Number.between(1, 200), user_id: Faker::Number.between(1, 11), description: Faker::ChuckNorris.fact, rank: Faker::Number.between(1, 100))
  con = Con.create(choice_id: Faker::Number.between(1, 200), user_id: Faker::Number.between(1, 11), description: Faker::StarWars.quote, rank: Faker::Number.between(1, 100))
  pro.save!
  con.save!
end
