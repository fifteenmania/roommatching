class Univ < ActiveRecord::Base
    has_many :users
    has_many :periods
    has_many :dongs
end
