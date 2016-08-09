class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]
  has_one :survey
  has_one :preference_survey
  belongs_to :univ
  belongs_to :dong1, class_name: 'Dong', foreign_key: "dong1_id"
  belongs_to :dong2, class_name: 'Dong', foreign_key: "dong2_id"
  belongs_to :period1, class_name: 'Period', foreign_key: "period1_id"
  belongs_to :period2, class_name: 'Period', foreign_key: "period2_id"
  scope :all_except, ->(user) { where.not(id: user) }
  
  
  @@basic_info = [:image, :email, :stage]
  @@profile = [:name, :univ, :birth, :major]
  MATCH_NUM = 3
  
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
  
  def basic_info
    return @@basic_info
  end
  
  def basic_info_as_json
    return self.as_json(only: @@basic_info)
  end
  
  def profile
    return @@profile
  end
  
  def profile_as_json
    return self.as_json(only: @@profile)
  end
  
  #-------------- matching -------------- #
  def matching_fitness(user)
    fitness = 0
    self_survey = self.preference_survey
    user_survey = user.survey
    if self_survey.sociality == user_survey.sociality then fitness += 1 end
    if self_survey.familiarity == user_survey.familiarity then fitness += 1 end
    if self_survey.awaken == user_survey.awaken then fitness += 1 end
    if self_survey.smoke == user_survey.smoke then fitness += 1 end
    if self_survey.game == user_survey.game then fitness += 1 end
    if self_survey.waketime == user_survey.waketime then fitness += 1 end
    return fitness
  end
  
  def find_match
    ## fix: have to add some conditions for matching(gender, dorm, ..).
    ## ex) User.all_except(self).where(gender: self.gender)
    users = User.all_except(self).where(stage: 4)
    fitnesses = Array.new(users.length)
    
    # calculate matching fitnesses with all the matchable users.
    users.each_with_index do |user, i|
      fitnesses[i] = [self.matching_fitness(user), user]
    end
    
    # pick top three best-fit users and match the current user with them.
    top_users = fitnesses.sort.reverse.first(MATCH_NUM)
    
    return top_users
  end
  
end
