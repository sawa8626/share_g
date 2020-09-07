class TeamsController < ApplicationController
  before_action :move_to_session, except: [:show]

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    @team_users = @team.team_users.build(user_id: current_user.id)
    if @team.save && @team_users.save
      redirect_to root_path
    else
      render action: :new
    end
  end

  def show
    @team = Team.find(params[:id])
  end

  def edit
    @team = Team.find(params[:id])
  end

  def update
    @team = Team.find(params[:id])
    if @team.update(team_params)
      render action: :show
    else
      render action: :edit
    end
  end

  def destroy
    @team = Team.find(params[:id])
    redirect_to root_path if @team.destroy
  end

  private

  def move_to_session
    redirect_to new_user_session_path unless user_signed_in?
  end

  def team_params
    params.require(:team).permit(:name, :activity, :twitter_url, :facebook_url, :instagram_url, :content, :image)
  end
end
