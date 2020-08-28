class JsonsController < ApplicationController
  skip_before_action :verify_authenticity_token

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
end
