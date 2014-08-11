class User < ActiveRecord::Base
  validates :name, presence: true

  def self.shuffle
    @users = User.all

    position = (1..@users.count).to_a
    position.shuffle!

    @users.each_with_index do |user, index|
      user.position = position[index]
      user.save
    end
  end

  def self.zero_scores
    @user = User.all
    @user.each do |user|
      user.score = 0
      user.streak = 0
      user.save
    end
  end

end
