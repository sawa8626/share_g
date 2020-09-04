class ReservationsController < ApplicationController
  before_action :move_to_session, only: [:new, :create]

  def index
    @facility = Facility.find(params[:facility_id])
    @facilities = Facility.where(name: @facility.name)
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    unless (@reservation.start_time == nil) || (@reservation.end_time == nil)
      @reservation.start_time = @reservation.start_time.to_s(:db)
      @reservation.end_time = @reservation.end_time.to_s(:db)
    end
    if @reservation.save
      redirect_to facility_reservations_path(params[:facility_id])
    else
      render action: :new
    end 
  end

  private

  def move_to_session
    redirect_to new_user_session_path unless user_signed_in?
  end

  def reservation_params
    params.require(:reservation).permit(:start_time, :end_time, :use_application, :release).merge(user_id: current_user.id, facility_id: params[:facility_id])
  end
end
