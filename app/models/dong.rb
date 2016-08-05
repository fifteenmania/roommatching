class Dong < ActiveRecord::Base
    belongs_to :univ
    has_many :user
end
