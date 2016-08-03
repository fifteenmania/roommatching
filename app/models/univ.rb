class Univ < ActiveRecord::Base
    has_many :user
    has_many :period
end
