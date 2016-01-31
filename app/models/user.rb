class User < ActiveRecord::Base

  has_one :score
  validates_uniqueness_of :email

  after_create :create_score

  def create_score
    Score.create(user_id: self.id, points: 0.0)
  end

end
