class Setting < ActiveRecord::Base
  validates :streak, :end, numericality: { only_integer: true }
end
