class Facility < ApplicationRecord
  belongs_to :user
  has_many :reservations

  with_options presence: true do
    validates :prefecture_id
    validates :city
    validates :name
    validates :area
    validates :phone_number, length: { maximum:11 }
  end

  validates :price, numericality: { only_integer: true }

  extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to_active_hash :prefecture
end
