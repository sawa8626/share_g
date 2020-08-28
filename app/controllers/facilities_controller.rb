class FacilitiesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :move_to_root, except: [:index, :post_json_city, :post_json_name, :post_json_area]

  def index
    @facility = Facility.new
    @temp_data = Facility.none
  end

  def new
    @facility = Facility.new
  end

  def create
    @facility = Facility.new(facility_params)
    if @facility.save
      redirect_to root_path
    else
      render action: :new
    end 
  end

  def post_json_city
    post_data = request.body.read
    cities = Facility.where(prefecture_id: post_data).select(:city).distinct
    render json: { cities: cities }
  end

  def post_json_name
    post_data = request.body.read
    names = Facility.where(city: post_data).select(:name).distinct
    render json: { names: names }
  end

  def post_json_area
    post_data = request.body.read
    areas = Facility.where(name: post_data).select(:area).distinct
    render json: { areas: areas }
  end

  private

  def move_to_root
    redirect_to root_path unless current_user.admin
  end

  def facility_params
    params.require(:facility).permit(:prefecture_id, :city, :name, :area, :phone_number, :price, :rule).merge(user_id: current_user.id)
  end
end
