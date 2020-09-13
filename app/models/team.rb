class Team < ApplicationRecord
  has_many :reservations, dependent: :destroy
  has_many :team_users, dependent: :destroy
  has_many :users, through: :team_users
  has_one_attached :image

  with_options presence: true do
    validates :name
    validates :activity
    validates :image
    validates :content
  end
end
