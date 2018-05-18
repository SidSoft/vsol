class Smail < ActiveRecord::Base
  validates :message, presence: true
  validates :scheduled_at, presence: true
end
