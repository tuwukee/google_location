class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_user, :except => [:index]

  def index
    @users = User.all
  end

  def show
    @json = @user.to_gmaps4rails
  end

  def update
    @user.update_attributes(params[:user])
  end

  def wall_post
    auth = @user.authentications.find(:first, :conditions => { :provider => 'facebook' })

    if auth
      api = Koala::Facebook::API.new(auth.token)
      fql = api.fql_query("SELECT page_id, name, description, display_subtext FROM place WHERE distance(latitude, longitude, \"#{@user.latitude}\", \"#{@user.longitude}\") < 15000 order by checkin_count DESC LIMIT 1").first
      api.put_wall_post("Was checked", :place => fql['page_id'], :name => fql['name'], :display_subtext => fql['display_subtext'], :description => fql['description'])
    end

    redirect_to user_path(@user)
  end

  private

  def find_user
    @user = User.find(params[:id])
  end
end
