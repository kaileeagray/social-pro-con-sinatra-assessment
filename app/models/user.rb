class User < ActiveRecord::Base
  has_many :choices
  has_many :pros, through: :choices
  has_many :cons, through: :choices

  has_secure_password


end
