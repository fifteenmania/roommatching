class Period < ActiveRecord::Base
    belongs_to :univ
    has_many :users
end
