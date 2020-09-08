class JsonsController < ApplicationController
  skip_before_action :verify_authenticity_token, exclude: [:get_reservations]

  def post_city
    post_data = request.body.read
    cities = Facility.where(prefecture_id: post_data).select(:city).distinct
    render json: { cities: cities }
  end

  def post_name
    post_data = request.body.read
    names = Facility.where(city: post_data).select(:name).distinct
    render json: { names: names }
  end

  def post_area
    post_data = request.body.read
    areas = Facility.where(name: post_data).select(:area).distinct
    render json: { areas: areas }
  end

  def post_facility_id
    post_data = request.body.read
    hash = JSON.parse(post_data)
    facility_id = Facility.where(name: hash["name"], area: hash["area"])
    render json: { facility_id: facility_id }
  end

  def get_reservations
    reservations = Reservation.where(facility_id: params[:facility_id])
    json_reservations = []
    i = 0
    reservations.each do |e|
      json_reservations[i] = { title: e[:use_application], start: e[:start_time].strftime('%Y-%m-%dT%H:%M'), end: e[:end_time].strftime('%Y-%m-%dT%H:%M'), overrap: false }
      if current_user.admin
        if e.release
          json_reservations[i][:url] = team_path(e.team_id)
          json_reservations[i][:title] = "#{e[:use_application]} [チーム公開中] チーム名：#{e.team.name} TEL：#{e.user.phone_number}"
        else
          json_reservations[i][:title] = "#{e[:use_application]} TEL：#{e.user.phone_number}"
        end
      else
        if e.release
          json_reservations[i][:url] = team_path(e.team_id)
          json_reservations[i][:title] = "#{e[:use_application]} [チーム公開中] チーム名：#{e.team.name}"
        end
      end
      i += 1
    end
    render json: json_reservations
  end
end
