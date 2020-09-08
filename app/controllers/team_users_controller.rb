class TeamUsersController < ApplicationController
  def update
    @team_user = TeamUser.new(team_id: params[:id], user_id: current_user.id)
    if @team_user.save
      redirect_to "/teams/#{params[:id]}"
    else
      redirect_to "/teams/#{params[:id]}"
    end 
  end

  def destroy
    @team_user = TeamUser.find_by(team_id: params[:id], user_id: current_user.id)
    if @team_user.destroy
      redirect_to "/teams/#{params[:id]}"
    else
      redirect_to "/teams/#{params[:id]}"
    end
  end

end
