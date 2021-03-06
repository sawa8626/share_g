class JsonsController < ApplicationController
  skip_before_action :verify_authenticity_token, except: [:get_reservations]

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
    if user_signed_in?
      user_admin = current_user.admin
    else
      user_admin = false
    end
    Reservation.get_reservations_by_facility(reservations, json_reservations, user_admin)
    render json: json_reservations
  end
end
