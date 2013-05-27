class StaticPagesController < ApplicationController
  def home
    @json = User.all(:order => 'RANDOM()', :limit => 10).to_gmaps4rails
  end
end
