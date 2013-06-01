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
      #profile = api.get_object("me")
      #places = Gmaps4rails.places(@user.latitude, @user.longitude, 'AIzaSyCZ7-of4m82izg9DPJrUw9XGHQBwzC1Ac0', keyword = nil, radius = 7500, lang="en", raw = false, protocol = 'https')
      #location = places.last[:vicinity] || places.last[:name]
      fql = api.fql_query("SELECT page_id, name, description, display_subtext FROM place WHERE distance(latitude, longitude, \"#{@user.latitude}\", \"#{@user.longitude}\") < 15000 order by checkin_count DESC LIMIT 1").first
      api.put_wall_post("Was checked", :place => fql['page_id'], :name => fql['name'], :display_subtext => 'Hola', :description => fql['description'])
    end

    redirect_to user_path(@user)
  end

  private

  def find_user
    @user = User.find(params[:id])
  end
end
