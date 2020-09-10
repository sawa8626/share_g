class Reservation < ApplicationRecord
  belongs_to :facility
  belongs_to :user
  belongs_to :team, optional: true

  with_options presence: true do
    validates :use_application
    validates :start_time
    validates :end_time
  end
  validates :release, inclusion: { in: [true, false] }
end
