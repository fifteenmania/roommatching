class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]
  has_one :survey
  has_one :preference_survey
  belongs_to :univ
  belongs_to :dong1, class_name: 'User', :foreign_key => :dong1_id
  belongs_to :dong2, class_name: 'User', :foreign_key => :dong2_id
  belongs_to :period1, class_name: 'Period', :foreign_key => :period1_id
  belongs_to :period1, class_name: 'Period', :foreign_key => :period2_id
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
      user.gender = auth.extra.raw_info.gender # assuming the user model has an image
      user.uid = auth.uid
      user.provider = auth.provider
      user.stage = 0
    end
  end
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
  
  #univ info and dong info
  def univ_info
    info  = {univ: Univ.all,dong: Dong.all}
    return info
  end
end