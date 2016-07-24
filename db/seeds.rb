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

User.create(
  username: "kaileeagray",
  email: "kaileeagray@sample.com",
  password: "ilikeprocon123!"
)

# Create lists
100.times do
  list = List.create(title: Faker::Hipster.word, description: Faker::Hipster.sentence, user_id: Faker::Number.between(1, 11), created_at: Faker::Time.between(9.days.ago, Date.today, :midnight))
end

User.all.each do |user|
  5.times do
    list = List.create(title: Faker::Hipster.word, description: Faker::Hipster.sentence, user_id: user.id, created_at: Faker::Time.between(10.days.ago, Date.today, :midnight))
  end
end

# Create pros/cons
List.all.each do |list|
  5.times do
    pro = Pro.create(list_id: list.id, user_id: Faker::Number.between(1, 11), description: Faker::ChuckNorris.fact, weight: Faker::Number.between(1, 10))
    con = Con.create(list_id: list.id, user_id: Faker::Number.between(1, 11), description: Faker::StarWars.quote, weight: Faker::Number.between(1, 10))
    pro.save!
    con.save!
  end
end

User.create(
  username: "test3",
  email: "test3@sample.com",
  password: "test3isthebest?"
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

# use info from The Onion site

User.create(
  username: "the_onion",
  email: "theonion@sample.com",
  password: "theonionisfunny123!"
)


require 'nokogiri'
require 'open-uri'


class Scraper
    ## I picked out a few of the pro/con lists and scraped them for their content.

    @@all = ["http://www.theonion.com/graphic/pros-and-cons-of-screen-time-for-kids-38445", "http://www.theonion.com/graphic/pros-and-cons-of-going-to-grad-school-38467", "http://www.theonion.com/graphic/pros-and-cons-of-the-greek-system-38515", "http://www.theonion.com/graphic/pros-and-cons-raising-minimum-wage-50476", "http://www.theonion.com/graphic/pros-and-cons-freelance-employment-51603", "http://www.theonion.com/graphic/pros-and-cons-political-correctness-52003", "http://www.theonion.com/graphic/pros-and-cons-helicopter-parenting-52130", "http://www.theonion.com/graphic/pros-and-cons-attending-college-52701", "http://www.theonion.com/graphic/pros-and-cons-profit-colleges-53065", "http://www.theonion.com/graphic/pros-and-cons-taking-gap-year-52852", "http://www.theonion.com/graphic/pros-and-cons-standardized-testing-50388", "http://www.theonion.com/graphic/the-pros-and-cons-of-open-plan-offices-38377", "http://www.theonion.com/graphic/the-pros-and-cons-of-paying-college-athletes-38321"]


    def visit_all
      @@all.each do |url|
        @url = url
        self.get_page(url)
        self.make_list
      end
    end


    def get_page(url)
      # The .get_page instance method will be responsible
      # for using Nokogiri and open-uri to grab the entire HTML document from the web page.
      @doc = Nokogiri::HTML(open(url))
    end


    def make_list
      list = List.new
      list.user_id = User.find_by(username: "the_onion").id
      list.title =  @doc.css(".content-header").text.strip
      list.description = @doc.css(".content-text b").first.text
      list.source = @url
      list.save
      @doc.css(".content-text ul").first.css("li").collect do |pro|
        pro = Pro.create(list_id: list.id, user_id: User.find_by(username: "the_onion").id, description: pro.text, weight: Faker::Number.between(0, 10))
        pro.save!
      end
      @doc.css(".content-text ul")[1].css("li").collect do |con|
        con = Con.create(list_id: list.id, user_id: User.find_by(username: "the_onion").id, description: con.text, weight: Faker::Number.between(0, 10))
        con.save!
      end
      list.save!
    end

end

Scraper.new.visit_all
