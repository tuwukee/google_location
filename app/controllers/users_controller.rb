class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @json = @user.to_gmaps4rails
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
  end

  def wall_post
    @user = User.find(params[:id])
    auth = @user.authentications.find(:first, :conditions => { :provider => 'facebook' })

    if auth
      graph = Koala::Facebook::GraphAPI.new(auth.token)
      profile = graph.get_object("me")
      graph.put_wall_post("Testing Koala")
    end

    redirect_to user_path(@user)

    #token = oauth.get_access_token(params[:code])
    #graph = Koala::Facebook::API.new token
    #p graph.put_wall_post("explodingdog!", {
    #  :link => "http://youtube.com/",
    #  :caption => "Youtube",
    #  :actions => [{:name => "Share", :link => "http://google.com"}].to_json
    #})
  end
end
