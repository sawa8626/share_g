class Team < ApplicationRecord
  has_many :reservations
  has_many :team_users
  has_many :users, through: :team_users
  has_one_attached :image
end
