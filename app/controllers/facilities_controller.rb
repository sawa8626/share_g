class FacilitiesController < ApplicationController
  before_action :move_to_root, except: [:index]
  before_action :create_instance, only: [:index, :new]

  def index
    (@user_teams = User.find(current_user.id).teams) if user_signed_in?
    @temp_data = Facility.none
  end

  def new
  end

  def create
    @facility = Facility.new(facility_params)
    if @facility.save
      redirect_to root_path
    else
      render action: :new
    end 
  end

  private

  def move_to_root
    redirect_to root_path unless current_user.admin
  end

  def create_instance
    @facility = Facility.new
  end

  def facility_params
    params.require(:facility).permit(:prefecture_id, :city, :name, :area, :phone_number, :price, :rule).merge(user_id: current_user.id)
  end
end
