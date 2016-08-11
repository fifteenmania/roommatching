class Period < ActiveRecord::Base
    serialize :metadata, Oj
    
    belongs_to :univ
    has_many :users
end
