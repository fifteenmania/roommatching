class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :survey
  has_one :preference_survey
  belongs_to :univ
  belongs_to :dong1, class_name: 'User', :foreign_key => :dong1_id
  belongs_to :dong2, class_name: 'User', :foreign_key => :dong2_id
  belongs_to :period1, class_name: 'Period', :foreign_key => :period1_id
  belongs_to :period1, class_name: 'Period', :foreign_key => :period2_id
  
end
