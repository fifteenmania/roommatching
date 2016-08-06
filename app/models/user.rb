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
    info  = {univ: Univ.all}
    return info
  end
  
  def register_profile(info)
    self.name = info[:name]
    # self.birth = info.birth
    self.univ_id = info[:univ]
    self.major = info[:major]
    self.stage = 1
    self.save
  end
  
  def profile_info
    result = {myinfo:{name:self.name,univ:self.univ,birth:self.birth,major:self.major},univ: Univ.all}
    return result
  end
  
  def update_dorm_survey(info)
    self.dong1_id = info[:dong1_id]
    self.dong2_id = info[:dong2_id]
    self.period1_id = info[:period1_id]
    self.period2_id = info[:period2_id]
    self.save
  end
  
  def dorm_survey_info
    myuniv = self.univ
    result = {dorminfo:{univ:self.univ,dong1_id:self.dong1_id,dong2_id:self.dong2_id,period1_id:self.period1_id,period2_id:self.period2_id},dong: myuniv.dong,period: myuniv.period.where(in_progress:true)}
    return result
  end
  
  
  
  #-------------- matching ------------ #
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
    top_users = fitnesses.sort.reverse[0..2]
    
    return top_users
  end
  
end