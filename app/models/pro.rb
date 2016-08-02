class Pro < ActiveRecord::Base

  belongs_to :list, dependent: :destroy
  belongs_to :user

end
