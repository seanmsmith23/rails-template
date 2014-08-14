class Setting < ActiveRecord::Base
  validates :streak, :end, numericality: { only_integer: true, less_than: 20 }
end
