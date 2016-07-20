class List < ActiveRecord::Base
  has_many :pros
  has_many :cons
  belongs_to :user


  def pro_sum
    self.pro_sum = self.pros.inject(0){|sum,x| sum + x.weight }
  end

  def con_sum
    self.con_sum = self.cons.inject(0){|sum,x| sum + x.weight }
  end

  def pro_con_sum
    self.pro_sum - self.con_sum
  end

end
