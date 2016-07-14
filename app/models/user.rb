class User < ActiveRecord::Base
  has_many :lists
  has_many :pros, through: :lists
  has_many :cons, through: :lists

  has_secure_password

  def slug
    self.username.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    find_by(username: slug.gsub("-", " "))
  end

end
