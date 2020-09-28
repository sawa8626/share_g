class TeamUsersController < ApplicationController
  before_action :move_to_session

  def update
    @team_user = TeamUser.new(team_id: params[:id], user_id: current_user.id)
    if @team_user.save
      redirect_to team_path(params[:id])
    else
      redirect_to team_path(params[:id])
    end 
  end

  def destroy
    @team_user = TeamUser.find_by(team_id: params[:id], user_id: current_user.id)
    if @team_user.destroy
      redirect_to team_path(params[:id])
    else
      redirect_to team_path(params[:id])
    end
  end

  private

  def move_to_session
    redirect_to new_user_session_path unless user_signed_in?
  end

end
