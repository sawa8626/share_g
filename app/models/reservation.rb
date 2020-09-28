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

  private

  def self.get_reservations_by_facility(reservations, json_reservations, user_admin)
    i = 0
    reservations.each do |e|
      json_reservations[i] = { title: e[:use_application], start: e[:start_time].strftime('%Y-%m-%dT%H:%M'), end: e[:end_time].strftime('%Y-%m-%dT%H:%M'), overrap: false }
      if user_admin
        if e.release
          json_reservations[i][:url] = "/teams/#{e.team_id}"
          json_reservations[i][:title] = "#{e[:use_application]} [チーム公開中] チーム名：#{e.team.name} TEL：#{e.user.phone_number}"
        else
          json_reservations[i][:title] = "#{e[:use_application]} TEL：#{e.user.phone_number}"
        end
      else
        if e.release
          json_reservations[i][:url] = "/teams/#{e.team_id}"
          json_reservations[i][:title] = "#{e[:use_application]} [チーム公開中] チーム名：#{e.team.name}"
        end
      end
      i += 1
    end
  end
end
