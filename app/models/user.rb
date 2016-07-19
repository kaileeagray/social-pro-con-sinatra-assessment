class User < ActiveRecord::Base
  has_many :lists
  has_many :pros, through: :lists
  has_many :cons, through: :lists

  has_secure_password


  def clear_data
    self.lists.each do |list|
      list.pros.each do |pro|
        pro.delete
      end
      list.cons.each do |con|
        con.delete
      end
      list.delete
    end
    self.lists.clear
    self.delete
  end

end
