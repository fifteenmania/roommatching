class Dong < ActiveRecord::Base
    serialize :metadata, Oj
    
    belongs_to :univ, dependent: :destroy
    has_many :users
end
