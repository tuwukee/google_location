class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :name,
                  :longitude, :latitude

  has_many :authentications, :dependent => :delete_all

  acts_as_gmappable :validation => false

   validates_presence_of :name

  def apply_omniauth(auth)
    self.email = auth['extra']['raw_info']['email']
    self.name = auth['info']['name']

    authentications.build(:provider => auth['provider'], :uid => auth['uid'], :token => auth['credentials']['token'])
  end

  def gmaps4rails_address
    "#{address}"
  end
end
