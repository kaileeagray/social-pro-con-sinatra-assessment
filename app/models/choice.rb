class Choice < ActiveRecord::Base
  has_many :pros
  has_many :cons
  belongs_to :user

end
